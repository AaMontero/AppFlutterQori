
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '/main.dart';
import '/pages/comfirm_tranfer/comfirm_tranfer_widget.dart';
import 'package:flutter/material.dart';
import 'transferencia_model.dart';
export 'transferencia_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AhorroAporte {
  String concepto;
  String fecha;
  double monto;

  // Constructor
  AhorroAporte({
    required this.concepto,
    required this.fecha,
    required this.monto,
  });

  String toString() {
    return "Objeto Ahorro" + this.concepto + this.fecha + this.monto.toString();
  }
}


class TransferenciaWidget extends StatefulWidget {
  const TransferenciaWidget({Key? key}) : super(key: key);

  @override
  _TransferenciaWidgetState createState() => _TransferenciaWidgetState();
}

class _TransferenciaWidgetState extends State<TransferenciaWidget> {
  late TransferenciaModel _model;
  String? email;
  List<AhorroAporte> listaAportes = [];
  double? saldoTotal;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final TextEditingController montoController = TextEditingController();
  final TextEditingController cuentaDestinoController = TextEditingController();


  @override
  void initState() {
    super.initState();
    cargarDatosDesdeFireBase();
    _model = createModel(context, () => TransferenciaModel());

  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    montoController.dispose();

    cuentaDestinoController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AzaBankTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.scale,
                                alignment: Alignment.bottomCenter,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: NavBarPage(initialPage: 'HomePage'),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AzaBankTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Transferencias',
                            style: AzaBankTheme.of(context).headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        5.0, 0.0, 0.0, 0.0),
                    child: TextField(
                      controller: montoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Monto a transferir'),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 40.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 30.0,
                              color: Color(0x123629B7),
                              offset: Offset(0.0, 4.0),
                              spreadRadius: 30.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(
                                  10.0, 0.0, 0.0, 10.0),
                              child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding (
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: RichText(
                                text: TextSpan(
                                  style:
                                  AzaBankTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily:
                                    'Poppins',
                                    fontSize: 20.0,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Saldo Actual: ',
                                      style: TextStyle(
                                        color: AzaBankTheme.of(
                                            context)
                                            .primary, // Color azul
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\$$saldoTotal',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                          20.0 // Color negro
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: RichText(
                                text: TextSpan(
                                  style:
                                  AzaBankTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily:
                                    'Poppins',
                                    fontSize: 20.0,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Nombre: ',
                                      style: TextStyle(
                                        color: AzaBankTheme.of(
                                            context)
                                            .primary, // Color azul
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ],
                      ),

                            ),

                           ],
                        ),

                      ),

                    ),

                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        5.0, 0.0, 0.0, 0.0),
                    child: TextField(
                      controller: montoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Cuenta Destino'),
                    ),
                  ),

                ],
              ),

            ),
          ),
        ),
      ),
    );
  }


}