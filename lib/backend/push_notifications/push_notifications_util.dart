import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'serialization_util.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../cloud_functions/cloud_functions.dart';

import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;  // new
import 'dart:convert';  // new
export 'push_notifications_handler.dart';
export 'serialization_util.dart';

const kUserPushNotificationsCollectionName = 'ff_user_push_notifications';

class UserTokenInfo {
  const UserTokenInfo(this.userPath, this.fcmToken);
  final String userPath;
  final String fcmToken;
}

Stream<UserTokenInfo> getFcmTokenStream(String userPath) =>
    Stream.value(!kIsWeb && (Platform.isIOS || Platform.isAndroid))
        .where((shouldGetToken) => shouldGetToken)
        .asyncMap<String?>(
            (_) => FirebaseMessaging.instance.requestPermission().then(
                  (settings) => settings.authorizationStatus ==
                          AuthorizationStatus.authorized
                      ? FirebaseMessaging.instance.getToken()
                      : null,
                ))
        .switchMap((fcmToken) => Stream.value(fcmToken)
            .merge(FirebaseMessaging.instance.onTokenRefresh))
        .where((fcmToken) => fcmToken != null && fcmToken.isNotEmpty)
        .map((token) => UserTokenInfo(userPath, token!));
final fcmTokenUserStream = authenticatedUserStream
    .where((user) => user != null)
    .map((user) => user!.reference.path)
    .distinct()
    .switchMap(getFcmTokenStream)
    .map(
      (userTokenInfo) => makeCloudCall(
        'addFcmToken',
        {
          'userDocPath': userTokenInfo.userPath,
          'fcmToken': userTokenInfo.fcmToken,
          'deviceType': Platform.isIOS ? 'iOS' : 'Android',
        },
      ),
    );

void triggerPushNotification({
  required String? notificationTitle,
  required String? notificationText,
  String? notificationImageUrl,
  DateTime? scheduledTime,
  String? notificationSound,
  required List<DocumentReference> userRefs,
  required String initialPageName,
  required Map<String, dynamic> parameterData,
}) {
  if ((notificationTitle ?? '').isEmpty || (notificationText ?? '').isEmpty) {
    return;
  }
  final serializedParameterData = serializeParameterData(parameterData);
  final pushNotificationData = {
    'notification_title': notificationTitle,
    'notification_text': notificationText,
    if (notificationImageUrl != null)
      'notification_image_url': notificationImageUrl,
    if (scheduledTime != null) 'scheduled_time': scheduledTime,
    if (notificationSound != null) 'notification_sound': notificationSound,
    'user_refs': userRefs.map((u) => u.path).join(','),
    'initial_page_name': initialPageName,
    'parameter_data': serializedParameterData,
    'sender': currentUserReference,
    'timestamp': DateTime.now(),
  };
  FirebaseFirestore.instance
      .collection(kUserPushNotificationsCollectionName)
      .doc()
      .set(pushNotificationData);
}


Future<void> triggerForegroundPushNotification({
  required String? notificationTitle,
  required String? notificationText,
  String? notificationImageUrl,
  DateTime? scheduledTime,
  String? notificationSound,
  required List<String> userTokens, // Use FCM tokens instead of DocumentReferences
  required String initialPageName,
  required Map<String, dynamic> parameterData,
}) async {
  if ((notificationTitle ?? '').isEmpty || (notificationText ?? '').isEmpty) {
    return;
  }

  final serializedParameterData = serializeParameterData(parameterData);

  final pushNotificationData = {
    'notification': {
      'title': notificationTitle,
      'body': notificationText,
      if (notificationImageUrl != null) 'image_url': notificationImageUrl,
    },
    'data': {
      'scheduled_time': scheduledTime?.toUtc().toIso8601String(),
      'sound': notificationSound,
      'initial_page_name': initialPageName,
      'parameter_data': serializedParameterData,
    },
    'registration_ids': userTokens,
  };

  // Send the notification using a server (Cloud Function, backend server, etc.)
  // Example: Use http package to send the notification to FCM
  // Replace 'YOUR_FCM_SERVER_URL' with your server endpoint
  await http.post(
    Uri.parse('AAAAIzWC8Xw:APA91bG-UuaEMpWB5CKC722nLUDG3NF-KHlDoYF8GR7bCDohBhb1C0HLvSx67XDbWVLldrEihrbYXN-vB6G1OSLChb7Z6VYQc6pthqBITlIZPiWNCdPMuI0cNyhY2S5Qc1f7l7gZanYm'),  // FCM SERVER URL
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(pushNotificationData),
  );
}