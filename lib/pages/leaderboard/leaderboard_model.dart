import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'leaderboard_widget.dart' show LeaderboardWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class LeaderboardModel extends FlutterFlowModel<LeaderboardWidget> {
  ///  Local state fields for this page.

  bool toggleArrowFullScreen = false;

  String leaderboardChoice = 'Quran';

  String leaderboardQuranField = 'Hasanat';

  String leaderboardPrayerField = 'Total Avg';

  List<dynamic> displayedJSON = [];
  void addToDisplayedJSON(dynamic item) => displayedJSON.add(item);
  void removeFromDisplayedJSON(dynamic item) => displayedJSON.remove(item);
  void removeAtIndexFromDisplayedJSON(int index) =>
      displayedJSON.removeAt(index);
  void insertAtIndexInDisplayedJSON(int index, dynamic item) =>
      displayedJSON.insert(index, item);
  void updateDisplayedJSONAtIndex(int index, Function(dynamic) updateFn) =>
      displayedJSON[index] = updateFn(displayedJSON[index]);

  int currentPage = 0;

  int totalPages = 12;

  List<dynamic> top3JSON = [];
  void addToTop3JSON(dynamic item) => top3JSON.add(item);
  void removeFromTop3JSON(dynamic item) => top3JSON.remove(item);
  void removeAtIndexFromTop3JSON(int index) => top3JSON.removeAt(index);
  void insertAtIndexInTop3JSON(int index, dynamic item) =>
      top3JSON.insert(index, item);
  void updateTop3JSONAtIndex(int index, Function(dynamic) updateFn) =>
      top3JSON[index] = updateFn(top3JSON[index]);

  int userRank = 1;

  int totalRecords = 10;

  int hitsPerPage = 5;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getUserIndexInQuranPerformance] action in Leaderboard widget.
  int? index;
  // Stores action output result for [Firestore Query - Query a collection] action in Leaderboard widget.
  int? allRecords;
  // Stores action output result for [Custom Action - getUserIndexInQuranPerformance] action in Icon widget.
  int? indexCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  int? allRecordsCopy;
  // Stores action output result for [Custom Action - getUserIndexInQuranPerformance] action in Column widget.
  int? indexCopy2;
  // Stores action output result for [Firestore Query - Query a collection] action in Column widget.
  int? allRecordsCopy2;
  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 0;

  // Model for Navbar component.
  late NavbarModel navbarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  void dispose() {
    unfocusNode.dispose();
    navbarModel.dispose();
  }

  /// Action blocks are added here.

  Future updateJSON(BuildContext context) async {
    ApiCallResponse? jsonRes1;
    ApiCallResponse? jsonRes2;
    ApiCallResponse? jsonRes3;

    if (leaderboardChoice == 'Quran') {
      if (leaderboardQuranField == 'Hasanat') {
        jsonRes1 = await QuranLeaderboardCall.call(
          page: functions.add(currentPage, -1),
          hitsPerPage: hitsPerPage,
          attributesToRetrieveList:
              functions.quranHasanatAttributesToRetrieve(),
        );
        if ((jsonRes1?.succeeded ?? true)) {
          displayedJSON = getJsonField(
            (jsonRes1?.jsonBody ?? ''),
            r'''$.hits''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          totalPages = getJsonField(
            (jsonRes1?.jsonBody ?? ''),
            r'''$.nbPages''',
          );
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                  child: AlertDialog(
                title: Text('Error'),
                content: Text('Cannot update json'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('Ok'),
                  ),
                ],
              ));
            },
          );
        }
      } else if (leaderboardQuranField == 'Verses') {
        jsonRes2 = await QuranLeaderboardCall.call(
          page: functions.add(currentPage, -1),
          hitsPerPage: hitsPerPage,
          attributesToRetrieveList: functions.quranVersesAttributesToRetrieve(),
        );
        if ((jsonRes2?.succeeded ?? true)) {
          displayedJSON = getJsonField(
            (jsonRes2?.jsonBody ?? ''),
            r'''$.hits''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          totalPages = getJsonField(
            (jsonRes2?.jsonBody ?? ''),
            r'''$.nbPages''',
          );
        }
      } else {
        jsonRes3 = await QuranLeaderboardCall.call(
          page: functions.add(currentPage, -1),
          hitsPerPage: hitsPerPage,
          attributesToRetrieveList: functions.quranTimeAttributesToRetrieve(),
        );
        if ((jsonRes3?.succeeded ?? true)) {
          displayedJSON = getJsonField(
            (jsonRes3?.jsonBody ?? ''),
            r'''$.hits''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          totalPages = getJsonField(
            (jsonRes3?.jsonBody ?? ''),
            r'''$.nbPages''',
          );
        }
      }
    }
  }

  Future updateTop3JSON(BuildContext context) async {
    ApiCallResponse? jsonTop3Res1;
    ApiCallResponse? jsonTop3Res2;
    ApiCallResponse? jsonTop3Res3;

    if (leaderboardChoice == 'Quran') {
      if (leaderboardQuranField == 'Hasanat') {
        jsonTop3Res1 = await QuranLeaderboardCall.call(
          page: 0,
          hitsPerPage: 3,
          attributesToRetrieveList:
              functions.quranHasanatAttributesToRetrieve(),
        );
        if ((jsonTop3Res1?.succeeded ?? true)) {
          top3JSON = getJsonField(
            (jsonTop3Res1?.jsonBody ?? ''),
            r'''$.hits''',
            true,
          )!
              .toList()
              .cast<dynamic>();
        }
      } else if (leaderboardQuranField == 'Verses') {
        jsonTop3Res2 = await QuranLeaderboardCall.call(
          page: 0,
          hitsPerPage: 3,
          attributesToRetrieveList: functions.quranVersesAttributesToRetrieve(),
        );
        if ((jsonTop3Res2?.succeeded ?? true)) {
          top3JSON = getJsonField(
            (jsonTop3Res2?.jsonBody ?? ''),
            r'''$.hits''',
            true,
          )!
              .toList()
              .cast<dynamic>();
        }
      } else {
        jsonTop3Res3 = await QuranLeaderboardCall.call(
          page: 0,
          hitsPerPage: 3,
          attributesToRetrieveList: functions.quranTimeAttributesToRetrieve(),
        );
        if ((jsonTop3Res3?.succeeded ?? true)) {
          top3JSON = getJsonField(
            (jsonTop3Res3?.jsonBody ?? ''),
            r'''$.hits''',
            true,
          )!
              .toList()
              .cast<dynamic>();
        }
      }
    }
  }

  Future pageRefresh(BuildContext context) async {
    int? indexCopy2;
    int? allRecordsCopy2;

    unawaited(
      () async {
        await updateTop3JSON(context);
      }(),
    );
    displayedJSON = functions.defaultJSON().toList().cast<dynamic>();
    indexCopy2 = await actions.getUserIndexInQuranPerformance(
      'hasanat',
      currentUserUid,
    );
    allRecordsCopy2 = await queryQuranPerformanceRecordCount();
    userRank = index!;
    totalRecords = allRecords!;
    currentPage =
        functions.findUserPageInPagination(userRank, totalRecords, hitsPerPage);
    await updateJSON(context);
  }

  /// Additional helper methods are added here.
}
