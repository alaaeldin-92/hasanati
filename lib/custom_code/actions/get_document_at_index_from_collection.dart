// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> getDocumentAtIndexFromCollection(
    String sortBy, int index) async {
  try {
    // Initialize Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the "quranPerformance" collection
    CollectionReference quranPerformanceCollection =
        firestore.collection('quranPerformance');

    // Query the collection and sort by the specified field in descending order
    QuerySnapshot querySnapshot = await quranPerformanceCollection
        .orderBy(sortBy, descending: true)
        .startAfter([index]) // Start after the specified index
        .limit(1) // Limit the result to one document
        .get();

    // Check if any documents were found
    if (querySnapshot.docs.isNotEmpty) {
      // Extract the document at the specified index as a JSON object
      return querySnapshot.docs.first.data();
    } else {
      return null; // Return null if no documents were found at the specified index
    }
  } catch (error) {
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
