import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/circular_progress_widget.dart';
import '/components/connector_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'prayer_widget.dart' show PrayerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PrayerModel extends FlutterFlowModel<PrayerWidget> {
  ///  Local state fields for this page.

  bool hideLottie = true;

  bool gridView = true;

  String timePeriod = 'Week';

  String dayOfTheWeekSet = 'Monday';

  int index = 0;

  String? city = '';

  String? countryISO = '';

  dynamic prayerTimesToday;

  List<int> streaks = [];
  void addToStreaks(int item) => streaks.add(item);
  void removeFromStreaks(int item) => streaks.remove(item);
  void removeAtIndexFromStreaks(int index) => streaks.removeAt(index);
  void insertAtIndexInStreaks(int index, int item) =>
      streaks.insert(index, item);
  void updateStreaksAtIndex(int index, Function(int) updateFn) =>
      streaks[index] = updateFn(streaks[index]);

  dynamic prayerTimesTomorrow;

  String nextPrayerIn = '';

  int dayPerformance = 0;

  List<dynamic> prayerPerfJSON = [];
  void addToPrayerPerfJSON(dynamic item) => prayerPerfJSON.add(item);
  void removeFromPrayerPerfJSON(dynamic item) => prayerPerfJSON.remove(item);
  void removeAtIndexFromPrayerPerfJSON(int index) =>
      prayerPerfJSON.removeAt(index);
  void insertAtIndexInPrayerPerfJSON(int index, dynamic item) =>
      prayerPerfJSON.insert(index, item);
  void updatePrayerPerfJSONAtIndex(int index, Function(dynamic) updateFn) =>
      prayerPerfJSON[index] = updateFn(prayerPerfJSON[index]);

  int monthIndex = 0;

  int yearIndex = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - calculatePrayerStreaks] action in Prayer widget.
  List<int>? streakRes;
  // Stores action output result for [Backend Call - API (GEO Address)] action in Prayer widget.
  ApiCallResponse? geoAdd;
  // Stores action output result for [Custom Action - calculatePerformanceForDay] action in Prayer widget.
  int? percent;
  // Stores action output result for [Backend Call - API (Prayer Times)] action in Prayer widget.
  ApiCallResponse? prayerTimesJSON;
  // Stores action output result for [Backend Call - API (Prayer Times)] action in Prayer widget.
  ApiCallResponse? prayerTimesTmrwJSON;
  InstantTimer? instantTimer;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    instantTimer?.cancel();
  }

  /// Action blocks are added here.

  Future onBoxClick(
    BuildContext context, {
    required String? prayerName,
    required String? currentDay,
    required PrayerPerformanceRecord? doc,
  }) async {
    int? percent;
    List<int>? streakRes;

    if (functions.getUnixTimeWithIndexAndDay(
            index, currentDay!, getCurrentTimestamp) <=
        functions.getUnixTimeWithIndexAndDay(
            0,
            functions.datetimeToDay(getCurrentTimestamp),
            getCurrentTimestamp)) {
      if ((doc != null) &&
          () {
            if (prayerName == 'Fajr') {
              return (doc?.fajr == true);
            } else if (prayerName == 'Dhuhr') {
              return (doc?.duhr == true);
            } else if (prayerName == 'Asr') {
              return (doc?.asr == true);
            } else if (prayerName == 'Maghrib') {
              return (doc?.maghrib == true);
            } else {
              return (doc?.isha == true);
            }
          }()) {
        if (prayerName == 'Fajr') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            fajr: false,
          ));
        } else if (prayerName == 'Dhuhr') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            duhr: false,
          ));
        } else if (prayerName == 'Asr') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            asr: false,
          ));
        } else if (prayerName == 'Maghrib') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            maghrib: false,
          ));
        } else {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            isha: false,
          ));
        }
      } else if ((doc != null) &&
          () {
            if (prayerName == 'Fajr') {
              return (doc?.fajr == false);
            } else if (prayerName == 'Dhuhr') {
              return (doc?.duhr == false);
            } else if (prayerName == 'Asr') {
              return (doc?.asr == false);
            } else if (prayerName == 'Maghrib') {
              return (doc?.maghrib == false);
            } else {
              return (doc?.isha == false);
            }
          }()) {
        if (prayerName == 'Fajr') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            fajr: true,
          ));
        } else if (prayerName == 'Dhuhr') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            duhr: true,
          ));
        } else if (prayerName == 'Asr') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            asr: true,
          ));
        } else if (prayerName == 'Maghrib') {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            maghrib: true,
          ));
        } else {
          await doc!.reference.update(createPrayerPerformanceRecordData(
            isha: true,
          ));
        }
      } else {
        if (prayerName == 'Fajr') {
          await PrayerPerformanceRecord.collection
              .doc()
              .set(createPrayerPerformanceRecordData(
                user: currentUserUid,
                day: functions.getUnixTimeWithIndexAndDay(
                    index, currentDay!, getCurrentTimestamp),
                fajr: true,
              ));
        } else if (prayerName == 'Dhuhr') {
          await PrayerPerformanceRecord.collection
              .doc()
              .set(createPrayerPerformanceRecordData(
                user: currentUserUid,
                day: functions.getUnixTimeWithIndexAndDay(
                    index, currentDay!, getCurrentTimestamp),
                duhr: true,
              ));
        } else if (prayerName == 'Asr') {
          await PrayerPerformanceRecord.collection
              .doc()
              .set(createPrayerPerformanceRecordData(
                user: currentUserUid,
                day: functions.getUnixTimeWithIndexAndDay(
                    index, currentDay!, getCurrentTimestamp),
                asr: true,
              ));
        } else if (prayerName == 'Maghrib') {
          await PrayerPerformanceRecord.collection
              .doc()
              .set(createPrayerPerformanceRecordData(
                user: currentUserUid,
                day: functions.getUnixTimeWithIndexAndDay(
                    index, currentDay!, getCurrentTimestamp),
                maghrib: true,
              ));
        } else {
          await PrayerPerformanceRecord.collection
              .doc()
              .set(createPrayerPerformanceRecordData(
                user: currentUserUid,
                day: functions.getUnixTimeWithIndexAndDay(
                    index, currentDay!, getCurrentTimestamp),
                isha: true,
              ));
        }
      }

      percent = await actions.calculatePerformanceForDay(
        functions.getUnixTimeWithIndexAndDay(0,
            functions.datetimeToDay(getCurrentTimestamp), getCurrentTimestamp),
        currentUserUid,
      );
      dayPerformance = percent!;
      streakRes = await actions.calculatePrayerStreaks(
        currentUserUid,
      );
      streaks = streakRes!.toList().cast<int>();
    }
  }

  /// Additional helper methods are added here.
}
