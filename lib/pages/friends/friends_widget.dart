import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/friends_skeleton_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'friends_model.dart';
export 'friends_model.dart';

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({Key? key}) : super(key: key);

  @override
  _FriendsWidgetState createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  late FriendsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FriendsModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        body: Container(
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 25.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    Icons.arrow_back_outlined,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 250.0,
                                    child: TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController',
                                        Duration(milliseconds: 0),
                                        () async {
                                          await Future.delayed(const Duration(
                                              milliseconds: 1000));
                                          _model.searchRes =
                                              await SearchFriendsCall.call(
                                            query: _model.textController.text,
                                            filter:
                                                'NOT username:  ${valueOrDefault(currentUserDocument?.username, '')}',
                                          );
                                          if ((_model.searchRes?.succeeded ??
                                              true)) {
                                            setState(() {
                                              _model.searchResultJSON =
                                                  getJsonField(
                                                (_model.searchRes?.jsonBody ??
                                                    ''),
                                                r'''$.hits''',
                                                true,
                                              )!
                                                      .toList()
                                                      .cast<dynamic>();
                                            });
                                          }

                                          setState(() {});
                                        },
                                      ),
                                      autofocus: true,
                                      textInputAction: TextInputAction.search,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          '54wyphyw' /* Search for username */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 16.0,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        suffixIcon: _model
                                                .textController!.text.isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model.textController
                                                      ?.clear();
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 1000));
                                                  _model.searchRes =
                                                      await SearchFriendsCall
                                                          .call(
                                                    query: _model
                                                        .textController.text,
                                                    filter:
                                                        'NOT username:  ${valueOrDefault(currentUserDocument?.username, '')}',
                                                  );
                                                  if ((_model.searchRes
                                                          ?.succeeded ??
                                                      true)) {
                                                    setState(() {
                                                      _model.searchResultJSON =
                                                          getJsonField(
                                                        (_model.searchRes
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.hits''',
                                                        true,
                                                      )!
                                                              .toList()
                                                              .cast<dynamic>();
                                                    });
                                                  }

                                                  setState(() {});
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 22,
                                                ),
                                              )
                                            : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 16.0,
                                          ),
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
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
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.85,
                  decoration: BoxDecoration(),
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if ((_model.textController.text != null &&
                                _model.textController.text != '') &&
                            (_model.searchResultJSON.length > 0))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: StreamBuilder<
                                List<FriendRequestNotificationRecord>>(
                              stream: queryFriendRequestNotificationRecord(
                                queryBuilder:
                                    (friendRequestNotificationRecord) =>
                                        friendRequestNotificationRecord.where(
                                  'sender',
                                  isEqualTo: currentUserUid,
                                ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return FriendsSkeletonWidget();
                                }
                                List<FriendRequestNotificationRecord>
                                    containerFriendRequestNotificationRecordList =
                                    snapshot.data!;
                                return Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.85,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          if (_model.searchResultJSON.length >
                                              0)
                                            Builder(
                                              builder: (context) {
                                                final searchHit = _model
                                                    .searchResultJSON
                                                    .toList();
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: searchHit.length,
                                                  itemBuilder: (context,
                                                      searchHitIndex) {
                                                    final searchHitItem =
                                                        searchHit[
                                                            searchHitIndex];
                                                    return Visibility(
                                                      visible: functions
                                                              .jsonToString(
                                                                  getJsonField(
                                                            searchHitItem,
                                                            r'''$.uid''',
                                                          )) !=
                                                          currentUserUid,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    15.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'Profile',
                                                              queryParameters: {
                                                                'userId':
                                                                    serializeParam(
                                                                  getJsonField(
                                                                    searchHitItem,
                                                                    r'''$.uid''',
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.00,
                                                                        0.00),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            55.0,
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Container(
                                                                              width: 45.0,
                                                                              height: 45.0,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.network(
                                                                                getJsonField(
                                                                                  searchHitItem,
                                                                                  r'''$.photo_url''',
                                                                                ),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(1.00, 1.00),
                                                                              child: Container(
                                                                                width: 25.0,
                                                                                height: 25.0,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(100.0),
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(100.0),
                                                                                  child: Image.network(
                                                                                    'https://flagcdn.com/w40/${getJsonField(
                                                                                      searchHitItem,
                                                                                      r'''$.nationality''',
                                                                                    ).toString()}.png',
                                                                                    width: 25.0,
                                                                                    height: 25.0,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      searchHitItem,
                                                                                      r'''$.username''',
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      searchHitItem,
                                                                                      r'''$.display_name''',
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: 12.0,
                                                                                        ),
                                                                                  ),
                                                                                ].divide(SizedBox(height: 2.5)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          if (containerFriendRequestNotificationRecordList
                                                                                  .where((e) =>
                                                                                      (e.receiver ==
                                                                                          getJsonField(
                                                                                            searchHitItem,
                                                                                            r'''$.uid''',
                                                                                          )) &&
                                                                                      (e.accepted == true))
                                                                                  .toList()
                                                                                  .length ==
                                                                              1)
                                                                            FFButtonWidget(
                                                                              onPressed: () {
                                                                                print('Button pressed ...');
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'vbhqiyxr' /* Friends */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: Color(0xFF009BDD),
                                                                                      fontSize: 12.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                                borderSide: BorderSide(
                                                                                  color: Color(0xFF009BDD),
                                                                                  width: 1.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                          if (containerFriendRequestNotificationRecordList
                                                                                  .where((e) =>
                                                                                      e.receiver ==
                                                                                      getJsonField(
                                                                                        searchHitItem,
                                                                                        r'''$.uid''',
                                                                                      ))
                                                                                  .toList()
                                                                                  .length ==
                                                                              0)
                                                                            FFButtonWidget(
                                                                              onPressed: () async {
                                                                                _model.userToAdd = await queryUsersRecordOnce(
                                                                                  queryBuilder: (usersRecord) => usersRecord.where(
                                                                                    'uid',
                                                                                    isEqualTo: getJsonField(
                                                                                      searchHitItem,
                                                                                      r'''$.uid''',
                                                                                    ).toString(),
                                                                                  ),
                                                                                  singleRecord: true,
                                                                                ).then((s) => s.firstOrNull);

                                                                                await FriendRequestNotificationRecord.collection.doc().set(createFriendRequestNotificationRecordData(
                                                                                      sender: currentUserUid,
                                                                                      receiver: _model.userToAdd?.uid,
                                                                                      accepted: false,
                                                                                      createdAt: getCurrentTimestamp.secondsSinceEpoch,
                                                                                    ));
                                                                                _model.targetUserRef = await queryUsersRecordOnce(
                                                                                  queryBuilder: (usersRecord) => usersRecord.where(
                                                                                    'uid',
                                                                                    isEqualTo: getJsonField(
                                                                                      searchHitItem,
                                                                                      r'''$.uid''',
                                                                                    ).toString(),
                                                                                  ),
                                                                                  singleRecord: true,
                                                                                ).then((s) => s.firstOrNull);

                                                                                await _model.targetUserRef!.reference.update(createUsersRecordData(
                                                                                  notificationsRead: false,
                                                                                ));
                                                                                triggerPushNotification(
                                                                                  notificationTitle: 'Hasanati',
                                                                                  notificationText: '${valueOrDefault(currentUserDocument?.username, '')} just sent you a friend request.',
                                                                                  notificationImageUrl: 'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/app_launcher_icon.png?alt=media',
                                                                                  notificationSound: 'default',
                                                                                  userRefs: [
                                                                                    _model.userToAdd!.reference
                                                                                  ],
                                                                                  initialPageName: 'Notification',
                                                                                  parameterData: {},
                                                                                );

                                                                                setState(() {});
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'wl7cuwpy' /* Add Friend */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: Color(0xFF009BDD),
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: Colors.white,
                                                                                      fontSize: 12.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.transparent,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                          if (containerFriendRequestNotificationRecordList
                                                                                  .where((e) =>
                                                                                      (e.receiver ==
                                                                                          getJsonField(
                                                                                            searchHitItem,
                                                                                            r'''$.uid''',
                                                                                          )) &&
                                                                                      (e.accepted == false))
                                                                                  .toList()
                                                                                  .length ==
                                                                              1)
                                                                            FFButtonWidget(
                                                                              onPressed: () {
                                                                                print('Button pressed ...');
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'vxuggf1k' /* Request Sent */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 12.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                                borderSide: BorderSide(
                                                                                  color: Color(0xFFEEEEEE),
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            12.5)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: 1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFE8E8E8),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        if ((_model.textController.text != null &&
                                _model.textController.text != '') &&
                            (_model.searchResultJSON.length == 0))
                          Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/marginalia-man-with-binocular.png',
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'l1bfjt8w' /* No results found */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    width: 200.0,
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 5.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'lbqosu86' /* Try searching for something el... */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Color(0xFF545454),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        context.goNamed('Home');
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'c6ffzpil' /* Back Home */,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.black,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              fontSize: 14.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_model.textController.text == null ||
                            _model.textController.text == '')
                          Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/marginalia-planning-a-trip.png',
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'uul1cb38' /* Find friends */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Container(
                                            width: 220.0,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'inkyq97g' /* Build your own community and c... */,
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF545454),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
