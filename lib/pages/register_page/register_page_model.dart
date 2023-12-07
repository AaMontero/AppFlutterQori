import '../../theme/aza_bank_util.dart';
import 'package:flutter/material.dart';

class RegisterPageModel extends AzaBankModel {
  ///  State fields for stateful widgets in this page.

  TextEditingController? textController1; //Controlller Correo Electrónico
  String? Function(BuildContext, String?)? textController1Validator;
  TextEditingController? textController2; //Controller Celular
  String? Function(BuildContext, String?)? textController2Validator;
  TextEditingController? textController3; //Controller Contraseña
  String? Function(BuildContext, String?)? textController3Validator;
  TextEditingController? textController4; //Controller Nombres
  String? Function(BuildContext, String?)? textController4Validator;
  TextEditingController? textController5; // Controller Apellidos
  String? Function(BuildContext, String?)? textController5Validator;
  TextEditingController? textController6; //Controller Empresa
  String? Function(BuildContext, String?)? textController6Validator;
  TextEditingController? textController7; //Controller Cargo
  String? Function(BuildContext, String?)? textController7Validator;



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
