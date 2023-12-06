// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;

Future sendForegroundPushMessage(
    String fcmToken, String body, String title) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAIzWC8Xw:APA91bG-UuaEMpWB5CKC722nLUDG3NF-KHlDoYF8GR7bCDohBhb1C0HLvSx67XDbWVLldrEihrbYXN-vB6G1OSLChb7Z6VYQc6pthqBITlIZPiWNCdPMuI0cNyhY2S5Qc1f7l7gZanYm',
      },
      body: jsonEncode(<String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
        "notification": <String, dynamic>{
          "title": title,
          "body": body,
          "android_channel_id": "dbfood"
        },
        "to": fcmToken,
      }),
    );
  } catch (e) {
    // print(e.toString());
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
