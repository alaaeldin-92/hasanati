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

class QuranTextFont extends StatefulWidget {
  const QuranTextFont(
      {Key? key, this.width, this.height, this.text = "", this.pageNum = 1})
      : super(key: key);

  final double? width;
  final double? height;
  final String text;
  final int pageNum;

  @override
  _QuranTextFontState createState() => _QuranTextFontState();
}

class _QuranTextFontState extends State<QuranTextFont> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          fontFamily: (widget.pageNum.toString().length == 1)
              ? 'P00' + widget.pageNum.toString()
              : (widget.pageNum.toString().length == 2)
                  ? 'P0' + widget.pageNum.toString()
                  : 'P' +
                      widget.pageNum
                          .toString(), // Use the font family you provided in FlutterFlow
          fontSize: 24.0,
          color: Colors.black),
      textAlign: TextAlign.right,
    );
  }
}
