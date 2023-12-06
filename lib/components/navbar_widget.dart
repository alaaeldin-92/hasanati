import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({
    Key? key,
    int? selectedIndex,
  })  : this.selectedIndex = selectedIndex ?? 1,
        super(key: key);

  final int selectedIndex;

  @override
  _NavbarWidgetState createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());

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

    return Align(
      alignment: AlignmentDirectional(0.00, 1.00),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 14.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.goNamed(
                  'Home',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.home,
                    color: widget.selectedIndex == 1
                        ? FFAppState().LightPrimary
                        : FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'udp76wvq' /* Home */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: '72',
                          color: widget.selectedIndex == 1
                              ? FFAppState().LightPrimary
                              : FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 10.0,
                          useGoogleFonts: false,
                        ),
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('Friends');
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.userFriends,
                    color: widget.selectedIndex == 2
                        ? FFAppState().LightPrimary
                        : FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'i588fetq' /* Friends */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: '72',
                          color: widget.selectedIndex == 2
                              ? FFAppState().LightPrimary
                              : FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 10.0,
                          useGoogleFonts: false,
                        ),
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('Leaderboard');
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.trophy,
                    color: widget.selectedIndex == 3
                        ? FFAppState().LightPrimary
                        : FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'hksep5su' /* Ranking */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: '72',
                          color: widget.selectedIndex == 3
                              ? FFAppState().LightPrimary
                              : FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 10.0,
                          useGoogleFonts: false,
                        ),
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.goNamed(
                  'Settings',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.cog,
                    color: widget.selectedIndex == 4
                        ? FFAppState().LightPrimary
                        : FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'pa68ha39' /* Settings */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: '72',
                          color: widget.selectedIndex == 4
                              ? FFAppState().LightPrimary
                              : FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 10.0,
                          useGoogleFonts: false,
                        ),
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
