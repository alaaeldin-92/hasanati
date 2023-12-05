import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'skeleton_lines_model.dart';
export 'skeleton_lines_model.dart';

class SkeletonLinesWidget extends StatefulWidget {
  const SkeletonLinesWidget({Key? key}) : super(key: key);

  @override
  _SkeletonLinesWidgetState createState() => _SkeletonLinesWidgetState();
}

class _SkeletonLinesWidgetState extends State<SkeletonLinesWidget> {
  late SkeletonLinesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SkeletonLinesModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 15.0,
                decoration: BoxDecoration(
                  color: Color(0x65E6E6E6),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 15.0,
                          decoration: BoxDecoration(
                            color: Color(0x65E6E6E6),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: 50.0,
                                height: 15.0,
                                decoration: BoxDecoration(
                                  color: Color(0x65E6E6E6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 30.0)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: 50.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        color: Color(0x65E6E6E6),
                      ),
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ],
    );
  }
}
