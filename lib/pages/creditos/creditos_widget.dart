
import 'package:aza_bank/pages/creditos/creditos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/aza_bank_model.dart';
import 'concreditos_widget.dart';
import 'sincreditos_widget.dart';

class CreditosWidget extends StatefulWidget {
  const CreditosWidget({Key? key}) : super(key: key);

  @override
  State<CreditosWidget> createState() => _CreditosWidgetState();

}

class _CreditosWidgetState extends State<CreditosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  bool? tieneCredito;
  String? identificacionUsuarioActivo;


  late CreditosModel _model;

  @override
  void initState() {
    super.initState();
        _model = createModel(context, () => CreditosModel());
        cargarSharedPreferences();
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }
  Future<void> cargarSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? identificacionShared = prefs.getString('identificacion') ?? "";
      setState(() {
        identificacionUsuarioActivo = identificacionShared;
      });
    } catch (error) {
      print("Error al cargar datos desde Firebase: $error");
      setState(() {
        tieneCredito = false;
      });
      return;
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(identificacionUsuarioActivo)
        .collection("creditos")
        .where("estado", whereIn: ["activo","Activo", "Morosidad","morosidada"])
        .get();

    bool tieneCreditoLocal = querySnapshot.docs.isNotEmpty;

    if (tieneCredito != tieneCreditoLocal) {
      setState(() {
        tieneCredito = tieneCreditoLocal;
      });
    }
    print("La longitud de la cadena es: "+ querySnapshot.docs.length.toString());
    print("Valor de verdad de tiene Credito:" + tieneCredito.toString());
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
    }
   Widget _buildContent(){
    if(tieneCredito==null) {
      return CircularProgressIndicator();
    } else if(tieneCredito!){
      return ConCreditosWidget();
    }else {
      return SinCreditosWidget();
    }
  }
}


