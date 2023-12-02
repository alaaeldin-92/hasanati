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

import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter_localizations/flutter_localizations.dart';

class QuranTextContainer extends StatefulWidget {
  const QuranTextContainer(
      {Key? key, this.width, this.height, this.quranAyahVerseByKeyResponse})
      : super(key: key);

  final double? width;
  final double? height;

  final dynamic quranAyahVerseByKeyResponse;

  @override
  _QuranTextContainerState createState() => _QuranTextContainerState();
}

class _QuranTextContainerState extends State<QuranTextContainer> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Align(
          alignment: AlignmentDirectional(1.00, -1.00),
          child: Builder(
            builder: (context) {
              final verseWords = functions
                  .reverseJsonArray(
                      widget.quranAyahVerseByKeyResponse, 'desc', 'id')
                  .toList();
              return Wrap(
                spacing: 0,
                runSpacing: 0,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.end,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: List.generate(verseWords.length, (verseWordsIndex) {
                  final verseWordsItem = verseWords[verseWordsIndex];
                  return custom_widgets.QuranTextFont(
                    width: 120,
                    height: 100,
                    text: getJsonField(
                      verseWordsItem,
                      r'''$.code_v1''',
                    ).toString(),
                    pageNum: getJsonField(
                      verseWordsItem,
                      r'''$.page_number''',
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
