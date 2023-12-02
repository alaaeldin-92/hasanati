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
      });
      setState(() {
        _model.verseID = widget.ayahNumber;
      });
      setState(() {
        _model.versesCount = widget.versesCount;
      });
      setState(() {
        _model.surahName = widget.surahName!;
      });
      await _model.updateLikesAndMem(context);
      setState(() {});
      FFAppState().quranVerseTraverseUpdated = true;
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
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
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

                                    _model.syncQuranPerformance =
                                        await queryQuranPerformanceRecordOnce(
                                      queryBuilder: (quranPerformanceRecord) =>
                                          quranPerformanceRecord.where(
                                        'user',
                                        isEqualTo: currentUserUid,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);

                                    await _model.syncQuranPerformance!.reference
                                        .update(
                                            createQuranPerformanceRecordData(
                                      hasanat: FFAppState().quranHasanat,
                                      timeReadSec:
                                          FFAppState().quranTimeReadSec,
                                      versesRead: FFAppState().quranVersesRead,
                                    ));
                                    _model.syncLastRead =
                                        await queryQuranLastReadVerseRecordOnce(
                                      queryBuilder:
                                          (quranLastReadVerseRecord) =>
                                              quranLastReadVerseRecord.where(
                                        'user',
                                        isEqualTo: currentUserUid,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);

                                    await _model.syncLastRead!.reference.update(
                                        createQuranLastReadVerseRecordData(
                                      verse: FFAppState().quranLastReadVerse,
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
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
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
                                                    FFAppState().quranHasanat),
                                                '0',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                FaIcon(
                                  FontAwesomeIcons.ellipsisH,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                          if (false)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE3F7FE),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 15.0, 15.0, 15.0),
                                        child: Column(
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
                                                    'cm4qverv' /* Qur'an Tracking */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF0E4051),
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF2883A9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 5.0,
                                                                10.0, 5.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '4oli4w2r' /* Total: 2 min */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF6BB9DB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                10.0,
                                                                15.0,
                                                                10.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '47nzikxz' /* 0 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF6BB9DB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                10.0,
                                                                15.0,
                                                                10.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'l29nv527' /* 0 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'i36dnldn' /* : */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF0E4051),
                                                        fontSize: 22.0,
                                                      ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF6BB9DB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                10.0,
                                                                15.0,
                                                                10.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ae2g9nvn' /* 0 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF6BB9DB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                10.0,
                                                                15.0,
                                                                10.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'rek8nqea' /* 0 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 10.0)),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child:
                                                        LinearPercentIndicator(
                                                      percent: functions.divide(
                                                          functions.add(
                                                              _model.verseID!,
                                                              -1)!,
                                                          _model.versesCount!)!,
                                                      lineHeight: 10.0,
                                                      animation: false,
                                                      animateFromLastPercent:
                                                          true,
                                                      progressColor:
                                                          Color(0xFF009BDF),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                      barRadius:
                                                          Radius.circular(20.0),
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'rhmz8b19' /* 5/10 */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'fvju53i5' /* 5 verses left */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                                Text(
                                                  '${functions.round(functions.multiply(functions.divide(functions.add(_model.verseID!, -1)!, _model.versesCount!)!, 100.0)!).toString()}%',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ].divide(SizedBox(width: 15.0)),
                                            ),
                                          ].divide(SizedBox(height: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if ((currentUserDocument?.friends?.toList() ?? [])
                                  .length >
                              0)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 30.0, 0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF025275),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00191F),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(30.0),
                                                topRight: Radius.circular(30.0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20.0, 20.0,
                                                          20.0, 0.0),
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
                                                                          7.5,
                                                                          7.5,
                                                                          7.5,
                                                                          7.5),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .userFriends,
                                                                color: Color(
                                                                    0xFF009BDF),
                                                                size: 12.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'rx4fnk44' /* Online Friends */,
                                                            ),
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
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'hyq1p8k7' /* 20/30 Online */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
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
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 20.0, 0.0),
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
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                width: 30.0,
                                                                height: 30.0,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmVhbCUyMHBlb3BsZXxlbnwwfHwwfHx8MA%3D%3D',
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                                child:
                                                                    Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyiZQJQ_lbGqDu9v04zHpDHqVRXUB-oOTZtg&usqp=CAU',
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                                child:
                                                                    Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://images.unsplash.com/photo-1463453091185-61582044d556?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmVhbCUyMHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D',
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                                child:
                                                                    Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDd_LFpavoNIrdaDqPVDfPu_mcEF6CEoW6qQ&usqp=CAU',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        100.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLnAqlHRpvixM9cViXrPpIhwjpIcjLSxIIcg&usqp=CAU',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 10.0)),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'e3nfzrgj' /* See All */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 35.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFF009BDF),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14.0,
                                                                  ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEEEEEE),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 5.0, 5.0, 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'ec79bx73' /* Verse */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'QuranPage',
                                                  queryParameters: {
                                                    'page': serializeParam(
                                                      FFAppState()
                                                          .quranLastReadPage,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0x00FFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 5.0, 15.0, 5.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
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
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                BorderRadius.circular(100.0),
                                          ),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (!_model.audioPlaying)
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
                                                    _model.audioJSON =
                                                        await VerseAudioCall
                                                            .call(
                                                      surahID: _model.surahID,
                                                      ayahID: _model.verseID,
                                                      reciterID: 4,
                                                    );
                                                    _model.soundPlayer ??=
                                                        AudioPlayer();
                                                    if (_model
                                                        .soundPlayer!.playing) {
                                                      await _model.soundPlayer!
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
                                                    });
                                                    setState(() {
                                                      _model.audioPlaying =
                                                          true;
                                                    });
                                                    while (_model.timeCounter! <
                                                        _model.duration!) {
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
                                                    });
                                                    setState(() {
                                                      _model.timeCounter = 0.0;
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.play_arrow,
                                                    color: Color(0xFF2F2F2F),
                                                    size: 24.0,
                                                  ),
                                                ),
                                              if (_model.audioPlaying)
                                                CircularPercentIndicator(
                                                  percent:
                                                      functions.divideDouble(
                                                          _model.timeCounter!,
                                                          _model
                                                              .audioDuration!),
                                                  radius: 22.5,
                                                  lineWidth: 5.0,
                                                  animation: false,
                                                  animateFromLastPercent: true,
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
                                                    _model.soundPlayer?.stop();
                                                    setState(() {
                                                      _model.audioPlaying =
                                                          false;
                                                    });
                                                    setState(() {
                                                      _model.timeCounter = 0.0;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.pause_sharp,
                                                    color: Color(0xFF009BDF),
                                                    size: 24.0,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          _model.surahName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: Color(0xFF2F2F2F),
                                              ),
                                        ),
                                        Text(
                                          '${_model.verseID?.toString()}/${_model.versesCount?.toString()}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                    color: Color(0xFF2F2F2F),
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
                                                      _model.hearted = false;
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
                                                    color: FlutterFlowTheme.of(
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
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 2.0)),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 100.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Text(
                                                  getJsonField(
                                                    quranAyahQuranFontImlaeiResponse
                                                        .jsonBody,
                                                    r'''$.verses[:].text_imlaei''',
                                                  ).toString(),
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Muhammadi ',
                                                        fontSize: 28.0,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: FutureBuilder<
                                                    ApiCallResponse>(
                                                  future: VerseKeyCall.call(
                                                    chapter: _model.surahID,
                                                    verse: _model.verseID,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final textVerseKeyResponse =
                                                        snapshot.data!;
                                                    return Text(
                                                      functions.extractFromJson(
                                                          getJsonField(
                                                        textVerseKeyResponse
                                                            .jsonBody,
                                                        r'''$.verse.words''',
                                                      )),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(height: 15.0)),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 20.0)),
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
                                width: MediaQuery.sizeOf(context).width * 1.0,
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
                                        disabledIconColor: Color(0xFFB3B3B3),
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Color(0xFF0E4051),
                                          size: 38.0,
                                        ),
                                        onPressed: (_model.surahID == 1) &&
                                                (_model.verseID == 1)
                                            ? null
                                            : () async {
                                                HapticFeedback.selectionClick();
                                                if (_model.verseID == 1) {
                                                  setState(() {
                                                    _model.surahID =
                                                        _model.surahID! + -1;
                                                  });
                                                  setState(() {
                                                    _model.verseID =
                                                        getJsonField(
                                                      functions.getChapterDataByID(
                                                          functions
                                                              .quranSurahEN()!,
                                                          _model.surahID!),
                                                      r'''$.verses_count''',
                                                    );
                                                  });
                                                  setState(() {
                                                    _model.versesCount =
                                                        getJsonField(
                                                      functions.getChapterDataByID(
                                                          functions
                                                              .quranSurahEN()!,
                                                          _model.surahID!),
                                                      r'''$.verses_count''',
                                                    );
                                                  });
                                                  setState(() {
                                                    _model.surahName =
                                                        getJsonField(
                                                      functions.getChapterDataByID(
                                                          functions
                                                              .quranSurahEN()!,
                                                          _model.surahID!),
                                                      r'''$.name_simple''',
                                                    ).toString();
                                                  });
                                                } else {
                                                  setState(() {
                                                    _model.verseID =
                                                        _model.verseID! + -1;
                                                  });
                                                }

                                                await _model
                                                    .updateLikesAndMem(context);
                                                setState(() {});
                                                setState(() {
                                                  FFAppState()
                                                          .quranLastReadVerse =
                                                      '${_model.surahID?.toString()}:${_model.verseID?.toString()}';
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
                                                  functions.getChapterDataByID(
                                                      functions.quranSurahEN()!,
                                                      _model.surahID!),
                                                  r'''$.verses_count''',
                                                );
                                              });
                                              setState(() {
                                                _model.surahName = getJsonField(
                                                  functions.getChapterDataByID(
                                                      functions.quranSurahEN()!,
                                                      _model.surahID!),
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
                                                  functions.getChapterDataByID(
                                                      functions.quranSurahEN()!,
                                                      _model.surahID!),
                                                  r'''$.verses_count''',
                                                );
                                              });
                                              setState(() {
                                                _model.surahName = getJsonField(
                                                  functions.getChapterDataByID(
                                                      functions.quranSurahEN()!,
                                                      _model.surahID!),
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
                                                FFAppState().quranHasanat +
                                                    functions.hasanatCalculator(
                                                        getJsonField(
                                                      quranAyahQuranFontImlaeiResponse
                                                          .jsonBody,
                                                      r'''$.verses[:].text_imlaei''',
                                                    ).toString())!;
                                          });
                                          setState(() {
                                            FFAppState().quranVersesRead =
                                                FFAppState().quranVersesRead +
                                                    1;
                                          });
                                          setState(() {
                                            FFAppState().quranLastReadVerse =
                                                '${_model.surahID?.toString()}:${_model.verseID?.toString()}';
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
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 35.0),
                                      child: Container(
                                        width: 90.0,
                                        height: 90.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(100.0),
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
                                                fillColor: Color(0xFF009BDF),
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 30.0,
                                                ),
                                                onPressed: () async {
                                                  HapticFeedback
                                                      .selectionClick();
                                                  setState(() {
                                                    _model.memorized = false;
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
                                                borderColor: Color(0xFF0E4051),
                                                borderRadius: 100.0,
                                                borderWidth: 4.0,
                                                buttonSize: 60.0,
                                                fillColor: Colors.white,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Color(0xFF0E4051),
                                                  size: 30.0,
                                                ),
                                                onPressed: () async {
                                                  HapticFeedback
                                                      .selectionClick();
                                                  setState(() {
                                                    _model.memorized = true;
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
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Text(
                                            '+${functions.hasanatCalculator(getJsonField(
                                                  quranAyahQuranFontImlaeiResponse
                                                      .jsonBody,
                                                  r'''$.verses[:].text_imlaei''',
                                                ).toString()).toString()}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF0E4051),
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w900,
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
            ),
          ),
        );
      },
    );
  }
}
