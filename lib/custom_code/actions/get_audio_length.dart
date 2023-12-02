// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:just_audio/just_audio.dart';

Future<double> getAudioLength(String audioURL) async {
  final player = AudioPlayer(); // Create a player
  await player.setUrl(audioURL); // Set the URL

  // Load the audio and wait for the duration to be set
  await player.load();

  // Get the duration in seconds
  final durationInSeconds = player.duration?.inSeconds.toDouble() ?? -1.0;

  // Dispose of the player when done
  await player.dispose();

  return durationInSeconds;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
