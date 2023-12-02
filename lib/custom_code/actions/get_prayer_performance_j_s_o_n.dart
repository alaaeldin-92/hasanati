// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<String>?> getPrayerPerformanceJSON(
    String userId, DateTime from, DateTime to) async {
  final firestore = FirebaseFirestore.instance;

  final startDayString = fromDateToString(from);
  final endDayString = fromDateToString(to);

  final querySnapshot = await firestore
      .collection('prayerPerformance')
      .where('user', isEqualTo: userId)
      .where('day', isGreaterThanOrEqualTo: startDayString)
      .where('day', isLessThanOrEqualTo: endDayString)
      .get();

  final documents = querySnapshot.docs;
  final jsonList =
      documents.map((doc) => doc.data() as Map<String, dynamic>).toList();

  // Convert to a simple JSON format and then to JSON strings
  final simpleJsonList =
      jsonList.map((json) => Map<String, dynamic>.from(json)).toList();
  final jsonStrings = simpleJsonList.map((json) => jsonEncode(json)).toList();

  return jsonStrings;
}

String fromDateToString(DateTime date) {
  final formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(date);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
