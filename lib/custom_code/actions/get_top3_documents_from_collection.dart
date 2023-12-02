// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<dynamic>> getTop3DocumentsFromCollection(String sortBy) async {
  try {
    // Initialize Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the "quranPerformance" collection
    CollectionReference quranPerformanceCollection =
        firestore.collection('quranPerformance');

    // Query the collection and sort by the specified field in descending order
    QuerySnapshot querySnapshot = await quranPerformanceCollection
        .orderBy(sortBy, descending: true)
        .limit(3) // Limit the result to the top 3 documents
        .get();

    // Extract the top 3 values of the specified field from each document
    List<dynamic> top3Documents =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    return top3Documents;
  } catch (error) {
    return [];
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
