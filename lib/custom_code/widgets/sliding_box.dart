// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_sliding_box/flutter_sliding_box.dart'
    as flutter_sliding_box;

class SlidingBox extends StatefulWidget {
  const SlidingBox({
    Key? key,
    this.width,
    this.height,
    this.children,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<Widget>? children;

  @override
  _SlidingBoxState createState() => _SlidingBoxState();
}

class _SlidingBoxState extends State<SlidingBox> {
  @override
  Widget build(BuildContext context) {
    return flutter_sliding_box.SlidingBox(
      body: widget.children != null
          ? Column(
              children: widget.children!,
            )
          : const Center(
              child: Text(
                "This is the sliding box widget",
                style: TextStyle(color: Colors.black),
              ),
            ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
