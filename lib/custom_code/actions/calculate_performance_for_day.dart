// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> calculatePerformanceForDay(int unixTimestamp, String userId) async {
  try {
    // Replace 'prayerPerformance' with your actual collection name
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('prayerPerformance')
        .where('day', isEqualTo: unixTimestamp)
        .where('user', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return 0; // Document not found, return 0
    }

    DocumentSnapshot snapshot = querySnapshot.docs.first;

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    int counter = 0;
    if (data.containsKey('fajr')) {
      if (data['fajr'] == true) {
        counter++;
      }
    }
    if (data.containsKey('duhr')) {
      if (data['duhr'] == true) {
        counter++;
      }
    }
    if (data.containsKey('asr')) {
      if (data['asr'] == true) {
        counter++;
      }
    }
    if (data.containsKey('maghrib')) {
      if (data['maghrib'] == true) {
        counter++;
      }
    }
    if (data.containsKey('isha')) {
      if (data['isha'] == true) {
        counter++;
      }
    }

    double performance =
        (counter / 5.0) * 100; // Calculate the performance as a ratio

    // Return the performance rounded to the nearest integer
    return performance.round();
  } catch (e) {
    return 0; // Handle error by returning 0
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
