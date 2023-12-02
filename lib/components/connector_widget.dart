import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'connector_model.dart';
export 'connector_model.dart';

class ConnectorWidget extends StatefulWidget {
  const ConnectorWidget({Key? key}) : super(key: key);

  @override
  _ConnectorWidgetState createState() => _ConnectorWidgetState();
}

class _ConnectorWidgetState extends State<ConnectorWidget> {
  late ConnectorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConnectorModel());

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
      width: 20.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }
}
