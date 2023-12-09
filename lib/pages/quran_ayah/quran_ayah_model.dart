import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/reciter_widget.dart';
import '/components/tafsir_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'quran_ayah_widget.dart' show QuranAyahWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class QuranAyahModel extends FlutterFlowModel<QuranAyahWidget> {
  ///  Local state fields for this page.

  bool audioPlaying = false;

  bool hearted = false;

  int? verseLikesNum = 0;

  bool memorized = false;

  int? surahID;

  int? verseID;

  int? versesCount;

  String surahName = '';

  double? timeCounter = 0.0;

  double? audioDuration = 0.0;

  bool hideLottie = true;

  int? timeReadCounter = 0;

  int? tempCounter = 0;

  double audioSingleDuration = 0.0;

  bool audioLoading = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  QuranPerformanceRecord? syncQuranPerformance;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  QuranLastReadVerseRecord? syncLastRead;
  // Stores action output result for [Backend Call - API (Verse Audio)] action in Container widget.
  ApiCallResponse? audioJSON;
  AudioPlayer? soundPlayer;
  // Stores action output result for [Custom Action - getAudioLength] action in Container widget.
  double? duration;
  // State field(s) for Loading widget.
  late bool loadingStatus;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    loadingStatus = false;
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Future updateLikesAndMem(BuildContext context) async {
    List<QuranVersesFavoriteRecord>? favQueryTraverse;

    favQueryTraverse = await queryQuranVersesFavoriteRecordOnce(
      queryBuilder: (quranVersesFavoriteRecord) =>
          quranVersesFavoriteRecord.where(
        'verse',
        arrayContains: '${surahID?.toString()}:${verseID?.toString()}',
      ),
    );
    verseLikesNum = favQueryTraverse?.length;
    if (FFAppState()
        .quranVersesFavorites
        .contains('${surahID?.toString()}:${verseID?.toString()}')) {
      hearted = true;
    } else {
      hearted = false;
    }

    if (FFAppState()
        .quranVersesMemorized
        .contains('${surahID?.toString()}:${verseID?.toString()}')) {
      memorized = true;
    } else {
      memorized = false;
    }
  }

  /// Additional helper methods are added here.
}
