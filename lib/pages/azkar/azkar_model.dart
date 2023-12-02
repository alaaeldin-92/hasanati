import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'azkar_widget.dart' show AzkarWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AzkarModel extends FlutterFlowModel<AzkarWidget> {
  ///  Local state fields for this page.

  List<dynamic> azkarJSON = [];
  void addToAzkarJSON(dynamic item) => azkarJSON.add(item);
  void removeFromAzkarJSON(dynamic item) => azkarJSON.remove(item);
  void removeAtIndexFromAzkarJSON(int index) => azkarJSON.removeAt(index);
  void insertAtIndexInAzkarJSON(int index, dynamic item) =>
      azkarJSON.insert(index, item);
  void updateAzkarJSONAtIndex(int index, Function(dynamic) updateFn) =>
      azkarJSON[index] = updateFn(azkarJSON[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 1;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
