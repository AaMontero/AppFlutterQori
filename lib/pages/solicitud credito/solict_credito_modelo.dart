import '../../theme/aza_bank_util.dart';
import '../../theme/form_field_controller.dart';
import 'package:flutter/material.dart';

class SolicitCreditoModel extends AzaBankModel with ChangeNotifier {
  // State field(s) for PageView widget.
  late PageController pageViewController;

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  TextEditingController? textControllerResultado1;
  TextEditingController? textControllerCuotas;
  String? Function(BuildContext, String?)? textController1Validator;

  late bool camposLlenos;
  late bool mostrarError;
  late FocusNode focusNode;

  double montoCredito = 0.0;
  double intereses3 = 0.06;
  double intereses6 = 0.1;
  double gastosAdministrativos = 5;
  int cuotas = 3;
  int cuotas1 = 6;
  double resultado = 0.0;

  SolicitCreditoModel() {
    pageViewController = PageController(initialPage: 0);
    camposLlenos = false;
    mostrarError = false;
    focusNode = FocusNode();
  }

  void dispose() {
    textController1?.dispose();
    textControllerResultado1?.dispose();
    textControllerCuotas?.dispose();
    pageViewController.dispose();
    focusNode.dispose();
  }

  void calcularResultados() {
    double total;
    if (cuotas == 3) {
      total = (montoCredito * intereses3 + gastosAdministrativos) / cuotas;
    } else if (cuotas == 6) {
      total = (montoCredito * intereses6 + gastosAdministrativos) / cuotas1;
    } else {
      total = 0.0;
    }

    resultado = total;
    notifyListeners();
  }

  void initState(BuildContext context) {
    textController1Validator = (context, value) {
      camposLlenos = value?.isNotEmpty ?? false;
      mostrarError = focusNode.hasFocus && !camposLlenos;
      return mostrarError ? 'Llenar campo Monto Credito' : null;
    };

    textController1?.addListener(() {
      montoCredito = double.tryParse(textController1!.text) ?? 0.0;
      calcularResultados();
    });

    textControllerCuotas?.addListener(() {
      cuotas = int.tryParse(textControllerCuotas!.text) ?? 3;
      calcularResultados();
    });
    textControllerCuotas?.addListener(() {
      cuotas1 = int.tryParse(textControllerCuotas!.text) ?? 6;
      calcularResultados();
    });
  }
}