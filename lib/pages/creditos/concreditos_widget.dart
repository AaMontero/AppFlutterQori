import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import 'package:flutter/material.dart';

class ConCreditosWidget extends StatefulWidget {
  const ConCreditosWidget({Key? key}) : super(key: key);

  @override
  State<ConCreditosWidget> createState() => _ConCreditosWidgetState();
}

class _ConCreditosWidgetState extends State<ConCreditosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  bool tieneCredito = false;
  String? identificacionUsuarioActivo;
  String? nombresUsuarioActivo;
  String? apellidosUsuarioActivo;
  String? fechaPagoM;
  String? vencimientoM;
  int? cuotasRestantesM;
  String? tipoDeCobroM;
  String? estadoM;
  double? saldoM;
  String? nombreCompletoM;
  double? montoM;

  Future<void> cargarDatosCreditoActivo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? identificacionShared = prefs.getString('identificacion') ?? "";
      String? nombresShared = prefs.getString("nombres") ?? "";
      String? apellidosShared = prefs.getString("apellidos") ?? "";
      setState(() {
        identificacionUsuarioActivo = identificacionShared;
        nombresUsuarioActivo = nombresShared;
        apellidosUsuarioActivo = apellidosShared;
      });
    } catch (error) {
      print("Error al cargar datos desde Firebase: $error");
      setState(() {
        tieneCredito = false;
      });
      return;
    }
    CollectionReference coleccionReference = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(identificacionUsuarioActivo)
        .collection("creditos");
    QuerySnapshot creditosSnapshot = await coleccionReference.limit(1).get();
    if (creditosSnapshot.docs.isNotEmpty) {
      DocumentSnapshot primerCredito = creditosSnapshot.docs.first;
      Map<String, dynamic> datosCredito =
      primerCredito.data() as Map<String, dynamic>;
      String fechaVencimiento = datosCredito['fecha_vencimiento'];
      double saldo = datosCredito['saldo'].toDouble();
      String estado = datosCredito['estado'];
      setState(() {
        vencimientoM = fechaVencimiento;
        estadoM = estado;

      });
      CollectionReference cuotasCollection =
      primerCredito.reference.collection("cuotas");
      QuerySnapshot cuotasSnapshot = await cuotasCollection.get();
      List<Map<String, dynamic>> cuotas = [];
      cuotasSnapshot.docs.forEach((cuota) {
        Map<String, dynamic> datosCuota = cuota.data() as Map<String, dynamic>;
        DateTime fechaPago =
        DateFormat('dd-MM-yyyy').parse(datosCuota['fecha_pago']);
        datosCuota['fecha_pago'] = fechaPago;
        cuotas.add(datosCuota);
      });
      cuotas.sort((a, b) => a['fecha_pago'].compareTo(b['fecha_pago']));
      int cuotasRestantes = 0;
      cuotas.forEach((elemento) {
        if (elemento['estado'] == 'pendiente' || elemento['estado'] == 'atrasado') {
          cuotasRestantes+=1;
        }
      });
    Map<String, dynamic> cuota1 =
    cuotas.firstWhere((element) => element['estado'] == 'pendiente');
    DateTime fechaPrimeracuota = cuota1['fecha_pago'];
    String? fechaPrimeracuotaString =
    DateFormat('dd-MM-yyyy').format(fechaPrimeracuota);
    setState(() {
    fechaPagoM = fechaPrimeracuotaString;
    montoM = double.parse(cuota1['monto_pago']);
    cuotasRestantesM = cuotasRestantes;
    saldoM = cuotasRestantesM! * montoM!;
    });
  }
  }

  @override
  void initState() {
    super.initState();
    cargarDatosCreditoActivo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AzaBankTheme
            .of(context)
            .secondaryBackground,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 0.0),
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
                            color: AzaBankTheme
                                .of(context)
                                .primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Creditos',
                            style: AzaBankTheme
                                .of(context)
                                .headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/usuario.png',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${nombresUsuarioActivo}',
                                        style: TextStyle(
                                          color:
                                          AzaBankTheme
                                              .of(context)
                                              .primary,
                                          fontFamily: 'Poppins',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${apellidosUsuarioActivo}',
                                        style: TextStyle(
                                          color:
                                          AzaBankTheme
                                              .of(context)
                                              .primary,
                                          fontFamily: 'Poppins',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        'Cuota : \$${montoM}',
                                        style: TextStyle(
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText, // Color negro
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            30.0, 20.0, 30.0, 20.0),
                        child: Container(
                          width: 332.0,
                          height: 230.0,
                          decoration: BoxDecoration(
                            color: Color(0x12000000),
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: AzaBankTheme
                                  .of(context)
                                  .primaryText,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 0.0, 20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fecha Pago:    ${fechaPagoM} ',
                                      style: AzaBankTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color: AzaBankTheme
                                            .of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Vencimiento:    ${vencimientoM}   ',
                                      style: AzaBankTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color: AzaBankTheme
                                            .of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Cuotas Restantes:    ${cuotasRestantesM} ',
                                      style: AzaBankTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color: AzaBankTheme
                                            .of(context)
                                            .primaryText,
                                      ),
                                    ),

                                    SizedBox(height: 10.0),
                                    Text(
                                      'Estado:    ${estadoM}  ',
                                      style: AzaBankTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color: AzaBankTheme
                                            .of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Saldo:   ${saldoM}  ',
                                      style: AzaBankTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color: AzaBankTheme
                                            .of(context)
                                            .primaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
