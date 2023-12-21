import 'package:aza_bank/main.dart';
import 'package:aza_bank/pages/transfer_funds/transferencia_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import 'package:flutter/material.dart';
import 'comfirm_tranfer_model.dart';
export 'comfirm_tranfer_model.dart';

class ComfirmTranferWidget extends StatefulWidget {
   final String opcionSeleccionada;
   final String montoTransferencia;
   final TextEditingController cuentaDestinoController;
   final TextEditingController propietarioController;

   const ComfirmTranferWidget({
     Key? key,
     required this.opcionSeleccionada,
     required this.montoTransferencia,
     required this.cuentaDestinoController,
     required this.propietarioController,
   }) : super(key: key);

  @override
  _ComfirmTranferWidgetState createState() => _ComfirmTranferWidgetState();
}

class _ComfirmTranferWidgetState extends State<ComfirmTranferWidget> {
  late ComfirmTranferModel _model;
  var db = FirebaseFirestore.instance;
  String? identificacionUsuarioActivo;
  String? nombresUsuarioActivo;
  double? saldoActualM;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
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
  void realizarSolicitudTrasnferencia(
      bancoDestino, cuentaDestino, propietarioCtaDestino,monto) async {
    try {
      String? fechaString = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final solTransaccion = <String, dynamic>{
        "banco_destino": bancoDestino,
        "cuenta_destino": cuentaDestino,
        "propietario_cta_dest": propietarioCtaDestino,
        "estado": true,
        "fecha": fechaString,
        "identificacion": identificacionUsuarioActivo,
        "monto": monto,
        "saldo": saldoActualM,
      };
      db
          .collection("solicitudTransferencia")
          .doc()
          .set(solTransaccion)
          .then((_) => print(
          'Documento agregado con éxito para el usuario:'));
    } catch (e) {
      print('Error al solicitar Transferencia: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    cargarDatos();
    _model = createModel(context, () => ComfirmTranferModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();

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
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {

                            Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => TransferenciaWidget()),
                            );
                          },

                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AzaBankTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Transferencia',
                          style: AzaBankTheme.of(context).headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Confirmar transaccion ',
                                style: AzaBankTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 0.0,
                        endIndent: 0.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Monto Transferencia',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '\$ ${widget.montoTransferencia}',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Cuenta Destino',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.cuentaDestinoController.text,
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Propietario Cuenta Destino',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.propietarioController.text,
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Banco',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.opcionSeleccionada!,
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  realizarSolicitudTrasnferencia(
                                      widget.opcionSeleccionada,
                                      widget.cuentaDestinoController.text,
                                      widget.propietarioController.text,
                                      double.parse(widget.montoTransferencia ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Transferencia exitosa',
                                        style: TextStyle(
                                          // Ajusta el estilo del mensaje según tus preferencias
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      duration: Duration(seconds: 3), // Duración del mensaje
                                      backgroundColor: Colors.green, // Color de fondo del mensaje
                                    ),
                                  );
                                  Navigator.push(
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
                                text: 'Confirmar Transferencia',
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
                      Padding(padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding:
                              EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 10.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                     var confirmDialogResponse = await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('¡Atención!'),
                                            content: Text('¿Cancelar esta transacción?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Si'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                          false;
                                      if (confirmDialogResponse) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TransferenciaWidget()),
                                        );
                                      }
                                    },

                                  text: 'Cancelar',
                                  options: FFButtonOptions(
                                    width: 130.0,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: Colors.blue,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
