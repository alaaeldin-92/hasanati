import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
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
import 'quran_page_model.dart';
export 'quran_page_model.dart';

class QuranPageWidget extends StatefulWidget {
  const QuranPageWidget({
    Key? key,
    required this.page,
  }) : super(key: key);

  final int? page;

  @override
  _QuranPageWidgetState createState() => _QuranPageWidgetState();
}

class _QuranPageWidgetState extends State<QuranPageWidget> {
  late QuranPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuranPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((widget.page != null) && (widget.page != 0)) {
        setState(() {
          _model.page = widget.page!;
        });
      } else {
        setState(() {
          _model.page = 1;
        });
      }

      setState(() {
        FFAppState().quranPageTraverseUpdated = true;
        FFAppState().stopTimers = false;
      });
      await _model.updateMemorized(context);
      setState(() {
        _model.pageLoading = false;
      });
      while (!FFAppState().stopTimers) {
        await Future.delayed(const Duration(milliseconds: 1000));
        setState(() {
          FFAppState().quranTimeReadSec = FFAppState().quranTimeReadSec + 1;
        });
      }
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

    return FutureBuilder<ApiCallResponse>(
      future: QuranFontImlaeiPageCall.call(
        page: _model.page,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 45.0,
                height: 45.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF009BDF),
                  ),
                ),
              ),
            ),
          );
        }
        final quranPageQuranFontImlaeiPageResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: FutureBuilder<ApiCallResponse>(
                future: QuranTranslationPageCall.call(
                  page: _model.page,
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
                  final stackQuranTranslationPageResponse = snapshot.data!;
                  return Stack(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed('Home');

                                          _model.syncQuranPerformance =
                                              await queryQuranPerformanceRecordOnce(
                                            queryBuilder:
                                                (quranPerformanceRecord) =>
                                                    quranPerformanceRecord
                                                        .where(
                                              'user',
                                              isEqualTo: currentUserUid,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);

                                          await _model
                                              .syncQuranPerformance!.reference
                                              .update(
                                                  createQuranPerformanceRecordData(
                                            hasanat: FFAppState().quranHasanat,
                                            timeReadSec:
                                                FFAppState().quranTimeReadSec,
                                            versesRead:
                                                FFAppState().quranVersesRead,
                                          ));
                                          _model.syncLastRead =
                                              await queryQuranLastReadPageRecordOnce(
                                            queryBuilder:
                                                (quranLastReadPageRecord) =>
                                                    quranLastReadPageRecord
                                                        .where(
                                              'user',
                                              isEqualTo: currentUserUid,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);

                                          await _model.syncLastRead!.reference
                                              .update(
                                                  createQuranLastReadPageRecordData(
                                            page:
                                                FFAppState().quranLastReadPage,
                                          ));

                                          setState(() {});
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 10.0, 10.0, 10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.diamond,
                                                    color: Color(0xFF6DD6FD),
                                                    size: 24.0,
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      functions.formatNumber(
                                                          FFAppState()
                                                              .quranHasanat),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                              Container(
                                                width: 1.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF6DD6FD),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.book_outlined,
                                                    color: Color(0xFF6DD6FD),
                                                    size: 24.0,
                                                  ),
                                                  Text(
                                                    FFAppState()
                                                        .quranVersesRead
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                              Container(
                                                width: 1.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF6DD6FD),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.timer_sharp,
                                                    color: Color(0xFF6DD6FD),
                                                    size: 24.0,
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      functions.formatTime(
                                                          FFAppState()
                                                              .quranTimeReadSec),
                                                      '00:00',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: 0.2,
                                        child: FaIcon(
                                          FontAwesomeIcons.ellipsisH,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
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
                                color: Color(0xFF009BDD),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 0.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x4DFFFFFF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    children: [
                                                      if (!_model.audioPlaying)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.audioPageJSON =
                                                                await VerseAudioPageCall
                                                                    .call(
                                                              page: _model.page,
                                                            );
                                                            _model.totalDuration =
                                                                await actions
                                                                    .getTotalAudioLength(
                                                              getJsonField(
                                                                (_model.audioPageJSON
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.audio_files''',
                                                                true,
                                                              )!,
                                                            );
                                                            setState(() {
                                                              _model.audioDuration =
                                                                  _model
                                                                      .totalDuration;
                                                            });
                                                            setState(() {
                                                              _model.audioPlaying =
                                                                  true;
                                                            });
                                                            setState(() {
                                                              _model.totalRecords =
                                                                  getJsonField(
                                                                (_model.audioPageJSON
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.pagination.total_records''',
                                                              );
                                                            });
                                                            setState(() {
                                                              _model.tempCounter =
                                                                  0;
                                                            });
                                                            while (_model
                                                                    .audioIndexForPage <
                                                                getJsonField(
                                                                  (_model.audioPageJSON
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.pagination.total_records''',
                                                                )) {
                                                              _model.soundPlayer ??=
                                                                  AudioPlayer();
                                                              if (_model
                                                                  .soundPlayer!
                                                                  .playing) {
                                                                await _model
                                                                    .soundPlayer!
                                                                    .stop();
                                                              }
                                                              _model
                                                                  .soundPlayer!
                                                                  .setVolume(
                                                                      1.0);
                                                              _model
                                                                  .soundPlayer!
                                                                  .setUrl(
                                                                      'https://verses.quran.com/${functions.getValueFromJsonArray(getJsonField(
                                                                            (_model.audioPageJSON?.jsonBody ??
                                                                                ''),
                                                                            r'''$.audio_files''',
                                                                            true,
                                                                          )!, _model.audioIndexForPage, 'url')}')
                                                                  .then((_) => _model
                                                                      .soundPlayer!
                                                                      .play());

                                                              _model.durationSingle =
                                                                  await actions
                                                                      .getAudioLength(
                                                                'https://verses.quran.com/${functions.getValueFromJsonArray(getJsonField(
                                                                      (_model.audioPageJSON
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                      r'''$.audio_files''',
                                                                      true,
                                                                    )!, _model.audioIndexForPage, 'url')}',
                                                              );
                                                              setState(() {
                                                                _model.audioSingleDuration =
                                                                    _model
                                                                        .durationSingle!;
                                                              });
                                                              setState(() {
                                                                _model.tempCounter =
                                                                    0;
                                                              });
                                                              while (_model
                                                                      .tempCounter! <
                                                                  _model
                                                                      .audioSingleDuration) {
                                                                await Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            1000));
                                                                setState(() {
                                                                  _model.timeCounter =
                                                                      _model.timeCounter! +
                                                                          1.0;
                                                                });
                                                                setState(() {
                                                                  _model.tempCounter =
                                                                      _model.tempCounter! +
                                                                          1;
                                                                });
                                                              }
                                                              setState(() {
                                                                _model.audioIndexForPage =
                                                                    _model.audioIndexForPage +
                                                                        1;
                                                              });
                                                            }
                                                            await Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        1000));
                                                            setState(() {
                                                              _model.audioPlaying =
                                                                  false;
                                                            });
                                                            setState(() {
                                                              _model.timeCounter =
                                                                  0.0;
                                                            });
                                                            _model.audioIndexForPage =
                                                                0;

                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.play_arrow,
                                                            color: Color(
                                                                0xFF2F2F2F),
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      if (_model.audioPlaying)
                                                        CircularPercentIndicator(
                                                          percent: functions.divideDouble(
                                                              _model
                                                                  .timeCounter!,
                                                              _model
                                                                  .audioDuration!),
                                                          radius: 22.5,
                                                          lineWidth: 5.0,
                                                          animation: false,
                                                          animateFromLastPercent:
                                                              true,
                                                          progressColor:
                                                              Color(0xFF009BDF),
                                                          startAngle: 0.0,
                                                        ),
                                                      if (_model.audioPlaying)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.soundPlayer
                                                                ?.stop();
                                                            setState(() {
                                                              _model.audioPlaying =
                                                                  false;
                                                            });
                                                            setState(() {
                                                              _model.timeCounter =
                                                                  0.0;
                                                            });
                                                            setState(() {
                                                              _model.audioIndexForPage =
                                                                  0;
                                                            });
                                                            setState(() {
                                                              _model.tempCounter =
                                                                  0;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.pause_sharp,
                                                            color: Color(
                                                                0xFF009BDF),
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEEEEEE),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 5.0, 5.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                          'QuranAyah',
                                                          queryParameters: {
                                                            'surahID':
                                                                serializeParam(
                                                              1,
                                                              ParamType.int,
                                                            ),
                                                            'ayahNumber':
                                                                serializeParam(
                                                              1,
                                                              ParamType.int,
                                                            ),
                                                            'surahName':
                                                                serializeParam(
                                                              'Al-Fatiha',
                                                              ParamType.String,
                                                            ),
                                                            'versesCount':
                                                                serializeParam(
                                                              7,
                                                              ParamType.int,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.00, 0.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      15.0,
                                                                      5.0,
                                                                      15.0,
                                                                      5.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'zve0y5zc' /* Verse */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.00, 0.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    5.0,
                                                                    15.0,
                                                                    5.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'v6lv8ne4' /* Page */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${_model.page.toString()}/604',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ],
                                        ),
                                        if (!_model.pageLoading)
                                          Flexible(
                                            child: SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 100.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Text(
                                                            functions.concatenatVersesTextWithNum(
                                                                quranPageQuranFontImlaeiPageResponse
                                                                    .jsonBody),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Muhammadi ',
                                                                  fontSize:
                                                                      28.0,
                                                                  useGoogleFonts:
                                                                      false,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Text(
                                                            functions.getConcatenatedText(
                                                                stackQuranTranslationPageResponse
                                                                    .bodyText),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 15.0)),
                                              ),
                                            ),
                                          ),
                                        if (_model.pageLoading)
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.85,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.8,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 10.0)),
                                          ),
                                        if (_model.pageLoading)
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.85,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.8,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 10.0)),
                                          ),
                                      ].divide(SizedBox(height: 25.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
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
                                              borderWidth: 1.0,
                                              buttonSize: 40.0,
                                              disabledIconColor:
                                                  Color(0xFFB3B3B3),
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color: Color(0xFF0E4051),
                                                size: 38.0,
                                              ),
                                              onPressed: (_model.surahID ==
                                                          1) &&
                                                      (_model.verseID == 1)
                                                  ? null
                                                  : () async {
                                                      HapticFeedback
                                                          .selectionClick();
                                                      if (_model.page == 1) {
                                                        setState(() {
                                                          _model.page = 604;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _model.page =
                                                              _model.page + -1;
                                                        });
                                                      }

                                                      setState(() {
                                                        FFAppState()
                                                                .quranLastReadPage =
                                                            _model.page;
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
                                              borderWidth: 1.0,
                                              buttonSize: 40.0,
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: Color(0xFF0E4051),
                                                size: 38.0,
                                              ),
                                              onPressed: () async {
                                                HapticFeedback.selectionClick();
                                                if (_model.page != 604) {
                                                  setState(() {
                                                    _model.page =
                                                        _model.page + 1;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _model.page = 1;
                                                  });
                                                }

                                                setState(() {
                                                  FFAppState()
                                                      .quranHasanat = FFAppState()
                                                          .quranHasanat +
                                                      functions.hasanatCalculator(
                                                          functions.concatenateVersesText(
                                                              quranPageQuranFontImlaeiPageResponse
                                                                  .jsonBody))!;
                                                });
                                                setState(() {
                                                  FFAppState()
                                                      .quranVersesRead = FFAppState()
                                                          .quranVersesRead +
                                                      functions.getJSONArrayLength(
                                                          quranPageQuranFontImlaeiPageResponse
                                                              .jsonBody)!;
                                                });
                                                setState(() {
                                                  FFAppState()
                                                          .quranLastReadPage =
                                                      _model.page;
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
                                                    BorderRadius.circular(
                                                        100.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (_model.memorized)
                                                    FlutterFlowIconButton(
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
                                                        setState(() {
                                                          _model.memorized =
                                                              false;
                                                        });
                                                        _model.forLoopCounter =
                                                            0;
                                                        while (_model
                                                                .forLoopCounter <
                                                            functions.getJSONArrayLength(
                                                                quranPageQuranFontImlaeiPageResponse
                                                                    .jsonBody)!) {
                                                          if (FFAppState()
                                                              .quranVersesMemorized
                                                              .contains(functions
                                                                  .getValueFromJsonArray(
                                                                      getJsonField(
                                                                        quranPageQuranFontImlaeiPageResponse
                                                                            .jsonBody,
                                                                        r'''$.verses''',
                                                                        true,
                                                                      )!,
                                                                      _model
                                                                          .forLoopCounter,
                                                                      'verse_key'))) {
                                                            setState(() {
                                                              FFAppState().removeFromQuranVersesMemorized(functions
                                                                  .getValueFromJsonArray(
                                                                      getJsonField(
                                                                        quranPageQuranFontImlaeiPageResponse
                                                                            .jsonBody,
                                                                        r'''$.verses''',
                                                                        true,
                                                                      )!,
                                                                      _model
                                                                          .forLoopCounter,
                                                                      'verse_key'));
                                                            });
                                                            FFAppState().removeFromQuranVersesMemorizedAddSession(functions
                                                                .getValueFromJsonArray(
                                                                    getJsonField(
                                                                      quranPageQuranFontImlaeiPageResponse
                                                                          .jsonBody,
                                                                      r'''$.verses''',
                                                                      true,
                                                                    )!,
                                                                    _model
                                                                        .forLoopCounter,
                                                                    'verse_key'));
                                                          }
                                                          _model.forLoopCounter =
                                                              _model.forLoopCounter +
                                                                  1;
                                                        }
                                                      },
                                                    ),
                                                  if (!_model.memorized)
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Color(0xFF0E4051),
                                                      borderRadius: 100.0,
                                                      borderWidth: 4.0,
                                                      buttonSize: 60.0,
                                                      fillColor: Colors.white,
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.check,
                                                        color:
                                                            Color(0xFF0E4051),
                                                        size: 30.0,
                                                      ),
                                                      onPressed: () async {
                                                        HapticFeedback
                                                            .selectionClick();
                                                        setState(() {
                                                          _model.memorized =
                                                              true;
                                                        });
                                                        _model.forLoopCounter =
                                                            0;
                                                        while (_model
                                                                .forLoopCounter <
                                                            functions.getJSONArrayLength(
                                                                quranPageQuranFontImlaeiPageResponse
                                                                    .jsonBody)!) {
                                                          if (!FFAppState()
                                                              .quranVersesMemorized
                                                              .contains(functions
                                                                  .getValueFromJsonArray(
                                                                      getJsonField(
                                                                        quranPageQuranFontImlaeiPageResponse
                                                                            .jsonBody,
                                                                        r'''$.verses''',
                                                                        true,
                                                                      )!,
                                                                      _model
                                                                          .forLoopCounter,
                                                                      'verse_key'))) {
                                                            setState(() {
                                                              FFAppState().addToQuranVersesMemorized(functions
                                                                  .getValueFromJsonArray(
                                                                      getJsonField(
                                                                        quranPageQuranFontImlaeiPageResponse
                                                                            .jsonBody,
                                                                        r'''$.verses''',
                                                                        true,
                                                                      )!,
                                                                      _model
                                                                          .forLoopCounter,
                                                                      'verse_key'));
                                                            });
                                                            FFAppState().addToQuranVersesMemorizedAddSession(functions
                                                                .getValueFromJsonArray(
                                                                    getJsonField(
                                                                      quranPageQuranFontImlaeiPageResponse
                                                                          .jsonBody,
                                                                      r'''$.verses''',
                                                                      true,
                                                                    )!,
                                                                    _model
                                                                        .forLoopCounter,
                                                                    'verse_key'));
                                                          }
                                                          _model.forLoopCounter =
                                                              _model.forLoopCounter +
                                                                  1;
                                                        }
                                                      },
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 100.0,
                                              height: 55.0,
                                              decoration: BoxDecoration(),
                                            ),
                                            Container(
                                              width: 100.0,
                                              decoration: BoxDecoration(),
                                            ),
                                            Container(
                                              width: 100.0,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Text(
                                                  '+${functions.hasanatCalculator(functions.concatenateVersesText(quranPageQuranFontImlaeiPageResponse.jsonBody)).toString()}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF0E4051),
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (false)
                        Lottie.network(
                          'https://lottie.host/6c44e6b2-af69-45b7-af0c-c49e51d27638/4EAT8IeH3C.json',
                          width: 300.0,
                          height: 300.0,
                          fit: BoxFit.cover,
                          repeat: false,
                          animate: false,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
