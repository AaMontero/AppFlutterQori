import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '/main.dart';
import '/pages/comfirm_tranfer/comfirm_tranfer_widget.dart';
import 'package:flutter/material.dart';
import 'transferencia_model.dart';
export 'transferencia_model.dart';

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
  String opcionSeleccionada = 'Banco Pichincha';
  List<String> opciones = ['Banco Pichincha', 'Produbanco', 'Banco Guayaquil'];
  String? cuentaDestino;
  String? propietarioCtaDestino;
  double? montoTrasnferir;
  var db = FirebaseFirestore.instance;
  double? saldoTotal;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final TextEditingController montoController = TextEditingController();
  final TextEditingController cuentaDestinoController = TextEditingController();
  final TextEditingController propietarioController = TextEditingController();
  String? identificacionUsuarioActivo;
  String? nombresUsuarioActivo;
  double? saldoActualM;

  final NumberFormat currencyFormat = NumberFormat("#,##0.00", "es_ES");



  Future<void> cargarDatos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? identificacionShared = prefs.getString('identificacion') ?? "";
      String? nombresShared = prefs.getString("nombres") ?? "";
      setState(() {
        identificacionUsuarioActivo = identificacionShared;
        nombresUsuarioActivo = nombresShared;
      });
    } catch (error) {
      print("Error al cargar datos desde Firebase: $error");
      return;
    }
    CollectionReference coleccionReference = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(identificacionUsuarioActivo)
        .collection("inversiones");
    QuerySnapshot ahorrosSnapshot = await coleccionReference.get();
    double sumaMontos = 0.0;
    ahorrosSnapshot.docs.forEach((documento) {
      double monto = double.parse(documento['monto'].toString());
      sumaMontos += monto;
    });
    setState(() {
      saldoActualM = sumaMontos;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarDatos();
    _model = createModel(context, () => TransferenciaModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    montoController.dispose();
    montoController.text = '\$0.00';
    cuentaDestinoController.dispose();
    propietarioController.dispose();
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 10.0, 0.0),
                    child: TextField(
                      controller: montoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}$'),
                        ),
                      ],
                      onTap: () {
                        if (montoController.text == '\$0.00') {
                          montoController.clear();
                        }
                      },
                      decoration:
                          InputDecoration(labelText: 'Monto a transferir'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      onChanged: (value) {
                        montoTrasnferir = double.parse(value);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 30.0),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 5.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: AzaBankTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: '${nombresUsuarioActivo} ',
                                            style: TextStyle(
                                              color: AzaBankTheme.of(context)
                                                  .primary, // Color azul
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 5.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: AzaBankTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: 'Saldo Actual: ',
                                            style: TextStyle(
                                              color: AzaBankTheme.of(context)
                                                  .primary, // Color azul
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\$$saldoActualM',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0 // Color negro
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 10.0, 0.0),
                    child: TextField(
                      controller: cuentaDestinoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Cuenta Destino'),
                      onChanged: (value) {
                        cuentaDestino = value;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 10.0, 0.0),
                    child: TextField(
                      controller: propietarioController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Propietario Cta. Destino'),
                      onChanged: (value) {
                        propietarioCtaDestino = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          //border: Border.all(color: Colors.grey),
                          //borderRadius: BorderRadius.circular(10.0),
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Seleccione un Banco:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DropdownButton<String>(
                                value: opcionSeleccionada,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      opcionSeleccionada = newValue;
                                    });
                                  }
                                },
                                items: opciones.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          //Text(
                          //'Opción seleccionada: $opcionSeleccionada',
                          //style: TextStyle(fontSize: 16),
                          //),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        //Validacion
                        if (montoController.text.isNotEmpty &&
                        cuentaDestinoController.text.isNotEmpty &&
                        propietarioController.text.isNotEmpty) {

                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: ComfirmTranferWidget(
                                opcionSeleccionada: opcionSeleccionada,
                                montoTransferencia: montoController.text,
                                cuentaDestinoController: cuentaDestinoController,
                                propietarioController: propietarioController,
                              ),
                            ),
                          );
                        }else{
                          //Mostrar mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Todos los campos son obligatorios'),
                          ));
                        }
                      },
                      text: 'Continuar',
                      options: FFButtonOptions(
                        width: 130.0,
                        height: 55.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AzaBankTheme.of(context).primary,
                        textStyle: AzaBankTheme.of(context).titleSmall.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
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
