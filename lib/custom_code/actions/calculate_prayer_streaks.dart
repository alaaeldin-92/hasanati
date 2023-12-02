// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<int>> calculatePrayerStreaks(String userId) async {
  final firestore = FirebaseFirestore.instance;
  final querySnapshot = await firestore
      .collection('prayerPerformance')
      .where('user', isEqualTo: userId)
      .orderBy('day', descending: true)
      .get();

  List<int> streaks = List.filled(5, 0);

  bool isOneDayDifference(int day1, int day2) {
    final differenceInSeconds = (day1 - day2).abs();
    return differenceInSeconds == 86400;
  }

  // fajr
  int counter = 0;
  Map<String, dynamic> previousData = {};
  for (final doc in querySnapshot.docs) {
    final data = doc.data();
    bool prayerValue = false;
    if (data.containsKey('fajr')) {
      prayerValue = data['fajr'];
    }
    if (counter == 0 || counter == 1) {
      // For the first two docs document, increment streak if it's true
      if (prayerValue) {
        streaks[0]++;
      }
    } else {
      // For subsequent documents, increment streak based on conditions

      if (prayerValue &&
          previousData.containsKey('fajr') &&
          previousData['fajr'] == true &&
          isOneDayDifference(data['day'], previousData['day'])) {
        streaks[0]++;
      } else {
        break;
      }
    }
    // Store all doc fields for the next iteration
    previousData = Map.from(data); // Copy all fields from the current doc
    counter++;
  }

  // duhr
  counter = 0;
  for (final doc in querySnapshot.docs) {
    final data = doc.data();
    bool prayerValue = false;
    if (data.containsKey('duhr')) {
      prayerValue = data['duhr'];
    }
    if (counter == 0 || counter == 1) {
      // For the first two docs document, increment streak if it's true
      if (prayerValue) {
        streaks[1]++;
      }
    } else {
      // For subsequent documents, increment streak based on conditions

      if (prayerValue &&
          previousData.containsKey('duhr') &&
          previousData['duhr'] == true &&
          isOneDayDifference(data['day'], previousData['day'])) {
        streaks[1]++;
      } else {
        break;
      }
    }
    // Store all doc fields for the next iteration
    previousData = Map.from(data); // Copy all fields from the current doc
    counter++;
  }

  // asr
  counter = 0;
  for (final doc in querySnapshot.docs) {
    final data = doc.data();
    bool prayerValue = false;
    if (data.containsKey('asr')) {
      prayerValue = data['asr'];
    }
    if (counter == 0 || counter == 1) {
      // For the first two docs document, increment streak if it's true
      if (prayerValue) {
        streaks[2]++;
      }
    } else {
      // For subsequent documents, increment streak based on conditions

      if (prayerValue &&
          previousData.containsKey('asr') &&
          previousData['asr'] == true &&
          isOneDayDifference(data['day'], previousData['day'])) {
        streaks[2]++;
      } else {
        break;
      }
    }
    // Store all doc fields for the next iteration
    previousData = Map.from(data); // Copy all fields from the current doc
    counter++;
  }

  // maghrib
  counter = 0;

  for (final doc in querySnapshot.docs) {
    final data = doc.data();
    bool prayerValue = false;
    if (data.containsKey('maghrib')) {
      prayerValue = data['maghrib'];
    }
    if (counter == 0 || counter == 1) {
      // For the first two docs document, increment streak if it's true
      if (prayerValue) {
        streaks[3]++;
      }
    } else {
      // For subsequent documents, increment streak based on conditions

      if (prayerValue &&
          previousData.containsKey('maghrib') &&
          previousData['maghrib'] == true &&
          isOneDayDifference(data['day'], previousData['day'])) {
        streaks[3]++;
      } else {
        break;
      }
    }
    // Store all doc fields for the next iteration
    previousData = Map.from(data); // Copy all fields from the current doc
    counter++;
  }

  // isha
  counter = 0;
  for (final doc in querySnapshot.docs) {
    final data = doc.data();
    bool prayerValue = false;
    if (data.containsKey('isha')) {
      prayerValue = data['isha'];
    }
    if (counter == 0 || counter == 1) {
      // For the first two docs document, increment streak if it's true
      if (prayerValue) {
        streaks[4]++;
      }
    } else {
      // For subsequent documents, increment streak based on conditions

      if (prayerValue &&
          previousData.containsKey('isha') &&
          previousData['isha'] == true &&
          isOneDayDifference(data['day'], previousData['day'])) {
        streaks[4]++;
      } else {
        break;
      }
    }
    // Store all doc fields for the next iteration
    previousData = Map.from(data); // Copy all fields from the current doc
    counter++;
  }

  return streaks;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
