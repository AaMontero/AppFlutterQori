import '../../theme/aza_bank_util.dart';
import 'package:flutter/material.dart';

class ComfirmTranferModel extends AzaBankModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textController?.dispose();
  }

/// Additional helper methods are added here.
}
