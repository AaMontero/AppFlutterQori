import '../../theme/aza_bank_util.dart';
import '../../theme/form_field_controller.dart';
import 'package:flutter/material.dart';

class SolicitCreditoModel extends  AzaBankModel with ChangeNotifier {
  late PageController pageViewController;

  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textControllerResultado;
  TextEditingController? textControllerCuotas;
  String? Function(BuildContext, String?)? textController1Validator;
  String? Function(BuildContext, String?)? textController2Validator;
  String? Function(BuildContext, String?)? textController3Validator;

  late FocusNode focusNode;

  late bool camposLlenos;
  late bool mostrarError;

  double montoCredito = 0.0;
  double interes = 0.0;
  double gastosAdministrativos = 5.0;
  int cuotas = 3;
  double resultado = 0.0;

  SolicitCreditoModel() {
    pageViewController = PageController(initialPage: 0);
    camposLlenos = false;
    mostrarError = false;
    focusNode = FocusNode();
  }

  void dispose() {
    textController1?.dispose();
    textControllerCuotas?.dispose();
    textControllerResultado?.dispose();
    pageViewController.dispose();
    focusNode.dispose();
  }

  void calcularResultados() {
    interes = (cuotas == 3) ? 1.06 : (cuotas == 6) ? 1.1 : 0.0;
    resultado = (montoCredito * interes + gastosAdministrativos) / cuotas;
    textControllerResultado?.text = resultado.toString();
    notifyListeners();
  }

  void initState(BuildContext context) {
    textController1?.addListener(() {
      montoCredito = double.tryParse(textController1!.text) ?? 0.0;
      calcularResultados();
    });

    textControllerCuotas?.addListener(() {
      cuotas = int.tryParse(textControllerCuotas!.text) ?? 3;
      calcularResultados();
    });

    textController1Validator = (context, value) {
      camposLlenos = value?.isNotEmpty ?? false;
      mostrarError = focusNode.hasFocus && !camposLlenos;
      return mostrarError ? 'Llenar campo Monto Crédito' : null;
    };
  }
}