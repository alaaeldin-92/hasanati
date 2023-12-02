import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'circular_progress_model.dart';
export 'circular_progress_model.dart';

class CircularProgressWidget extends StatefulWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  _CircularProgressWidgetState createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget> {
  late CircularProgressModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CircularProgressModel());

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

    return CircularPercentIndicator(
      percent: 0.0,
      radius: 15.0,
      lineWidth: 6.0,
      animation: true,
      animateFromLastPercent: true,
      progressColor: Color(0xFF009BDD),
      backgroundColor: Color(0xFFE9E9E9),
    );
  }
}
