import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'leaderboard_skeleton_container_model.dart';
export 'leaderboard_skeleton_container_model.dart';

class LeaderboardSkeletonContainerWidget extends StatefulWidget {
  const LeaderboardSkeletonContainerWidget({Key? key}) : super(key: key);

  @override
  _LeaderboardSkeletonContainerWidgetState createState() =>
      _LeaderboardSkeletonContainerWidgetState();
}

class _LeaderboardSkeletonContainerWidgetState
    extends State<LeaderboardSkeletonContainerWidget> {
  late LeaderboardSkeletonContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaderboardSkeletonContainerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 410.0,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SvgPicture.asset(
                              'assets/images/Group_7.svg',
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              fit: BoxFit.cover,
                              alignment: Alignment(0.0, -1.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 80.0, 0.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 200.0,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 25.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 50.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x65E6E6E6),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 80.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 2.0)),
                                          ),
                                        ].divide(SizedBox(height: 5.0)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x65E6E6E6),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 80.0,
                                              height: 15.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x65E6E6E6),
                                              ),
                                            ),
                                            Container(
                                              width: 40.0,
                                              height: 15.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x65E6E6E6),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 2.0)),
                                        ),
                                      ].divide(SizedBox(height: 5.0)),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 75.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x65E6E6E6),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 80.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x65E6E6E6),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 2.0)),
                                          ),
                                        ].divide(SizedBox(height: 5.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 0.0, 25.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFADEF),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 10.0, 15.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE28AD3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 15.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE28AD3),
                                            ),
                                          ),
                                          Container(
                                            width: 120.0,
                                            height: 15.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE28AD3),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 5.0)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 15.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 380.0, 0.0, 0.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFEFEEFC),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 70.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 20.0, 15.0, 0.0),
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x65E6E6E6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 120.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 15.0)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x65E6E6E6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 120.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 15.0)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x65E6E6E6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 120.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 15.0)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x65E6E6E6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 120.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 15.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x65E6E6E6),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 15.0)),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
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
          ],
        ),
      ),
    );
  }
}
