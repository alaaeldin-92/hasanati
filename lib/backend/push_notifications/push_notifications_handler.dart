import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Home': ParameterData.none(),
  'QuranAyah': (data) async => ParameterData(
        allParams: {
          'surahID': getParameter<int>(data, 'surahID'),
          'ayahNumber': getParameter<int>(data, 'ayahNumber'),
          'versesCount': getParameter<int>(data, 'versesCount'),
          'surahName': getParameter<String>(data, 'surahName'),
        },
      ),
  'SearchQuran': ParameterData.none(),
  'Settings': ParameterData.none(),
  'Leaderboard': ParameterData.none(),
  'AuthMain2': ParameterData.none(),
  'AuthVerifyEmail': (data) async => ParameterData(
        allParams: {
          'email': getParameter<String>(data, 'email'),
          'password': getParameter<String>(data, 'password'),
        },
      ),
  'AuthCompleteProfile2': ParameterData.none(),
  'PrayerStrict': ParameterData.none(),
  'Prayer': ParameterData.none(),
  'Azkar': (data) async => ParameterData(
        allParams: {
          'id': getParameter<int>(data, 'id'),
          'title': getParameter<String>(data, 'title'),
        },
      ),
  'Welcome': ParameterData.none(),
  'Friends': ParameterData.none(),
  'Later': ParameterData.none(),
  'Profile': (data) async => ParameterData(
        allParams: {
          'userId': getParameter<String>(data, 'userId'),
        },
      ),
  'Subscribe': ParameterData.none(),
  'Onboarding': ParameterData.none(),
  'OnboardingTwo': ParameterData.none(),
  'Introduction': ParameterData.none(),
  'AuthMain': ParameterData.none(),
  'AuthCompleteProfile2Copy': ParameterData.none(),
  'AuthCompleteProfile1': ParameterData.none(),
  'AuthForgotPassword': ParameterData.none(),
  'QuranPage': (data) async => ParameterData(
        allParams: {
          'page': getParameter<int>(data, 'page'),
        },
      ),
  'Notification': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
