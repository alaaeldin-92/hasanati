import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/connector_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'prayer_strict_model.dart';
export 'prayer_strict_model.dart';

class PrayerStrictWidget extends StatefulWidget {
  const PrayerStrictWidget({Key? key}) : super(key: key);

  @override
  _PrayerStrictWidgetState createState() => _PrayerStrictWidgetState();
}

class _PrayerStrictWidgetState extends State<PrayerStrictWidget> {
  late PrayerStrictModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayerStrictModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      setState(() {
        _model.dayOfTheWeekSet = dateTimeFormat(
          'EEEE',
          getCurrentTimestamp,
          locale: FFLocalizations.of(context).languageCode,
        );
      });
      setState(() {
        _model.streaks = functions.defaultStreak().toList().cast<int>();
      });
      _model.geoAdd = await GEOAddressCall.call(
        loc: functions.destructureGeoPoint(currentUserLocationValue!),
      );
      _model.city = getJsonField(
        (_model.geoAdd?.jsonBody ?? ''),
        r'''$.results[-2].address_components[0].long_name''',
      ).toString().toString();
      _model.countryISO = getJsonField(
        (_model.geoAdd?.jsonBody ?? ''),
        r'''$.results[-1].address_components[0].short_name''',
      ).toString().toString();
      _model.prayerTimesJSON = await PrayerTimesCall.call(
        city: _model.city,
        country: _model.countryISO,
        date: functions.getDateFromDateTime(getCurrentTimestamp, 0),
      );
      if ((_model.prayerTimesJSON?.succeeded ?? true)) {
        setState(() {
          _model.prayerTimesToday = getJsonField(
            (_model.prayerTimesJSON?.jsonBody ?? ''),
            r'''$.data.timings''',
          );
        });
      }
      _model.prayerTimesTmrwJSON = await PrayerTimesCall.call(
        city: _model.city,
        country: _model.countryISO,
        date: functions.getDateFromDateTime(getCurrentTimestamp, 1),
      );
      if ((_model.prayerTimesTmrwJSON?.succeeded ?? true)) {
        setState(() {
          _model.prayerTimesTomorrow = getJsonField(
            (_model.prayerTimesTmrwJSON?.jsonBody ?? ''),
            r'''$.data.timings''',
          );
        });
      }
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 1000),
        callback: (timer) async {
          setState(() {
            _model.nextPrayerIn = functions.calculateNextPrayer(
                getCurrentTimestamp,
                _model.prayerTimesToday,
                _model.prayerTimesTomorrow);
          });
        },
        startImmediately: true,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF009BDF),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('Home');
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0070A3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 5.0, 10.0, 5.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timer_sharp,
                                      color: Color(0xFF6DD6FD),
                                      size: 20.0,
                                    ),
                                    Text(
                                      _model.nextPrayerIn,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: '72',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 5.0)),
                                ),
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.ellipsisH,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF025275),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 20.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  7.5,
                                                                  7.5,
                                                                  7.5,
                                                                  7.5),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.medal,
                                                        color:
                                                            Color(0xFF009BDF),
                                                        size: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'nghgfbus' /* November 3, 2023 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        '72',
                                                                    color: Colors
                                                                        .white,
                                                                    useGoogleFonts:
                                                                        false,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '5ds8z2h3' /* 56% Achieved */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        '72',
                                                                    color: Colors
                                                                        .white,
                                                                    useGoogleFonts:
                                                                        false,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 0.0,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100.0),
                                                              ),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.79,
                                                                height: 8.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100.0),
                                                                ),
                                                                child:
                                                                    LinearPercentIndicator(
                                                                  percent: 0.5,
                                                                  lineHeight:
                                                                      12.0,
                                                                  animation:
                                                                      false,
                                                                  animateFromLastPercent:
                                                                      true,
                                                                  progressColor:
                                                                      Color(
                                                                          0xFF009BDD),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent4,
                                                                  barRadius: Radius
                                                                      .circular(
                                                                          100.0),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 10.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 75.0, 0.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 110.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00191F),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 20.0, 20.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  7.5,
                                                                  7.5,
                                                                  7.5,
                                                                  7.5),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .userFriends,
                                                        color:
                                                            Color(0xFF009BDF),
                                                        size: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'y2xgthar' /* Online Friends */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: '72',
                                                          color: Colors.white,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 10.0)),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'edqvjma2' /* 20/30 Online */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: '72',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmVhbCUyMHBlb3BsZXxlbnwwfHwwfHx8MA%3D%3D',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    25.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyiZQJQ_lbGqDu9v04zHpDHqVRXUB-oOTZtg&usqp=CAU',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    50.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            'https://images.unsplash.com/photo-1463453091185-61582044d556?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmVhbCUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    75.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDd_LFpavoNIrdaDqPVDfPu_mcEF6CEoW6qQ&usqp=CAU',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    100.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLnAqlHRpvixM9cViXrPpIhwjpIcjLSxIIcg&usqp=CAU',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(SizedBox(width: 10.0)),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'f3sb53du' /* See All */,
                                                ),
                                                options: FFButtonOptions(
                                                  height: 35.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: Color(0xFF009BDF),
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: '72',
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        useGoogleFonts: false,
                                                      ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF00191F),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 120.0),
                            child: SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          functions
                                              .getDateRangeForWeekWithIndex(
                                                  _model.index,
                                                  getCurrentTimestamp),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFBDEAFD),
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 5.0, 5.0, 5.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    setState(() {
                                                      _model.gridView = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: _model.gridView ==
                                                              true
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  5.0,
                                                                  12.0,
                                                                  5.0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .gripHorizontal,
                                                        color:
                                                            Color(0xFF009BDD),
                                                        size: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    setState(() {
                                                      _model.gridView = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: _model.gridView ==
                                                              false
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  5.0,
                                                                  12.0,
                                                                  5.0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .alignLeft,
                                                        color:
                                                            Color(0xFF009BDD),
                                                        size: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.timePeriod = 'Week';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.timePeriod == 'Week'
                                                  ? Color(0xFFEEEEEE)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Opacity(
                                                  opacity: _model.timePeriod ==
                                                          'Week'
                                                      ? 1.0
                                                      : 0.4,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(15.0, 5.0,
                                                                15.0, 5.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'd5rreoq3' /* Week */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: '72',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                false,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.timePeriod = 'Month';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  _model.timePeriod == 'Month'
                                                      ? Color(0xFFEEEEEE)
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Opacity(
                                              opacity:
                                                  _model.timePeriod == 'Month'
                                                      ? 1.0
                                                      : 0.4,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 10.0, 15.0, 10.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '51icp97q' /* Month */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.timePeriod = 'Year';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.timePeriod == 'Year'
                                                  ? Color(0xFFEEEEEE)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Opacity(
                                              opacity:
                                                  _model.timePeriod == 'Year'
                                                      ? 1.0
                                                      : 0.4,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 10.0, 15.0, 10.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'of3hqtme' /* Year */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.timePeriod = 'All Time';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.timePeriod ==
                                                      'All Time'
                                                  ? Color(0xFFEEEEEE)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Opacity(
                                              opacity: _model.timePeriod ==
                                                      'All Time'
                                                  ? 1.0
                                                  : 0.4,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 10.0, 15.0, 10.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'l4knq8rc' /* All Time */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 2.5,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color(0xFF181D21)
                                                    : Color(0xFFEEEEEE),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: (_model.dayOfTheWeekSet ==
                                                        'Monday') &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'vk4v720l' /* M */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: (_model.dayOfTheWeekSet ==
                                                        'Tuesday') &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'g8z9agn3' /* T */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: (_model.dayOfTheWeekSet ==
                                                        'Wednesday') &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'dile87rk' /* W */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: (_model.dayOfTheWeekSet ==
                                                        'Thursday') &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'fpspj53u' /* T */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: (_model.dayOfTheWeekSet ==
                                                        'Friday') &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'bdxig6k5' /* F */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: (_model.dayOfTheWeekSet ==
                                                        'Saturday') &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'tj1pacj4' /* S */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          decoration: BoxDecoration(),
                                          child: Opacity(
                                            opacity: ((_model.dayOfTheWeekSet ==
                                                            'Sunday') &&
                                                        (_model.index == 0)) &&
                                                    (_model.index == 0)
                                                ? 1.0
                                                : 0.4,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '85i3ks1a' /* S */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 25.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Fajr ${getJsonField(
                                                        _model.prayerTimesToday,
                                                        r'''$.Fajr''',
                                                      ) != null ? getJsonField(
                                                      _model.prayerTimesToday,
                                                      r'''$.Fajr''',
                                                    ).toString() : ' '}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  '🔥${valueOrDefault<String>(
                                                    _model.streaks.first
                                                        .toString(),
                                                    '0',
                                                  )}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Monday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay: 'Monday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.fajr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Tuesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay: 'Tuesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.fajr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Wednesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay:
                                                              'Wednesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.fajr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Thursday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay:
                                                              'Thursday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.fajr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if ((functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp) <
                                                                    functions.getUnixTimeWithIndexAndDay(
                                                                        0,
                                                                        _model
                                                                            .dayOfTheWeekSet,
                                                                        getCurrentTimestamp)) ||
                                                                ((functions.getUnixTimeWithIndexAndDay(
                                                                            _model
                                                                                .index,
                                                                            'Thursday',
                                                                            getCurrentTimestamp) ==
                                                                        functions.getUnixTimeWithIndexAndDay(
                                                                            0,
                                                                            _model.dayOfTheWeekSet,
                                                                            getCurrentTimestamp)) &&
                                                                    false)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: (functions.getUnixTimeWithIndexAndDay(
                                                                              _model
                                                                                  .index,
                                                                              'Thursday',
                                                                              getCurrentTimestamp) ==
                                                                          functions.getUnixTimeWithIndexAndDay(
                                                                              0,
                                                                              functions.datetimeToDay(
                                                                                  getCurrentTimestamp),
                                                                              getCurrentTimestamp)) &&
                                                                      functions.isTimeForPrayer(
                                                                          'Fajr',
                                                                          getCurrentTimestamp,
                                                                          _model
                                                                              .prayerTimesToday,
                                                                          _model
                                                                              .prayerTimesTomorrow)
                                                                  ? Color(
                                                                      0xFF009BDD)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Friday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay: 'Friday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.fajr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Saturday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay:
                                                              'Saturday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.fajr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Sunday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Fajr',
                                                          currentDay: 'Sunday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.fajr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Duhr ${getJsonField(
                                                        _model.prayerTimesToday,
                                                        r'''$.Dhuhr''',
                                                      ) != null ? getJsonField(
                                                      _model.prayerTimesToday,
                                                      r'''$.Dhuhr''',
                                                    ).toString() : ' '}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  '🔥${valueOrDefault<String>(
                                                    _model.streaks[1]
                                                        .toString(),
                                                    '0',
                                                  )}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Monday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay: 'Monday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.duhr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'duhr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Tuesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay: 'Tuesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.duhr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'duhr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Wednesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay:
                                                              'Wednesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.duhr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'duhr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Thursday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay:
                                                              'Thursday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.duhr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: (functions.getUnixTimeWithIndexAndDay(
                                                                              _model
                                                                                  .index,
                                                                              'Thursday',
                                                                              getCurrentTimestamp) ==
                                                                          functions.getUnixTimeWithIndexAndDay(
                                                                              0,
                                                                              functions.datetimeToDay(
                                                                                  getCurrentTimestamp),
                                                                              getCurrentTimestamp)) &&
                                                                      functions.isTimeForPrayer(
                                                                          'Dhuhr',
                                                                          getCurrentTimestamp,
                                                                          _model
                                                                              .prayerTimesToday,
                                                                          _model
                                                                              .prayerTimesTomorrow)
                                                                  ? Color(
                                                                      0xFF009BDD)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'duhr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Friday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay: 'Friday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.duhr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'duhr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Saturday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay:
                                                              'Saturday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.duhr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'duhr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Sunday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Dhuhr',
                                                          currentDay: 'Sunday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if (valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord !=
                                                                      null,
                                                                  false,
                                                                ) &&
                                                                valueOrDefault<
                                                                    bool>(
                                                                  containerPrayerPerformanceRecord
                                                                          ?.duhr ==
                                                                      true,
                                                                  false,
                                                                )) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Asr ${getJsonField(
                                                        _model.prayerTimesToday,
                                                        r'''$.Asr''',
                                                      ) != null ? getJsonField(
                                                      _model.prayerTimesToday,
                                                      r'''$.Asr''',
                                                    ).toString() : ' '}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  '🔥${valueOrDefault<String>(
                                                    _model.streaks[2]
                                                        .toString(),
                                                    '0',
                                                  )}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Monday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay: 'Monday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Tuesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay: 'Tuesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Wednesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay:
                                                              'Wednesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Thursday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay:
                                                              'Thursday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: (functions.getUnixTimeWithIndexAndDay(
                                                                              _model
                                                                                  .index,
                                                                              'Thursday',
                                                                              getCurrentTimestamp) ==
                                                                          functions.getUnixTimeWithIndexAndDay(
                                                                              0,
                                                                              functions.datetimeToDay(
                                                                                  getCurrentTimestamp),
                                                                              getCurrentTimestamp)) &&
                                                                      functions.isTimeForPrayer(
                                                                          'Asr',
                                                                          getCurrentTimestamp,
                                                                          _model
                                                                              .prayerTimesToday,
                                                                          _model
                                                                              .prayerTimesTomorrow)
                                                                  ? Color(
                                                                      0xFF009BDD)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Friday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay: 'Friday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Saturday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay:
                                                              'Saturday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'fajr',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Sunday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Asr',
                                                          currentDay: 'Sunday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.asr ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Maghrib ${getJsonField(
                                                        _model.prayerTimesToday,
                                                        r'''$.Maghrib''',
                                                      ) != null ? getJsonField(
                                                      _model.prayerTimesToday,
                                                      r'''$.Maghrib''',
                                                    ).toString() : ' '}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  '🔥${valueOrDefault<String>(
                                                    _model.streaks[3]
                                                        .toString(),
                                                    '0',
                                                  )}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Monday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay: 'Monday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'maghrib',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Tuesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay: 'Tuesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'maghrib',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Wednesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay:
                                                              'Wednesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'maghrib',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Thursday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay:
                                                              'Thursday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: valueOrDefault<
                                                                          bool>(
                                                                        functions.getUnixTimeWithIndexAndDay(_model.index, 'Thursday', getCurrentTimestamp) ==
                                                                            functions.getUnixTimeWithIndexAndDay(
                                                                                0,
                                                                                functions.datetimeToDay(getCurrentTimestamp),
                                                                                getCurrentTimestamp),
                                                                        false,
                                                                      ) &&
                                                                      functions.isTimeForPrayer(
                                                                          'Maghrib',
                                                                          getCurrentTimestamp,
                                                                          _model
                                                                              .prayerTimesToday,
                                                                          _model
                                                                              .prayerTimesTomorrow)
                                                                  ? Color(
                                                                      0xFF009BDD)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'maghrib',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Friday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay: 'Friday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'maghrib',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Saturday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay:
                                                              'Saturday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'maghrib',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Sunday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Maghrib',
                                                          currentDay: 'Sunday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.maghrib ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Isha ${getJsonField(
                                                        _model.prayerTimesToday,
                                                        r'''$.Isha''',
                                                      ) != null ? getJsonField(
                                                      _model.prayerTimesToday,
                                                      r'''$.Isha''',
                                                    ).toString() : ' '}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: '72',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                                Text(
                                                  '🔥${valueOrDefault<String>(
                                                    _model.streaks.last
                                                        .toString(),
                                                    '0',
                                                  )}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Monday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay: 'Monday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'isha',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Monday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Tuesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay: 'Tuesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'isha',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Tuesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Wednesday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay:
                                                              'Wednesday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'isha',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Wednesday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Thursday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay:
                                                              'Thursday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: valueOrDefault<
                                                                          bool>(
                                                                        functions.getUnixTimeWithIndexAndDay(_model.index, 'Thursday', getCurrentTimestamp) ==
                                                                            functions.getUnixTimeWithIndexAndDay(
                                                                                0,
                                                                                functions.datetimeToDay(getCurrentTimestamp),
                                                                                getCurrentTimestamp),
                                                                        false,
                                                                      ) &&
                                                                      functions.isTimeForPrayer(
                                                                          'Isha',
                                                                          getCurrentTimestamp,
                                                                          _model
                                                                              .prayerTimesToday,
                                                                          _model
                                                                              .prayerTimesTomorrow)
                                                                  ? Color(
                                                                      0xFF009BDD)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'isha',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Thursday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Friday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay: 'Friday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'isha',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Friday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Saturday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay:
                                                              'Saturday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<int>(
                                                    future:
                                                        queryPrayerPerformanceRecordCount(
                                                      queryBuilder:
                                                          (prayerPerformanceRecord) =>
                                                              prayerPerformanceRecord
                                                                  .where(
                                                                    'isha',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isGreaterThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Saturday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'day',
                                                                    isLessThanOrEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'user',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          width: 20.0,
                                                          height: 8.0,
                                                          child:
                                                              ConnectorWidget(),
                                                        );
                                                      }
                                                      int containerCount =
                                                          snapshot.data!;
                                                      return Container(
                                                        height: 8.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerCount ==
                                                                  2
                                                              ? Color(
                                                                  0xFF009BDD)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<
                                                        PrayerPerformanceRecord>>(
                                                  stream:
                                                      queryPrayerPerformanceRecord(
                                                    queryBuilder:
                                                        (prayerPerformanceRecord) =>
                                                            prayerPerformanceRecord
                                                                .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                )
                                                                .where(
                                                                  'day',
                                                                  isEqualTo: functions.getUnixTimeWithIndexAndDay(
                                                                      _model
                                                                          .index,
                                                                      'Sunday',
                                                                      getCurrentTimestamp),
                                                                ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(0xFF009BDF),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PrayerPerformanceRecord>
                                                        containerPrayerPerformanceRecordList =
                                                        snapshot.data!;
                                                    final containerPrayerPerformanceRecord =
                                                        containerPrayerPerformanceRecordList
                                                                .isNotEmpty
                                                            ? containerPrayerPerformanceRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await _model.onBoxClick(
                                                          context,
                                                          prayerName: 'Isha',
                                                          currentDay: 'Sunday',
                                                          doc:
                                                              containerPrayerPerformanceRecord,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: () {
                                                            if ((containerPrayerPerformanceRecord !=
                                                                    null) &&
                                                                (containerPrayerPerformanceRecord
                                                                        ?.isha ==
                                                                    true)) {
                                                              return Color(
                                                                  0xFF009BDD);
                                                            } else if (functions
                                                                    .getUnixTimeWithIndexAndDay(
                                                                        _model
                                                                            .index,
                                                                        'Sunday',
                                                                        getCurrentTimestamp) <=
                                                                functions.getUnixTimeWithIndexAndDay(
                                                                    0,
                                                                    _model
                                                                        .dayOfTheWeekSet,
                                                                    getCurrentTimestamp)) {
                                                              return Color(
                                                                  0xFFD9D9D9);
                                                            } else {
                                                              return Color(
                                                                  0xFFF3F3F3);
                                                            }
                                                          }(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.00, 1.00),
                            child: Container(
                              height: 120.0,
                              child: Stack(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE3F7FE),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(),
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 38.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: Color(0xFF0E4051),
                                              size: 38.0,
                                            ),
                                            onPressed: () async {
                                              HapticFeedback.selectionClick();
                                              setState(() {
                                                _model.index =
                                                    _model.index + -1;
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(),
                                        ),
                                        Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(),
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 38.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            disabledIconColor:
                                                Color(0xFFB3B3B3),
                                            icon: Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xFF0E4051),
                                              size: 38.0,
                                            ),
                                            onPressed: _model.index == 0
                                                ? null
                                                : () async {
                                                    HapticFeedback
                                                        .selectionClick();
                                                    setState(() {
                                                      _model.index =
                                                          _model.index + 1;
                                                    });
                                                  },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 35.0),
                                          child: Container(
                                            width: 90.0,
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (false)
                                                  FlutterFlowIconButton(
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 100.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 60.0,
                                                    fillColor:
                                                        Color(0xFF009BDF),
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 30.0,
                                                    ),
                                                    onPressed: () async {
                                                      HapticFeedback
                                                          .selectionClick();
                                                    },
                                                  ),
                                                if (!false)
                                                  FlutterFlowIconButton(
                                                    borderColor:
                                                        Color(0xFF0E4051),
                                                    borderRadius: 100.0,
                                                    borderWidth: 4.0,
                                                    buttonSize: 60.0,
                                                    fillColor: Colors.white,
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Color(0xFF0E4051),
                                                      size: 30.0,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!_model.hideLottie)
              Lottie.asset(
                'assets/lottie_animations/confetti.json',
                width: 300.0,
                height: 300.0,
                fit: BoxFit.cover,
                animate: false,
              ),
          ],
        ),
      ),
    );
  }
}
