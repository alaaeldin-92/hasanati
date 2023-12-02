// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> checkPrayerStatus(
  String userId,
  String day,
  DateTime currentTime,
  int index,
  String prayerName,
) async {
  final firestore = FirebaseFirestore.instance;

  // Calculate the start of the week based on the current day
  DateTime startOfWeek = currentTime
      .subtract(Duration(days: currentTime.weekday - DateTime.monday));

  // Adjust the start of the week based on the index
  startOfWeek = startOfWeek.add(Duration(days: index * 7));

  // Define a map to map day names to their corresponding day indices
  Map<String, int> dayIndices = {
    'monday': 0,
    'tuesday': 1,
    'wednesday': 2,
    'thursday': 3,
    'friday': 4,
    'saturday': 5,
    'sunday': 6,
  };

  // Find the specified day in the week, or default to Monday
  int dayOffset = dayIndices[day.toLowerCase()] ?? 0;
  startOfWeek = startOfWeek.add(Duration(days: dayOffset));

  // Set the time to 12:00:00 AM UTC+4
  startOfWeek = DateTime(
    startOfWeek.year,
    startOfWeek.month,
    startOfWeek.day,
    12, // 12:00 hours
    0, // 0 minutes
    0, // 0 seconds
    0, // 0 milliseconds
  ).add(Duration(hours: 4)); // Adjust to UTC+4

  final endOfWeek = startOfWeek.add(Duration(days: 1)); // Go to the next day

  final querySnapshot = await firestore
      .collection('prayerPerformance')
      .where('user', isEqualTo: userId)
      .where('day', isGreaterThanOrEqualTo: startOfWeek, isLessThan: endOfWeek)
      .get();

  if (querySnapshot.docs.isEmpty) {
    // No document found for the specified day
    return false;
  }

  final data = querySnapshot.docs.first.data();

  if (data.containsKey(prayerName) && data[prayerName] == true) {
    return true;
  } else {
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
