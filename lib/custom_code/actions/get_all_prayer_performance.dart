// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<dynamic>> getAllPrayerPerformance(
  String userId,
  int startTime,
  int endTime,
) async {
  final firestore = FirebaseFirestore.instance;

  // Initialize the list to store mapped items
  List<Map<String, dynamic>?> resultList = [];

  // Loop through days from startTime to endTime
  for (int currentDay = startTime; currentDay <= endTime; currentDay += 86400) {
    // Convert currentDay to DateTime and adjust for UTC+4
    final currentDateTime =
        DateTime.fromMillisecondsSinceEpoch(currentDay * 1000)
            .add(Duration(hours: 4));

    // Query Firestore for documents with matching userId and currentDay
    final querySnapshot = await firestore
        .collection('prayerPerformance')
        .where('user', isEqualTo: userId)
        .where('day', isEqualTo: currentDay)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If documents exist for the current day, add the first one to the resultList
      final data = querySnapshot.docs.first.data();
      resultList.add(Map.from(data));
    } else {
      // If no documents exist for the current day
      resultList.add({
        'day': currentDay,
        'user': userId,
        'fajr': false,
        'duhr': false,
        'asr': false,
        'maghrib': false,
        'isha': false,
      });
    }
  }

  return resultList;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
