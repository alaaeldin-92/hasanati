import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/reciter_widget.dart';
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
import 'package:webviewx_plus/webviewx_plus.dart';
import 'quran_ayah_model.dart';
export 'quran_ayah_model.dart';

class QuranAyahWidget extends StatefulWidget {
  const QuranAyahWidget({
    Key? key,
    required this.surahID,
    required this.ayahNumber,
    required this.versesCount,
    required this.surahName,
  }) : super(key: key);

  final int? surahID;
  final int? ayahNumber;
  final int? versesCount;
  final String? surahName;

  @override
  _QuranAyahWidgetState createState() => _QuranAyahWidgetState();
}

class _QuranAyahWidgetState extends State<QuranAyahWidget> {
  late QuranAyahModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuranAyahModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.surahID = widget.surahID;
        _model.verseID = widget.ayahNumber;
        _model.versesCount = widget.versesCount;
        _model.surahName = widget.surahName!;
      });
      await _model.updateLikesAndMem(context);
      setState(() {});
      setState(() {
        FFAppState().quranVerseTraverseUpdated = true;
        FFAppState().stopTimers = false;
      });
      while (true) {
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
      future: QuranFontImlaeiCall.call(
        chapter: _model.surahID,
        verse: _model.verseID,
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
        final quranAyahQuranFontImlaeiResponse = snapshot.data!;
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
                future: VerseKeyCall.call(
                  chapter: _model.surahID,
                  verse: _model.verseID,
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
                  final stackVerseKeyResponse = snapshot.data!;
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
                                          if (_model.audioPlaying) {
                                            _model.soundPlayer?.stop();
                                          }

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
                                              await queryQuranLastReadVerseRecordOnce(
                                            queryBuilder:
                                                (quranLastReadVerseRecord) =>
                                                    quranLastReadVerseRecord
                                                        .where(
                                              'user',
                                              isEqualTo: currentUserUid,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);

                                          await _model.syncLastRead!.reference
                                              .update(
                                                  createQuranLastReadVerseRecordData(
                                            verse:
                                                FFAppState().quranLastReadVerse,
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
                                          padding: EdgeInsets.all(10.0),
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
                                                    Icons.library_books,
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
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (_model.audioPlaying) {
                                            _model.soundPlayer?.stop();
                                            setState(() {
                                              _model.audioPlaying = false;
                                              _model.timeCounter = 0.0;
                                            });
                                          }
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                  child: GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: Container(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        1.0,
                                                    child: ReciterWidget(),
                                                  ),
                                                ),
                                              ));
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
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
                                color: Color(0xFF009BDF),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              children: [
                                                if (!_model.audioPlaying &&
                                                    !_model.audioLoading)
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
                                                      setState(() => _model
                                                              .loadingStatus =
                                                          !_model
                                                              .loadingStatus);
                                                      setState(() {
                                                        _model.audioLoading =
                                                            true;
                                                      });
                                                      _model.audioJSON =
                                                          await VerseAudioCall
                                                              .call(
                                                        surahID: _model.surahID,
                                                        ayahID: _model.verseID,
                                                        reciterID: FFAppState()
                                                            .reciterID,
                                                      );
                                                      _model.soundPlayer ??=
                                                          AudioPlayer();
                                                      if (_model.soundPlayer!
                                                          .playing) {
                                                        await _model
                                                            .soundPlayer!
                                                            .stop();
                                                      }
                                                      _model.soundPlayer!
                                                          .setVolume(1.0);
                                                      _model.soundPlayer!
                                                          .setUrl(
                                                              'https://verses.quran.com/${getJsonField(
                                                            (_model.audioJSON
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.audio_files[:].url''',
                                                          ).toString()}')
                                                          .then((_) => _model
                                                              .soundPlayer!
                                                              .play());

                                                      _model.duration =
                                                          await actions
                                                              .getAudioLength(
                                                        'https://verses.quran.com/${getJsonField(
                                                          (_model.audioJSON
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.audio_files[:].url''',
                                                        ).toString()}',
                                                      );
                                                      setState(() {
                                                        _model.audioDuration =
                                                            _model.duration;
                                                        _model.audioPlaying =
                                                            true;
                                                        _model.audioLoading =
                                                            false;
                                                      });
                                                      setState(() => _model
                                                              .loadingStatus =
                                                          !_model
                                                              .loadingStatus);
                                                      while ((_model
                                                                  .timeCounter! <
                                                              _model
                                                                  .duration!) &&
                                                          _model.audioPlaying) {
                                                        await Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    1000));
                                                        setState(() {
                                                          _model.timeCounter =
                                                              _model.timeCounter! +
                                                                  1.0;
                                                        });
                                                      }
                                                      await Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  1000));
                                                      setState(() {
                                                        _model.audioPlaying =
                                                            false;
                                                        _model.timeCounter =
                                                            0.0;
                                                      });

                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF009BDF),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Icon(
                                                          Icons.play_arrow,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (_model.audioPlaying)
                                                  CircularPercentIndicator(
                                                    percent: _model
                                                                .timeCounter! <
                                                            _model
                                                                .audioDuration!
                                                        ? functions.divideDouble(
                                                            _model.timeCounter!,
                                                            _model
                                                                .audioDuration!)
                                                        : 1.0,
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
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.soundPlayer
                                                          ?.stop();
                                                      setState(() {
                                                        _model.audioPlaying =
                                                            false;
                                                        _model.timeCounter =
                                                            0.0;
                                                        _model.tempCounter = 0;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.pause_sharp,
                                                      color: Color(0xFF009BDF),
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                Transform.scale(
                                                  scaleX: 4.0,
                                                  scaleY: 4.0,
                                                  child: Visibility(
                                                    visible:
                                                        _model.audioLoading,
                                                    child: Lottie.asset(
                                                        'assets/lottie_animations/Animation_-_1701617942129.json',
                                                        width: 45.0,
                                                        height: 45.0,
                                                        fit: BoxFit.contain,
                                                        animate: _model
                                                            .loadingStatus),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                                        50.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
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
                                                                'ec79bx73' /* Verse */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                        ),
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
                                                            if (_model
                                                                .audioPlaying) {
                                                              _model.soundPlayer
                                                                  ?.stop();
                                                            }

                                                            context.pushNamed(
                                                              'QuranPage',
                                                              queryParameters: {
                                                                'page':
                                                                    serializeParam(
                                                                  FFAppState()
                                                                      .quranLastReadPage,
                                                                  ParamType.int,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x00FFFFFF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
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
                                                                  'gzuyc536' /* Page */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      '${_model.surahID?.toString()}. ${_model.surahName}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Color(
                                                                    0xFF2F2F2F),
                                                              ),
                                                    ),
                                                    Text(
                                                      '${_model.verseID?.toString()}/${_model.versesCount?.toString()}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ].divide(SizedBox(height: 10.0)),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (!_model.hearted)
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
                                                          _model.hearted = true;
                                                        });
                                                        setState(() {
                                                          _model.verseLikesNum =
                                                              _model.verseLikesNum! +
                                                                  1;
                                                        });
                                                        FFAppState()
                                                            .addToQuranVersesFavorites(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                        FFAppState()
                                                            .addToQuranVersesFavoriteAddSession(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                      },
                                                      child: Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.black,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  if (_model.hearted)
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
                                                          _model.hearted =
                                                              false;
                                                        });
                                                        setState(() {
                                                          _model.verseLikesNum =
                                                              _model.verseLikesNum! +
                                                                  -1;
                                                        });
                                                        if (!FFAppState()
                                                            .quranVersesFavoriteRemoveSession
                                                            .contains(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}')) {
                                                          FFAppState()
                                                              .addToQuranVersesFavoriteRemoveSession(
                                                                  '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                        } else {
                                                          FFAppState()
                                                              .removeFromQuranVersesFavoriteRemoveSession(
                                                                  '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                        }

                                                        FFAppState()
                                                            .removeFromQuranVersesFavorites(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                      },
                                                      child: Icon(
                                                        Icons.favorite_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      _model.verseLikesNum
                                                          ?.toString(),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 2.0)),
                                              ),
                                            ),
                                            if (false)
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: getJsonField(
                                                    quranAyahQuranFontImlaeiResponse
                                                        .jsonBody,
                                                    r'''$.verses[:].text_imlaei''',
                                                  ).toString()));
                                                  HapticFeedback
                                                      .selectionClick();
                                                },
                                                child: Icon(
                                                  Icons.content_copy_outlined,
                                                  color: Colors.black,
                                                  size: 24.0,
                                                ),
                                              ),
                                          ],
                                        ),
                                        if (quranAyahQuranFontImlaeiResponse
                                                .succeeded &&
                                            stackVerseKeyResponse.succeeded)
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
                                                            getJsonField(
                                                              quranAyahQuranFontImlaeiResponse
                                                                  .jsonBody,
                                                              r'''$.verses[:].text_imlaei''',
                                                            ).toString(),
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
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Text(
                                                          '${valueOrDefault<String>(
                                                            _model.verseID
                                                                ?.toString(),
                                                            '1',
                                                          )}.',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Text(
                                                            functions
                                                                .extractFromJson(
                                                                    getJsonField(
                                                              stackVerseKeyResponse
                                                                  .jsonBody,
                                                              r'''$.verse.words''',
                                                            )),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 15.0)),
                                              ),
                                            ),
                                          ),
                                        if (!quranAyahQuranFontImlaeiResponse
                                                .succeeded ||
                                            !stackVerseKeyResponse.succeeded)
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
                                                        1.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 10.0)),
                                          ),
                                      ].divide(SizedBox(height: 20.0)),
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
                                                      if (_model.verseID == 1) {
                                                        setState(() {
                                                          _model.surahID =
                                                              _model.surahID! +
                                                                  -1;
                                                        });
                                                        setState(() {
                                                          _model.verseID =
                                                              getJsonField(
                                                            functions.getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                            r'''$.verses_count''',
                                                          );
                                                        });
                                                        setState(() {
                                                          _model.versesCount =
                                                              getJsonField(
                                                            functions.getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                            r'''$.verses_count''',
                                                          );
                                                        });
                                                        setState(() {
                                                          _model.surahName =
                                                              getJsonField(
                                                            functions.getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                            r'''$.name_simple''',
                                                          ).toString();
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _model.verseID =
                                                              _model.verseID! +
                                                                  -1;
                                                        });
                                                      }

                                                      await _model
                                                          .updateLikesAndMem(
                                                              context);
                                                      setState(() {});
                                                      setState(() {
                                                        FFAppState()
                                                                .quranLastReadVerse =
                                                            '${_model.surahID?.toString()}:${_model.verseID?.toString()}';
                                                      });
                                                      if (_model.audioPlaying) {
                                                        _model.soundPlayer
                                                            ?.stop();
                                                      }
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
                                                if (_model.verseID ==
                                                    _model.versesCount) {
                                                  if (widget.surahID != 114) {
                                                    setState(() {
                                                      _model.surahID =
                                                          _model.surahID! + 1;
                                                    });
                                                    setState(() {
                                                      _model.verseID = 1;
                                                    });
                                                    setState(() {
                                                      _model.versesCount =
                                                          getJsonField(
                                                        functions
                                                            .getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                        r'''$.verses_count''',
                                                      );
                                                    });
                                                    setState(() {
                                                      _model.surahName =
                                                          getJsonField(
                                                        functions
                                                            .getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                        r'''$.name_simple''',
                                                      ).toString();
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _model.surahID = 1;
                                                    });
                                                    setState(() {
                                                      _model.verseID = 1;
                                                    });
                                                    setState(() {
                                                      _model.versesCount =
                                                          getJsonField(
                                                        functions
                                                            .getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                        r'''$.verses_count''',
                                                      );
                                                    });
                                                    setState(() {
                                                      _model.surahName =
                                                          getJsonField(
                                                        functions
                                                            .getChapterDataByID(
                                                                functions
                                                                    .quranSurahEN()!,
                                                                _model
                                                                    .surahID!),
                                                        r'''$.name_simple''',
                                                      ).toString();
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    _model.verseID =
                                                        _model.verseID! + 1;
                                                  });
                                                }

                                                await _model
                                                    .updateLikesAndMem(context);
                                                setState(() {});
                                                if (FFAppState()
                                                    .quranVersesMemorized
                                                    .contains(
                                                        '${_model.surahID?.toString()}:${_model.verseID?.toString()}')) {
                                                  setState(() {
                                                    _model.memorized = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _model.memorized = false;
                                                  });
                                                }

                                                setState(() {
                                                  FFAppState().quranHasanat =
                                                      FFAppState()
                                                              .quranHasanat +
                                                          functions
                                                              .hasanatCalculator(
                                                                  getJsonField(
                                                            quranAyahQuranFontImlaeiResponse
                                                                .jsonBody,
                                                            r'''$.verses[:].text_imlaei''',
                                                          ).toString())!;
                                                });
                                                setState(() {
                                                  FFAppState().quranVersesRead =
                                                      FFAppState()
                                                              .quranVersesRead +
                                                          1;
                                                });
                                                setState(() {
                                                  FFAppState()
                                                          .quranLastReadVerse =
                                                      '${_model.surahID?.toString()}:${_model.verseID?.toString()}';
                                                });
                                                if (_model.audioPlaying) {
                                                  _model.soundPlayer?.stop();
                                                }
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
                                              AlignmentDirectional(0.0, 0.0),
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
                                                        if (!FFAppState()
                                                            .quranVersesMemorizedRemoveSession
                                                            .contains(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}')) {
                                                          FFAppState()
                                                              .addToQuranVersesMemorizedRemoveSession(
                                                                  '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                        } else {
                                                          FFAppState()
                                                              .removeFromQuranVersesMemorizedRemoveSession(
                                                                  '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                        }

                                                        FFAppState()
                                                            .removeFromQuranVersesMemorized(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
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
                                                        setState(() {
                                                          FFAppState()
                                                              .addToQuranVersesMemorized(
                                                                  '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
                                                        });
                                                        FFAppState()
                                                            .addToQuranVersesMemorizedAddSession(
                                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}');
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
                                                    0.0, 0.0),
                                                child: Text(
                                                  '+${functions.hasanatCalculator(getJsonField(
                                                        quranAyahQuranFontImlaeiResponse
                                                            .jsonBody,
                                                        r'''$.verses[:].text_imlaei''',
                                                      ).toString()).toString()}',
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
