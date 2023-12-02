import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'friends_widget.dart' show FriendsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsModel extends FlutterFlowModel<FriendsWidget> {
  ///  Local state fields for this page.

  List<dynamic> searchResultJSON = [];
  void addToSearchResultJSON(dynamic item) => searchResultJSON.add(item);
  void removeFromSearchResultJSON(dynamic item) =>
      searchResultJSON.remove(item);
  void removeAtIndexFromSearchResultJSON(int index) =>
      searchResultJSON.removeAt(index);
  void insertAtIndexInSearchResultJSON(int index, dynamic item) =>
      searchResultJSON.insert(index, item);
  void updateSearchResultJSONAtIndex(int index, Function(dynamic) updateFn) =>
      searchResultJSON[index] = updateFn(searchResultJSON[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Search Friends)] action in TextField widget.
  ApiCallResponse? searchRes;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? userToAdd;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? targetUserRef;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
