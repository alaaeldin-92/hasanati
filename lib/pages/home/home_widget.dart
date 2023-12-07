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
import 'package:cached_network_image/cached_network_image.dart';
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
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.initialCheck(context);
      _model.verseOfTheDayQuery = await queryQuranVerseOfTheDayRecordOnce(
        queryBuilder: (quranVerseOfTheDayRecord) =>
            quranVerseOfTheDayRecord.where(
          'user',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (getCurrentTimestamp.secondsSinceEpoch >
          _model.verseOfTheDayQuery!.nextUpdate) {
        setState(() {
          _model.verseOfTheDayChapter = random_data.randomInteger(1, 114);
        });
        setState(() {
          _model.verseOfTheDayVerse = random_data.randomInteger(
              1,
              functions.getVersesCountFromId(
                  functions.quranSurahEN()!, _model.verseOfTheDayChapter));
        });

        await _model.verseOfTheDayQuery!.reference
            .update(createQuranVerseOfTheDayRecordData(
          chapter: _model.verseOfTheDayChapter,
          claimed: false,
          nextUpdate:
              functions.add(getCurrentTimestamp.secondsSinceEpoch, 86400),
          verse: _model.verseOfTheDayVerse,
        ));
      } else {
        setState(() {
          _model.verseOfTheDayChapter = _model.verseOfTheDayQuery!.chapter;
        });
        setState(() {
          _model.verseOfTheDayVerse = _model.verseOfTheDayQuery!.verse;
        });
        setState(() {
          _model.verseOfTheDayClaimed = _model.verseOfTheDayQuery!.claimed;
        });
      }

      _model.favQueryVerseOfDay = await queryQuranVersesFavoriteRecordOnce(
        queryBuilder: (quranVersesFavoriteRecord) =>
            quranVersesFavoriteRecord.where(
          'verse',
          arrayContains:
              '${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}',
        ),
      );
      _model.verseOfTheDayLikesNum = _model.favQueryVerseOfDay!.length;
      if (FFAppState().quranVersesFavorites.contains(
          '${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}')) {
        setState(() {
          _model.verseOfTheDayHearted = true;
        });
      }
      setState(() {
        _model.pageLoading = false;
      });
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
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!_model.pageLoading)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 70.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF009BDD),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'q2b5pj07' /* Assalamualaikum, */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                ),
                                                AuthUserStreamWidget(
                                                  builder: (context) => Text(
                                                    '${currentUserDisplayName} 👋'
                                                        .maybeHandleOverflow(
                                                      maxChars: 26,
                                                      replacement: '…',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          fontSize: 18.0,
                                                        ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 5.0)),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
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
                                                    if (_model
                                                        .verseOfTheDayAudioPlaying) {
                                                      _model.soundPlayer
                                                          ?.stop();
                                                    }

                                                    context.pushNamed(
                                                      'Notification',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .rightToLeft,
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, -1.0),
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF0070A3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      8.0,
                                                                      8.0),
                                                          child: Icon(
                                                            Icons
                                                                .notifications_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            size: 18.0,
                                                          ),
                                                        ),
                                                      ),
                                                      if (valueOrDefault<bool>(
                                                              currentUserDocument
                                                                  ?.notificationsRead,
                                                              false) ==
                                                          false)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                              width: 8.0,
                                                              height: 8.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      Container(
                                                    width: 38.0,
                                                    height: 38.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      currentUserPhoto !=
                                                                  null &&
                                                              currentUserPhoto !=
                                                                  ''
                                                          ? currentUserPhoto
                                                          : 'https://firebasestorage.googleapis.com/v0/b/ubereats-234aa.appspot.com/o/b6a18f0ffd345b22cd219ef0e73ea5fe-removebg-preview.png?alt=media&token=b86b0e86-098a-46fa-b379-521772d3f11c&_gl=1*1jz5afi*_ga*MTE0NzczNDMuMTY5NTg4MzM0OQ..*_ga_CW55HF8NVT*MTY5NzU2MDIxOS45Mi4xLjE2OTc1NjQ4NzguNTIuMC4w',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 10.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      FaIcon(
                                                                        FontAwesomeIcons
                                                                            .book,
                                                                        color: Color(
                                                                            0xFF009BDD),
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '7vnikd59' /* Quran Completion */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: Color(0xFF007BAF),
                                                                              fontSize: 16.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            8.0)),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            16.0,
                                                                      ),
                                                                      Text(
                                                                        '${FFAppState().quranVersesMemorized.length.toString()} verses',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              fontSize: 12.0,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5.0)),
                                                                  ),
                                                                  Text(
                                                                    '${functions.truncateToDecimalPlaces(functions.multiply(functions.divide(FFAppState().quranVersesRead, 6236)!, 100.0)!, 1).toString()}% completed',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Readex Pro',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              12.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child:
                                                                    LinearPercentIndicator(
                                                                  percent: functions.divide(
                                                                      FFAppState()
                                                                          .quranVersesRead,
                                                                      6236)!,
                                                                  lineHeight:
                                                                      6.0,
                                                                  animation:
                                                                      true,
                                                                  animateFromLastPercent:
                                                                      true,
                                                                  progressColor:
                                                                      Color(
                                                                          0xFF009BDD),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xFFEEEEEE),
                                                                  barRadius: Radius
                                                                      .circular(
                                                                          100.0),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 10.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      5.0,
                                                                      5.0,
                                                                      5.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/blue.png',
                                                              width: 130.0,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  1.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 15.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 20.0)),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if ((FFAppState().quranLastReadPage !=
                                          null) &&
                                      (FFAppState().quranLastReadPage != 0))
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (_model.verseOfTheDayAudioPlaying) {
                                          _model.soundPlayer?.stop();
                                        }

                                        context.pushNamed(
                                          'QuranPage',
                                          queryParameters: {
                                            'page': serializeParam(
                                              FFAppState().quranLastReadPage,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                        height: 65.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF009BDD),
                                        ),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF025275),
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 20.0, 20.0, 20.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        3.5,
                                                                        3.5,
                                                                        3.5,
                                                                        3.5),
                                                            child: Icon(
                                                              Icons.restore,
                                                              color: Color(
                                                                  0xFF009BDF),
                                                              size: 22.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Last read Mushaf page ${FFAppState().quranLastReadPage.toString()}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (FFAppState().quranLastReadVerse != null &&
                                      FFAppState().quranLastReadVerse != '')
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (_model.verseOfTheDayAudioPlaying) {
                                          _model.soundPlayer?.stop();
                                        }

                                        context.pushNamed(
                                          'QuranAyah',
                                          queryParameters: {
                                            'surahID': serializeParam(
                                              functions.getValueBeforeColon(
                                                  FFAppState()
                                                      .quranLastReadVerse),
                                              ParamType.int,
                                            ),
                                            'ayahNumber': serializeParam(
                                              functions.getValueAfterColon(
                                                  FFAppState()
                                                      .quranLastReadVerse),
                                              ParamType.int,
                                            ),
                                            'versesCount': serializeParam(
                                              functions.getVersesCountFromId(
                                                  functions.quranSurahEN()!,
                                                  functions.getValueBeforeColon(
                                                      FFAppState()
                                                          .quranLastReadVerse)),
                                              ParamType.int,
                                            ),
                                            'surahName': serializeParam(
                                              functions.getValueFromQuranSurahEN(
                                                  functions.quranSurahEN()!,
                                                  functions.getValueBeforeColon(
                                                      FFAppState()
                                                          .quranLastReadVerse),
                                                  'name_simple'),
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 65.0,
                                        decoration: BoxDecoration(
                                          color: (FFAppState()
                                                          .quranLastReadPage !=
                                                      null) &&
                                                  (FFAppState()
                                                          .quranLastReadPage !=
                                                      0)
                                              ? Color(0xFF025275)
                                              : Color(0xFF009BDD),
                                        ),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00191F),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 20.0, 20.0, 20.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        3.5,
                                                                        3.5,
                                                                        3.5,
                                                                        3.5),
                                                            child: Icon(
                                                              Icons.restore,
                                                              color: Color(
                                                                  0xFF009BDF),
                                                              size: 22.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Last read ${functions.getValueFromQuranSurahEN(functions.quranSurahEN()!, functions.getValueBeforeColon(FFAppState().quranLastReadVerse), 'name_simple')} verse ${functions.getValueAfterColon(FFAppState().quranLastReadVerse).toString()}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FFAppState().quranLastReadVerse !=
                                              null &&
                                          FFAppState().quranLastReadVerse != ''
                                      ? Color(0xFF00191F)
                                      : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 25.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if ((currentUserDocument?.friends
                                                        ?.toList() ??
                                                    [])
                                                .length >
                                            0)
                                          AuthUserStreamWidget(
                                            builder: (context) => Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                        context.pushNamed(
                                                          'Friends',
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .bottomToTop,
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'bhcbo2e5' /* Friends */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Icon(
                                                            Icons.add,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x25009BDD),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    10.0,
                                                                    5.0),
                                                        child: StreamBuilder<
                                                            List<UsersRecord>>(
                                                          stream:
                                                              queryUsersRecord(
                                                            queryBuilder:
                                                                (usersRecord) =>
                                                                    usersRecord
                                                                        .where(
                                                              'friends',
                                                              arrayContains:
                                                                  currentUserUid,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 45.0,
                                                                  height: 45.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      Color(
                                                                          0xFF009BDF),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<UsersRecord>
                                                                textUsersRecordList =
                                                                snapshot.data!;
                                                            return Text(
                                                              '${textUsersRecordList.where((e) => e.online == true).toList().length.toString()}/${(currentUserDocument?.friends?.toList() ?? []).length.toString()} Online',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Color(
                                                                        0xFF009BDD),
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                StreamBuilder<
                                                    List<UsersRecord>>(
                                                  stream: queryUsersRecord(
                                                    queryBuilder: (usersRecord) =>
                                                        usersRecord
                                                            .whereIn(
                                                                'uid',
                                                                (currentUserDocument
                                                                        ?.friends
                                                                        ?.toList() ??
                                                                    []))
                                                            .orderBy('online',
                                                                descending:
                                                                    true),
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
                                                    List<UsersRecord>
                                                        rowUsersRecordList =
                                                        snapshot.data!;
                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            rowUsersRecordList
                                                                .length,
                                                            (rowIndex) {
                                                          final rowUsersRecord =
                                                              rowUsersRecordList[
                                                                  rowIndex];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (_model
                                                                  .verseOfTheDayAudioPlaying) {
                                                                _model
                                                                    .soundPlayer
                                                                    ?.stop();
                                                              }

                                                              context.pushNamed(
                                                                'Profile',
                                                                queryParameters:
                                                                    {
                                                                  'userId':
                                                                      serializeParam(
                                                                    rowUsersRecord
                                                                        .uid,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Stack(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        fadeInDuration:
                                                                            Duration(milliseconds: 500),
                                                                        fadeOutDuration:
                                                                            Duration(milliseconds: 500),
                                                                        imageUrl:
                                                                            rowUsersRecord.photoUrl,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    if (rowUsersRecord
                                                                        .online)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              10.0,
                                                                          height:
                                                                              10.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF009BDD),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  rowUsersRecord
                                                                      .displayName
                                                                      .maybeHandleOverflow(
                                                                    maxChars: 5,
                                                                    replacement:
                                                                        '…',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5.0)),
                                                            ),
                                                          );
                                                        }).divide(SizedBox(
                                                            width: 15.0)),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 20.0)),
                                            ),
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
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'l6dlh2o8' /* Quran Chapters */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                          _model.quranChaptersOrder =
                                                              'asc';
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .quranChaptersOrder ==
                                                                  'asc'
                                                              ? Color(
                                                                  0xFFEEEEEE)
                                                              : Colors
                                                                  .transparent,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      6.0,
                                                                      6.0,
                                                                      6.0,
                                                                      6.0),
                                                          child: Icon(
                                                            Icons.arrow_upward,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 22.0,
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
                                                          _model.quranChaptersOrder =
                                                              'des';
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .quranChaptersOrder ==
                                                                  'des'
                                                              ? Color(
                                                                  0xFFEEEEEE)
                                                              : Colors
                                                                  .transparent,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      6.0,
                                                                      6.0,
                                                                      6.0,
                                                                      6.0),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_downward,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 22.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final surahList = getJsonField(
                                                  functions.sortQuranChapters(
                                                      functions.quranSurahEN()!,
                                                      'id',
                                                      _model
                                                          .quranChaptersOrder),
                                                  r'''$.chapters''',
                                                ).toList().take(114).toList();
                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        surahList.length,
                                                        (surahListIndex) {
                                                      final surahListItem =
                                                          surahList[
                                                              surahListIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    5.0,
                                                                    5.0,
                                                                    5.0),
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, -1.0),
                                                          children: [
                                                            Container(
                                                              width: 200.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        1.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            0.0),
                                                                  )
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.5),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        10.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    if (_model
                                                                        .verseOfTheDayAudioPlaying) {
                                                                      _model
                                                                          .soundPlayer
                                                                          ?.stop();
                                                                    }

                                                                    context
                                                                        .pushNamed(
                                                                      'QuranAyah',
                                                                      queryParameters:
                                                                          {
                                                                        'surahID':
                                                                            serializeParam(
                                                                          getJsonField(
                                                                            surahListItem,
                                                                            r'''$.id''',
                                                                          ),
                                                                          ParamType
                                                                              .int,
                                                                        ),
                                                                        'ayahNumber':
                                                                            serializeParam(
                                                                          1,
                                                                          ParamType
                                                                              .int,
                                                                        ),
                                                                        'versesCount':
                                                                            serializeParam(
                                                                          getJsonField(
                                                                            surahListItem,
                                                                            r'''$.verses_count''',
                                                                          ),
                                                                          ParamType
                                                                              .int,
                                                                        ),
                                                                        'surahName':
                                                                            serializeParam(
                                                                          getJsonField(
                                                                            surahListItem,
                                                                            r'''$.name_simple''',
                                                                          ).toString(),
                                                                          ParamType
                                                                              .String,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x25009BDD),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              5.0,
                                                                              10.0,
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            'Surah ${getJsonField(
                                                                              surahListItem,
                                                                              r'''$.id''',
                                                                            ).toString()}',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  color: Color(0xFF009BDD),
                                                                                  fontSize: 12.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  '${getJsonField(
                                                                                    surahListItem,
                                                                                    r'''$.name_simple''',
                                                                                  ).toString()} • ${getJsonField(
                                                                                    surahListItem,
                                                                                    r'''$.name_arabic''',
                                                                                  ).toString()}',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Outfit',
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      '${getJsonField(
                                                                                        surahListItem,
                                                                                        r'''$.verses_count''',
                                                                                      ).toString()} Verses',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Outfit',
                                                                                            color: Color(0xFF979797),
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      '${functions.round(functions.multiply(functions.divide(FFAppState().quranVersesMemorized.where((e) => functions.toInteger(functions.getValueBeforeColon(e).toString()) == functions.add(surahListIndex, 1)).toList().length, functions.getVersesCountFromId(functions.quranSurahEN()!, functions.add(surahListIndex, 1)!))!, 100.0)!).toString()}%',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Outfit',
                                                                                            color: Color(0xFF979797),
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(height: 10.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 30.0)),
                                                                      ),
                                                                      LinearPercentIndicator(
                                                                        percent: functions.divide(
                                                                            FFAppState().quranVersesMemorized.where((e) => functions.toInteger(functions.getValueBeforeColon(e).toString()) == functions.add(surahListIndex, 1)).toList().length,
                                                                            functions.getVersesCountFromId(functions.quranSurahEN()!, functions.add(surahListIndex, 1)!))!,
                                                                        lineHeight:
                                                                            4.0,
                                                                        animation:
                                                                            true,
                                                                        animateFromLastPercent:
                                                                            true,
                                                                        progressColor:
                                                                            Color(0xFF009BDD),
                                                                        backgroundColor:
                                                                            Color(0xFFEEEEEE),
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0x25009BDD),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          100.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                ),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).divide(
                                                        SizedBox(width: 15.0)),
                                                  ),
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 15.0)),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 35.0),
                                          child: FutureBuilder<ApiCallResponse>(
                                            future: QuranFontImlaeiCall.call(
                                              chapter:
                                                  _model.verseOfTheDayChapter,
                                              verse: _model.verseOfTheDayVerse,
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
                                              final containerQuranFontImlaeiResponse =
                                                  snapshot.data!;
                                              return Container(
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            '3p25hoy9' /* Today's Verse */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        if (!_model
                                                            .verseOfTheDayClaimed)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              HapticFeedback
                                                                  .selectionClick();
                                                              setState(() {
                                                                _model.verseOfTheDayClaimed =
                                                                    true;
                                                              });

                                                              await _model
                                                                  .verseOfTheDayQuery!
                                                                  .reference
                                                                  .update(
                                                                      createQuranVerseOfTheDayRecordData(
                                                                claimed: true,
                                                              ));
                                                              _model.userQuranPer =
                                                                  await queryQuranPerformanceRecordOnce(
                                                                queryBuilder:
                                                                    (quranPerformanceRecord) =>
                                                                        quranPerformanceRecord
                                                                            .where(
                                                                  'user',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                ),
                                                                singleRecord:
                                                                    true,
                                                              ).then((s) => s
                                                                      .firstOrNull);

                                                              await _model
                                                                  .userQuranPer!
                                                                  .reference
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'hasanat': FieldValue.increment(
                                                                        functions
                                                                            .hasanatCalculator(getJsonField(
                                                                      containerQuranFontImlaeiResponse
                                                                          .jsonBody,
                                                                      r'''$.verses[:].text_imlaei''',
                                                                    ).toString())!),
                                                                  },
                                                                ),
                                                              });
                                                              FFAppState()
                                                                  .quranHasanat = FFAppState()
                                                                      .quranHasanat +
                                                                  functions
                                                                      .hasanatCalculator(
                                                                          getJsonField(
                                                                    containerQuranFontImlaeiResponse
                                                                        .jsonBody,
                                                                    r'''$.verses[:].text_imlaei''',
                                                                  ).toString())!;

                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              height: 30.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFF009BDD),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        12.0,
                                                                        0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Claim ${functions.hasanatCalculator(getJsonField(
                                                                            containerQuranFontImlaeiResponse.jsonBody,
                                                                            r'''$.verses[:].text_imlaei''',
                                                                          ).toString()).toString()}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            color:
                                                                                Color(0xFF009BDD),
                                                                            fontSize:
                                                                                12.0,
                                                                          ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .diamond,
                                                                      color: Color(
                                                                          0xFF009BDD),
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          2.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (_model
                                                            .verseOfTheDayClaimed)
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .timer_sharp,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                size: 22.0,
                                                              ),
                                                              Text(
                                                                'Next in ${functions.formattedUnixTimeDifference(getCurrentTimestamp.secondsSinceEpoch, _model.verseOfTheDayQuery!.nextUpdate)}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 3.0)),
                                                          ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Flexible(
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      3.0,
                                                                  color: Color(
                                                                      0x33000000),
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          0.0),
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          20.0,
                                                                          10.0,
                                                                          20.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                primary: false,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          10.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0x4DFFFFFF),
                                                                                  borderRadius: BorderRadius.circular(100.0),
                                                                                ),
                                                                                child: Stack(
                                                                                  alignment: AlignmentDirectional(0.0, -1.0),
                                                                                  children: [
                                                                                    if (!_model.verseOfTheDayAudioPlaying && !_model.audioLoading)
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.00, -1.00),
                                                                                        child: InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            setState(() => _model.loadingStatus = !_model.loadingStatus);
                                                                                            setState(() {
                                                                                              _model.audioLoading = true;
                                                                                            });
                                                                                            _model.audioJSON = await VerseAudioCall.call(
                                                                                              surahID: _model.verseOfTheDayChapter,
                                                                                              ayahID: _model.verseOfTheDayVerse,
                                                                                              reciterID: FFAppState().reciterID,
                                                                                            );
                                                                                            _model.duration = await actions.getAudioLength(
                                                                                              'https://verses.quran.com/${getJsonField(
                                                                                                (_model.audioJSON?.jsonBody ?? ''),
                                                                                                r'''$.audio_files[:].url''',
                                                                                              ).toString()}',
                                                                                            );
                                                                                            setState(() {
                                                                                              _model.verseOfTheDayAudioDuration = _model.duration!;
                                                                                              _model.verseOfTheDayAudioPlaying = true;
                                                                                              _model.audioLoading = false;
                                                                                            });
                                                                                            setState(() => _model.loadingStatus = !_model.loadingStatus);
                                                                                            _model.soundPlayer ??= AudioPlayer();
                                                                                            if (_model.soundPlayer!.playing) {
                                                                                              await _model.soundPlayer!.stop();
                                                                                            }
                                                                                            _model.soundPlayer!.setVolume(1.0);
                                                                                            _model.soundPlayer!
                                                                                                .setUrl('https://verses.quran.com/${getJsonField(
                                                                                                  (_model.audioJSON?.jsonBody ?? ''),
                                                                                                  r'''$.audio_files[:].url''',
                                                                                                ).toString()}')
                                                                                                .then((_) => _model.soundPlayer!.play());

                                                                                            while (_model.verseOfTheDayTimeCounter < _model.duration!) {
                                                                                              await Future.delayed(const Duration(milliseconds: 1000));
                                                                                              setState(() {
                                                                                                _model.verseOfTheDayTimeCounter = _model.verseOfTheDayTimeCounter + 1.0;
                                                                                              });
                                                                                            }
                                                                                            await Future.delayed(const Duration(milliseconds: 1000));
                                                                                            setState(() {
                                                                                              _model.verseOfTheDayAudioPlaying = false;
                                                                                              _model.verseOfTheDayTimeCounter = 0.0;
                                                                                            });

                                                                                            setState(() {});
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: Color(0xFF009BDF),
                                                                                              shape: BoxShape.circle,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                                                                                              child: Icon(
                                                                                                Icons.play_arrow,
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    if (_model.verseOfTheDayAudioPlaying)
                                                                                      InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          _model.soundPlayer?.stop();
                                                                                          setState(() {
                                                                                            _model.verseOfTheDayAudioPlaying = false;
                                                                                          });
                                                                                          setState(() {
                                                                                            _model.verseOfTheDayTimeCounter = 0.0;
                                                                                          });
                                                                                        },
                                                                                        child: Stack(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          children: [
                                                                                            CircularPercentIndicator(
                                                                                              percent: functions.divideDouble(_model.verseOfTheDayTimeCounter, _model.verseOfTheDayAudioDuration),
                                                                                              radius: 22.5,
                                                                                              lineWidth: 5.0,
                                                                                              animation: false,
                                                                                              animateFromLastPercent: true,
                                                                                              progressColor: Color(0xFF009BDD),
                                                                                              startAngle: 0.0,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.pause_sharp,
                                                                                              color: Color(0xFF009BDD),
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    Transform.scale(
                                                                                      scaleX: 4.0,
                                                                                      scaleY: 4.0,
                                                                                      child: Visibility(
                                                                                        visible: _model.audioLoading,
                                                                                        child: Lottie.asset('assets/lottie_animations/Animation_-_1701617942129.json', width: 45.0, height: 45.0, fit: BoxFit.contain, animate: _model.loadingStatus),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 8.0)),
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                '${functions.getValueFromQuranSurahEN(functions.quranSurahEN()!, _model.verseOfTheDayChapter, 'name_simple')}',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                '${_model.verseOfTheDayVerse.toString()}/${functions.toString(functions.getVersesCountFromId(functions.quranSurahEN()!, _model.verseOfTheDayChapter))}',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                decoration: BoxDecoration(),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    if (!_model.verseOfTheDayHearted)
                                                                                      InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          setState(() {
                                                                                            _model.verseOfTheDayHearted = true;
                                                                                          });
                                                                                          setState(() {
                                                                                            _model.verseOfTheDayLikesNum = _model.verseOfTheDayLikesNum + 1;
                                                                                          });
                                                                                          FFAppState().addToQuranVersesFavorites('${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}');
                                                                                          FFAppState().addToQuranVersesFavoriteAddSession('${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}');
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.favorite_border,
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                      ),
                                                                                    if (_model.verseOfTheDayHearted)
                                                                                      InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          setState(() {
                                                                                            _model.verseOfTheDayHearted = false;
                                                                                          });
                                                                                          setState(() {
                                                                                            _model.verseOfTheDayLikesNum = _model.verseOfTheDayLikesNum + -1;
                                                                                          });
                                                                                          if (!FFAppState().quranVersesFavoriteRemoveSession.contains('${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}')) {
                                                                                            FFAppState().addToQuranVersesFavoriteRemoveSession('${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}');
                                                                                          } else {
                                                                                            FFAppState().removeFromQuranVersesFavoriteRemoveSession('${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}');
                                                                                          }

                                                                                          FFAppState().removeFromQuranVersesFavorites('${_model.verseOfTheDayChapter.toString()}:${_model.verseOfTheDayVerse.toString()}');
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.favorite_rounded,
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                      ),
                                                                                    Text(
                                                                                      '${_model.verseOfTheDayLikesNum.toString()}',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Readex Pro',
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 3.0)),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 8.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.0,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              getJsonField(
                                                                                containerQuranFontImlaeiResponse.jsonBody,
                                                                                r'''$.verses[:].text_imlaei''',
                                                                              ).toString(),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Muhammadi ',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 28.0,
                                                                                    useGoogleFonts: false,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                FutureBuilder<ApiCallResponse>(
                                                                              future: VerseKeyCall.call(
                                                                                chapter: _model.verseOfTheDayChapter,
                                                                                verse: _model.verseOfTheDayVerse,
                                                                              ),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 45.0,
                                                                                      height: 45.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          Color(0xFF009BDF),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                final textVerseKeyResponse = snapshot.data!;
                                                                                return Text(
                                                                                  functions.extractFromJson(getJsonField(
                                                                                    textVerseKeyResponse.jsonBody,
                                                                                    r'''$.verse.words''',
                                                                                  )),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Readex Pro',
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          15.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 20.0)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 35.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_model.pageLoading)
                      wrapWithModel(
                        model: _model.homeSkeletonModel,
                        updateCallback: () => setState(() {}),
                        child: HomeSkeletonWidget(),
                      ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => setState(() {}),
                child: NavbarWidget(
                  selectedIndex: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
