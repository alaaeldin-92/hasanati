import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'auth_main_widget.dart' show AuthMainWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthMainModel extends FlutterFlowModel<AuthMainWidget> {
  ///  Local state fields for this page.

  String choice = 'Sign In';

  String? authErrorSignIn;

  String authErrorSignUp = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for emailAddressSignIn widget.
  FocusNode? emailAddressSignInFocusNode;
  TextEditingController? emailAddressSignInController;
  String? Function(BuildContext, String?)?
      emailAddressSignInControllerValidator;
  String? _emailAddressSignInControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '82tbe9qi' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for passwordSignIn widget.
  FocusNode? passwordSignInFocusNode;
  TextEditingController? passwordSignInController;
  late bool passwordSignInVisibility;
  String? Function(BuildContext, String?)? passwordSignInControllerValidator;
  String? _passwordSignInControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'bt1az9xx' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for CheckboxSignIn widget.
  bool? checkboxSignInValue;
  // State field(s) for emailAddressSignUp widget.
  FocusNode? emailAddressSignUpFocusNode;
  TextEditingController? emailAddressSignUpController;
  String? Function(BuildContext, String?)?
      emailAddressSignUpControllerValidator;
  String? _emailAddressSignUpControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'va933n53' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for passwordSignUp widget.
  FocusNode? passwordSignUpFocusNode;
  TextEditingController? passwordSignUpController;
  late bool passwordSignUpVisibility;
  String? Function(BuildContext, String?)? passwordSignUpControllerValidator;
  String? _passwordSignUpControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'r8ernly9' /* Field is required */,
      );
    }

    if (val.length < 6) {
      return 'Requires at least 6 characters.';
    }

    return null;
  }

  // State field(s) for confirmPasswordSignUp widget.
  FocusNode? confirmPasswordSignUpFocusNode;
  TextEditingController? confirmPasswordSignUpController;
  late bool confirmPasswordSignUpVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordSignUpControllerValidator;
  String? _confirmPasswordSignUpControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'i7ehv3f6' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for CheckboxSignUp widget.
  bool? checkboxSignUpValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    emailAddressSignInControllerValidator =
        _emailAddressSignInControllerValidator;
    passwordSignInVisibility = false;
    passwordSignInControllerValidator = _passwordSignInControllerValidator;
    emailAddressSignUpControllerValidator =
        _emailAddressSignUpControllerValidator;
    passwordSignUpVisibility = false;
    passwordSignUpControllerValidator = _passwordSignUpControllerValidator;
    confirmPasswordSignUpVisibility = false;
    confirmPasswordSignUpControllerValidator =
        _confirmPasswordSignUpControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressSignInFocusNode?.dispose();
    emailAddressSignInController?.dispose();

    passwordSignInFocusNode?.dispose();
    passwordSignInController?.dispose();

    emailAddressSignUpFocusNode?.dispose();
    emailAddressSignUpController?.dispose();

    passwordSignUpFocusNode?.dispose();
    passwordSignUpController?.dispose();

    confirmPasswordSignUpFocusNode?.dispose();
    confirmPasswordSignUpController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
