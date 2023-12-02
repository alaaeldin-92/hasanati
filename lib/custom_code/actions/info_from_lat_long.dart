// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geocoding/geocoding.dart';

Future<String?> infoFromLatLong(LatLng location, String property) async {
  // custom action that takes in google lat and long and returns street address
  // Import necessary packages

  // Call the reverse geocoding function to get the address from the latitude and longitude
  List<Placemark> placemarks =
      await placemarkFromCoordinates(location.latitude!, location.longitude!);

  if (property == "street") {
    return placemarks[0].street!;
  } else if (property == "country") {
    return placemarks[0].country!;
  } else if (property == "isoCountryCode") {
    return placemarks[0].isoCountryCode!;
  } else if (property == "administrativeArea") {
    return placemarks[0].administrativeArea!;
  } else if (property == "city") {
    return placemarks[0].locality!;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
