import '../../theme/aza_bank_util.dart';
import 'package:flutter/material.dart';

class RegisterPageModel extends AzaBankModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;



  late bool passwordVisibility;
  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
  }

  /// Additional helper methods are added here.
}
