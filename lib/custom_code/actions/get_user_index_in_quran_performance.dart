// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> getUserIndexInQuranPerformance(
  String sortBy,
  String userID,
) async {
  try {
    // Initialize Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the "quranPerformance" collection
    CollectionReference quranPerformanceCollection =
        firestore.collection('quranPerformance');

    // Query the collection and sort by the specified field in descending order
    QuerySnapshot querySnapshot = await quranPerformanceCollection
        .orderBy(sortBy, descending: true)
        .get();

    // Extract the documents as a List of Maps
    List<Map<String, dynamic>> documents = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Find the index in the JSON list where the "user" field matches the provided userID
    int index = documents.indexWhere((document) => document['user'] == userID);

    return index + 1;
  } catch (error) {
    return -1; // Return -1 in case of an error or if the user is not found
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
