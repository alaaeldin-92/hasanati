import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth_complete_profile1_model.dart';
export 'auth_complete_profile1_model.dart';

class AuthCompleteProfile1Widget extends StatefulWidget {
  const AuthCompleteProfile1Widget({Key? key}) : super(key: key);

  @override
  _AuthCompleteProfile1WidgetState createState() =>
      _AuthCompleteProfile1WidgetState();
}

class _AuthCompleteProfile1WidgetState
    extends State<AuthCompleteProfile1Widget> {
  late AuthCompleteProfile1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthCompleteProfile1Model());

    _model.usernameController ??= TextEditingController();
    _model.usernameFocusNode ??= FocusNode();

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Stack(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/images/wave.png',
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 55.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.asset(
                          'assets/images/wave.png',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/marginalia-meditating-man.png',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(40.0, 40.0, 40.0, 0.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'uqdkyq10' /* Complete your profile (1/2) */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller:
                                                  _model.usernameController,
                                              focusNode:
                                                  _model.usernameFocusNode,
                                              autofillHints: [
                                                AutofillHints.password
                                              ],
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'eyyx7pp8' /* Username */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                errorStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      fontSize: 12.0,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                filled: true,
                                                fillColor: Color(0xFFEEEEEE),
                                                contentPadding:
                                                    EdgeInsets.all(20.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .usernameControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (!_model.validUsername)
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '6yryhzi3' /* Username is already taken. */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                  ].divide(SizedBox(height: 10.0)),
                                ),
                              ].divide(SizedBox(height: 20.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          if (_model.formKey.currentState ==
                                                  null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          _model.usernameQuery =
                                              await queryUsersRecordOnce(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'username',
                                              isEqualTo: _model
                                                  .usernameController.text,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);
                                          if (_model.usernameQuery != null) {
                                            setState(() {
                                              _model.validUsername = false;
                                            });
                                          } else {
                                            setState(() {
                                              _model.validUsername = true;
                                            });

                                            await currentUserReference!
                                                .update(createUsersRecordData(
                                              username: _model
                                                  .usernameController.text,
                                            ));

                                            context.pushNamed(
                                                'AuthCompleteProfile2');
                                          }

                                          setState(() {});
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'gl1cr3pw' /* Next */,
                                        ),
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 50.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Colors.white,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Color(0xFF009BDD),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Color(0xFF009BDD),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 20.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '84r0bkfj' /* By submitting, you agree to ou... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF888888),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                          ].divide(SizedBox(height: 20.0)),
                        ),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
