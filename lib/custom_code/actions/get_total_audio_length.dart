// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<double> getTotalAudioLength(List<dynamic> jsonArray) async {
  double totalLength = 0;

  // Loop over all items in the JSON array
  for (var item in jsonArray) {
    // Extract the URL from the item
    // Call the getAudioLength function and add the result to the total length
    double audioLength =
        await getAudioLength("https://verses.quran.com/" + item["url"]);
    totalLength += audioLength;
  }

  return totalLength;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
