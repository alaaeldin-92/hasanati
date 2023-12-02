import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/home_skeleton_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'home_widget.dart' show HomeWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  bool verseOfTheDayHearted = false;

  bool verseOfTheDayAudioPlaying = false;

  double verseOfTheDayTimeCounter = 0.0;

  double verseOfTheDayAudioDuration = 0.0;

  int verseOfTheDayChapter = 1;

  int verseOfTheDayVerse = 1;

  int verseOfTheDayLikesNum = 0;

  String quranChaptersOrder = 'asc';

  bool verseOfTheDayClaimed = false;

  bool pageLoading = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  QuranVerseOfTheDayRecord? verseOfTheDayQuery;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<QuranVersesFavoriteRecord>? favQueryVerseOfDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  QuranPerformanceRecord? userQuranPer;
  // Stores action output result for [Backend Call - API (Verse Audio)] action in Icon widget.
  ApiCallResponse? audioJSON;
  AudioPlayer? soundPlayer;
  // Stores action output result for [Custom Action - getAudioLength] action in Icon widget.
  double? duration;
  // Model for HomeSkeleton component.
  late HomeSkeletonModel homeSkeletonModel;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    homeSkeletonModel = createModel(context, () => HomeSkeletonModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  void dispose() {
    unfocusNode.dispose();
    homeSkeletonModel.dispose();
    navbarModel.dispose();
  }

  /// Action blocks are added here.

  Future initialCheck(BuildContext context) async {
    QuranPerformanceRecord? quranPerfQuery;

    if (false) {
      context.goNamed('AuthCompleteProfile1');
    }
    quranPerfQuery = await queryQuranPerformanceRecordOnce(
      queryBuilder: (quranPerformanceRecord) => quranPerformanceRecord.where(
        'user',
        isEqualTo: currentUserUid,
      ),
      singleRecord: true,
    ).then((s) => s.firstOrNull);
    if (!(quranPerfQuery != null)) {
      await QuranPerformanceRecord.collection
          .doc()
          .set(createQuranPerformanceRecordData(
            hasanat: 0,
            timeReadSec: 0,
            versesRead: 0,
            user: currentUserUid,
            lastmodified: getCurrentTimestamp.secondsSinceEpoch,
          ));
      verseOfTheDayChapter = random_data.randomInteger(1, 114);
      verseOfTheDayVerse = random_data.randomInteger(
          1,
          functions.getVersesCountFromId(
              functions.quranSurahEN()!, verseOfTheDayChapter));

      await QuranVerseOfTheDayRecord.collection
          .doc()
          .set(createQuranVerseOfTheDayRecordData(
            chapter: verseOfTheDayChapter,
            verse: random_data.randomInteger(
                1,
                functions.getVersesCountFromId(
                    functions.quranSurahEN()!, verseOfTheDayChapter)),
            claimed: false,
            nextUpdate:
                functions.add(getCurrentTimestamp.secondsSinceEpoch, 86400),
            user: currentUserUid,
          ));

      await QuranLastReadVerseRecord.collection
          .doc()
          .set(createQuranLastReadVerseRecordData(
            user: currentUserUid,
          ));

      await QuranVersesFavoriteRecord.collection
          .doc()
          .set(createQuranVersesFavoriteRecordData(
            user: currentUserUid,
          ));

      await QuranVersesMemorizeRecord.collection
          .doc()
          .set(createQuranVersesMemorizeRecordData(
            user: currentUserUid,
          ));

      await QuranLastReadPageRecord.collection
          .doc()
          .set(createQuranLastReadPageRecordData(
            user: currentUserUid,
          ));
    }
  }

  /// Additional helper methods are added here.
}
