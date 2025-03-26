import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String? userId;

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

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

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: widget.userId,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF009BDD),
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
        List<UsersRecord> profileUsersRecordList = snapshot.data!;
        final profileUsersRecord = profileUsersRecordList.isNotEmpty
            ? profileUsersRecordList.first
            : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF009BDD),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 25.0, 20.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.97,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 40.0, 0.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 50.0, 20.0, 20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                profileUsersRecord!.displayName,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF0C092A),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              Text(
                                                '@${profileUsersRecord?.username}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 5.0)),
                                          ),
                                          StreamBuilder<
                                              List<QuranPerformanceRecord>>(
                                            stream: queryQuranPerformanceRecord(
                                              queryBuilder:
                                                  (quranPerformanceRecord) =>
                                                      quranPerformanceRecord
                                                          .where(
                                                'user',
                                                isEqualTo: widget.userId,
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
                                              List<QuranPerformanceRecord>
                                                  containerQuranPerformanceRecordList =
                                                  snapshot.data!;
                                              // Return an empty Container when the item does not exist.
                                              if (snapshot.data!.isEmpty) {
                                                return Container();
                                              }
                                              final containerQuranPerformanceRecord =
                                                  containerQuranPerformanceRecordList
                                                          .isNotEmpty
                                                      ? containerQuranPerformanceRecordList
                                                          .first
                                                      : null;
                                              return Container(
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF009BDD),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.diamond,
                                                              color:
                                                                  Colors.white,
                                                              size: 28.0,
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '3p4t7e9y' /* Points */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    fontSize:
                                                                        14.0,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '${valueOrDefault<String>(
                                                                functions.formatNumber(
                                                                    containerQuranPerformanceRecord!
                                                                        .hasanat),
                                                                '0',
                                                              )}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 3.0)),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 0.5,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: Color(
                                                                  0x33000000),
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.library_books,
                                                            color: Colors.white,
                                                            size: 28.0,
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'dvadv5yu' /* Verses */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                          ),
                                                          Text(
                                                            '${containerQuranPerformanceRecord?.versesRead.toString()}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 3.0)),
                                                      ),
                                                      Container(
                                                        width: 0.5,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.timer_sharp,
                                                            color: Colors.white,
                                                            size: 28.0,
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '63yir6ic' /* Time */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                          ),
                                                          Text(
                                                            '${valueOrDefault<String>(
                                                              functions.formatTime(
                                                                  containerQuranPerformanceRecord!
                                                                      .timeReadSec),
                                                              '00:00',
                                                            )}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 3.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 25.0)),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
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
                                                      _model.view = 'Friends';
                                                    });
                                                  },
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '4v2aefqp' /* Friends */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: _model
                                                                              .view ==
                                                                          'Friends'
                                                                      ? Color(
                                                                          0xFF0C092A)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                      if (_model.view ==
                                                          'Friends')
                                                        Container(
                                                          width: 7.5,
                                                          height: 7.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF0C092A),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                    ].divide(
                                                        SizedBox(height: 10.0)),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ijd9lpd1' /* Favorites */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: _model
                                                                        .view ==
                                                                    'Stats'
                                                                ? Color(
                                                                    0xFF009BDD)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    if (_model.view == 'Stats')
                                                      Container(
                                                        width: 7.5,
                                                        height: 7.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF009BDD),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    FaIcon(
                                                      FontAwesomeIcons.lock,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 14.0,
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ngba93ek' /* Stats */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: _model
                                                                        .view ==
                                                                    'Details'
                                                                ? Color(
                                                                    0xFF009BDD)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    if (_model.view ==
                                                        'Details')
                                                      Container(
                                                        width: 7.5,
                                                        height: 7.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF009BDD),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    FaIcon(
                                                      FontAwesomeIcons.lock,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 14.0,
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE5EEFA),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (profileUsersRecord!
                                                          .friends.length >
                                                      0)
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: PagedListView<
                                                          DocumentSnapshot<
                                                              Object?>?,
                                                          UsersRecord>.separated(
                                                        pagingController: _model
                                                            .setListViewController(
                                                          UsersRecord.collection
                                                              .whereIn(
                                                                  'uid',
                                                                  profileUsersRecord
                                                                              ?.friends !=
                                                                          ''
                                                                      ? profileUsersRecord
                                                                          ?.friends
                                                                      : null)
                                                              .orderBy('online',
                                                                  descending:
                                                                      true),
                                                        ),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        reverse: false,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                height: 10.0),
                                                        builderDelegate:
                                                            PagedChildBuilderDelegate<
                                                                UsersRecord>(
                                                          // Customize what your widget looks like when it's loading the first page.
                                                          firstPageProgressIndicatorBuilder:
                                                              (_) => Center(
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
                                                          ),
                                                          // Customize what your widget looks like when it's loading another page.
                                                          newPageProgressIndicatorBuilder:
                                                              (_) => Center(
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
                                                          ),

                                                          itemBuilder: (context,
                                                              _,
                                                              listViewIndex) {
                                                            final listViewUsersRecord = _model
                                                                    .listViewPagingController!
                                                                    .itemList![
                                                                listViewIndex];
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
                                                                context
                                                                    .pushNamed(
                                                                  'Profile',
                                                                  queryParameters:
                                                                      {
                                                                    'userId':
                                                                        serializeParam(
                                                                      listViewUsersRecord
                                                                          .uid,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: 80.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              60.0,
                                                                          height:
                                                                              60.0,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                width: 50.0,
                                                                                height: 50.0,
                                                                                clipBehavior: Clip.antiAlias,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Image.network(
                                                                                  listViewUsersRecord.photoUrl,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(1.0, 1.0),
                                                                                child: Container(
                                                                                  width: 30.0,
                                                                                  height: 30.0,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(100.0),
                                                                                  ),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(100.0),
                                                                                    child: Image.network(
                                                                                      'https://flagcdn.com/w40/${listViewUsersRecord.nationality}.png',
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      fit: BoxFit.contain,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Text(
                                                                              listViewUsersRecord.displayName,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    color: Color(0xFF0E0C23),
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 10.0)),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            10.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 25.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.safePop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 26.0,
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          width: 80.0,
                                          height: 80.0,
                                          child: Stack(
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                children: [
                                                  Container(
                                                    width: 70.0,
                                                    height: 70.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      profileUsersRecord!
                                                          .photoUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  if (profileUsersRecord
                                                          ?.online ??
                                                      true)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  3.0,
                                                                  3.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 10.0,
                                                        height: 10.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF04DD00),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                  child: Image.network(
                                                    'https://flagcdn.com/w40/${profileUsersRecord?.nationality}.png',
                                                    width: 40.0,
                                                    height: 40.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    StreamBuilder<
                                        List<FriendRequestNotificationRecord>>(
                                      stream:
                                          queryFriendRequestNotificationRecord(
                                        queryBuilder:
                                            (friendRequestNotificationRecord) =>
                                                friendRequestNotificationRecord
                                                    .where(
                                                      'sender',
                                                      isEqualTo: currentUserUid,
                                                    )
                                                    .where(
                                                      'receiver',
                                                      isEqualTo: widget.userId,
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
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFF009BDF),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<FriendRequestNotificationRecord>
                                            containerFriendRequestNotificationRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final containerFriendRequestNotificationRecord =
                                            containerFriendRequestNotificationRecordList
                                                    .isNotEmpty
                                                ? containerFriendRequestNotificationRecordList
                                                    .first
                                                : null;
                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if ((currentUserUid !=
                                                      profileUsersRecord
                                                          ?.uid) ||
                                                  !profileUsersRecord!.friends
                                                      .contains(currentUserUid))
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
                                                    _model.userToAdd =
                                                        await queryUsersRecordOnce(
                                                      queryBuilder:
                                                          (usersRecord) =>
                                                              usersRecord.where(
                                                        'uid',
                                                        isEqualTo:
                                                            widget.userId,
                                                      ),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);

                                                    await FriendRequestNotificationRecord
                                                        .collection
                                                        .doc()
                                                        .set(
                                                            createFriendRequestNotificationRecordData(
                                                          sender:
                                                              currentUserUid,
                                                          receiver:
                                                              widget.userId,
                                                          accepted: false,
                                                          createdAt:
                                                              getCurrentTimestamp
                                                                  .secondsSinceEpoch,
                                                        ));
                                                    _model.targetUserRef =
                                                        await queryUsersRecordOnce(
                                                      queryBuilder:
                                                          (usersRecord) =>
                                                              usersRecord.where(
                                                        'uid',
                                                        isEqualTo:
                                                            widget.userId,
                                                      ),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);

                                                    await _model.targetUserRef!
                                                        .reference
                                                        .update(
                                                            createUsersRecordData(
                                                      notificationsRead: false,
                                                    ));
                                                    if (_model.targetUserRef
                                                            ?.online !=
                                                        true) {}
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Hasanati',
                                                      notificationText:
                                                          '${valueOrDefault(currentUserDocument?.username, '')} just sent you a friend request.',
                                                      notificationImageUrl:
                                                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/app_launcher_icon.png?alt=media',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        _model.targetUserRef!
                                                            .reference
                                                      ],
                                                      initialPageName:
                                                          'Notification',
                                                      parameterData: {},
                                                    );

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.person_add,
                                                    color: Colors.white,
                                                    size: 26.0,
                                                  ),
                                                ),
                                              if (containerFriendRequestNotificationRecord
                                                      ?.accepted ==
                                                  false)
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'rzzlus6w' /* Pending */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 30.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFEEEEEE),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              if (containerFriendRequestNotificationRecord
                                                      ?.accepted ==
                                                  true)
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'waj8kzcb' /* Friends */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 30.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Color(0x00FFFFFF),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
