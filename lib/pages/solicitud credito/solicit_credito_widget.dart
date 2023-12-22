import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '../creditos/sincreditos_widget.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'solict_credito_modelo.dart';
export 'solict_credito_modelo.dart';

class SolicitCreditoWidget extends StatefulWidget {
  const SolicitCreditoWidget({Key? key}) : super(key: key);

  @override
  _SolicitCreditoWidgetState createState() => _SolicitCreditoWidgetState();
}

class _SolicitCreditoWidgetState extends State<SolicitCreditoWidget> {
  late SolicitCreditoModel _model;
  double? sumaMontosInversion =0.0;
  String? identificacionUsuarioActivo ="";
  double montoM = 0.0;
  int? numCuotasM= 0;
  double? promGastosM= 0.0;
  double? promIngresosM= 0.0;
  String selectedStatus = '0';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  int get pageViewCurrentIndex => _model.pageViewController.hasClients &&
          _model.pageViewController.page != null
      ? _model.pageViewController.page!.round()
      : 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SolicitCreditoModel());
    cargarValorMaximoCredito();
    numCuotasM = _model.cuotas;
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _model.textControllerResultado ??= TextEditingController();
    _model.textControllerCuotas ??= TextEditingController();
    _model.pageViewController;

    _model.textController1?.addListener(() {
      setState(() {
        _model.camposLlenos = _model.textController1!.text.isNotEmpty;
        _model.mostrarError = _model.focusNode.hasFocus && !_model.camposLlenos;
        _model.montoCredito =
            double.tryParse(_model.textController1!.text) ?? 0.0;
        _model.calcularResultados();
      });
    });

    _model.textControllerCuotas?.addListener(() {
      setState(() {
        _model.cuotas = int.tryParse(_model.textControllerCuotas!.text) ?? 3;
        _model.calcularResultados();
      });
    });
  }

  void enviarSolicitudCredito(
      identificacion, saldo, monto, numCuotas, promGastos, promIngresos) {
    try {
      DateTime fechaHoy = DateTime.now();
      String fechaFormateada = DateFormat('dd-MM-yyyy').format(fechaHoy);
      var solicitudCredito = {
        "identificacion": identificacion,
        "estado": true,
        "fecha": fechaFormateada,
        "monto": monto,
        "num_cuotas": numCuotas,
        "prom_gastos": promGastos,
        "prom_ingresos": promIngresos,
        "saldo": saldo,
      };
      FirebaseFirestore.instance
          .collection("solicitudCredito")
          .doc()
          .set(solicitudCredito);
      print('Solicitud de crédito enviada exitosamente.');
    } catch (e) {
      print('Error al enviar la solicitud de crédito: $e');
    }
  }


  void _mostrarAlerta(BuildContext context) {
      showDialog(
        builder: (context) => AlertDialog(
          title: Text("Enviar"),
          content: Text("Desea enviar los datos"),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                print("NO");
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Aceptar"),
              onPressed: () async {
                enviarSolicitudCredito(
                    identificacionUsuarioActivo,
                    sumaMontosInversion,
                    montoM,
                    numCuotasM,
                    promGastosM,
                    promIngresosM);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Solicitud de crédito enviada exitosamente',
                      style: AzaBankTheme.of(context).titleSmall.override(
                        fontFamily: 'Poppins',
                        color: AzaBankTheme.of(context).primary3,
                      ),
                    ),
                    duration: Duration(milliseconds: 3000),
                    backgroundColor: AzaBankTheme.of(context).green,
                  ),
                );

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

                // Muestra el SnackBar después de aceptar

              },
            ),
          ],
        ),
        barrierDismissible: false,
        context: context,
      );
    }

    void cargarValorMaximoCredito() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? identificacionShared = prefs.getString('identificacion') ?? "";
      setState(() {
        identificacionUsuarioActivo = identificacionShared;
      });
    } catch (error) {
      print("Error al cargar datos desde Firebase: $error");
      return;
    }
    try {
      var collectionReference = FirebaseFirestore.instance
          .collection("usuarios")
          .doc(identificacionUsuarioActivo)
          .collection("inversiones");
      var querySnap = await collectionReference.get();
      double montoSuma = 0.0;
      querySnap.docs.forEach((doc) {
        // Verificar si el documento tiene el campo "monto"
        if (doc.data().containsKey("monto")) {
          montoSuma += double.parse(doc["monto"].toString());
          print("Entra a verificar el monto:");
        }
      });
      montoSuma *= 2;
      setState(() {
        sumaMontosInversion = montoSuma;
      });
    } catch (e) {
      print("Error al obtener la suma de los valores: $e");
    }
  }

  @override
  void dispose() {
    _model.textController1?.dispose();
    _model.textController2?.dispose();
    _model.textController3?.dispose();
    _model.textControllerResultado?.dispose();
    _model.textControllerCuotas?.dispose();
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SolicitCreditoModel(),
      child: GestureDetector(
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
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 20.0, 10.0, 20.0),
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
                                  child: NavBarPage(initialPage: 'Creditos'),
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
                              'Solicitud de Credito',
                              style: AzaBankTheme.of(context).headlineMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 1.0,
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _model.pageViewController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 20.0, 10.0, 5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Datos de Credito',
                                              style: AzaBankTheme.of(context)
                                                  .headlineMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 10.0, 20.0, 10.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 30.0,
                                              color: Color(0x123629B7),
                                              offset: Offset(0.0, 4.0),
                                              spreadRadius: 30.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 0.0, 0.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Limite de crédito:  \$',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF0C0F10),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 19.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    '$sumaMontosInversion',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: AzaBankTheme.of(
                                                              context)
                                                          .primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 22.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 5.0, 10.0, 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 10.0),
                                            child: Container(
                                              width: 332.0,
                                              height: 55.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x12000000),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color:
                                                      AzaBankTheme.of(context)
                                                          .orange,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 20.0, 0.0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController1,
                                                  obscureText: false,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _model.calcularResultados();
                                                      montoM = double.parse(value);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Monto Crédito',
                                                    errorText: _model.mostrarError
                                                        ? 'Llenar campo Monto Crédito'
                                                        : null,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: AzaBankTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: AzaBankTheme.of(
                                                                context)
                                                            .primaryText,
                                                      ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: _model
                                                      .textController1Validator!
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 15.0),
                                            child: Container(
                                              width: 332.0,
                                              height: 55.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x12000000),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color:
                                                      AzaBankTheme.of(context)
                                                          .orange,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Cuotas',
                                                      style: TextStyle(
                                                        color: AzaBankTheme.of(
                                                                context)
                                                            .primaryText,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    SizedBox(width: 20.0),
                                                    // Espacio entre el texto y la casilla
                                                    DropdownButton<int>(
                                                      value: _model.cuotas,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _model.cuotas =
                                                              value ?? 3;
                                                          _model
                                                              .calcularResultados();
                                                          print("Cambia valor cuotas: " +
                                                              value.toString());
                                                          numCuotasM = value;
                                                        });
                                                      },
                                                      items: [3, 6]
                                                          .map((int cuotas) {
                                                        return DropdownMenuItem<
                                                            int>(
                                                          value: cuotas,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Text(
                                                              cuotas == 3
                                                                  ? '3'
                                                                  : cuotas
                                                                      .toString(),
                                                              style: TextStyle(
                                                                color: AzaBankTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 10.0),
                                            child: Container(
                                              width: 332.0,
                                              height: 55.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x12000000),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color:
                                                      AzaBankTheme.of(context)
                                                          .orange,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 20.0, 0.0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController2,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Promedio de Ingresos',
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: AzaBankTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: AzaBankTheme.of(
                                                                context)
                                                            .primaryText,
                                                      ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: _model
                                                      .textController2Validator
                                                      .asValidator(context),
                                                  onChanged: ((value) {
                                                    promIngresosM =
                                                        double.parse(value);
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 10.0),
                                            child: Container(
                                              width: 332.0,
                                              height: 55.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x12000000),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color:
                                                      AzaBankTheme.of(context)
                                                          .orange,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 20.0, 0.0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController3,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Promedio de Gastos',
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: AzaBankTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: AzaBankTheme.of(
                                                                context)
                                                            .primaryText,
                                                      ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: _model
                                                      .textController3Validator
                                                      .asValidator(context),
                                                  onChanged: ((value) {
                                                    promGastosM =
                                                        double.parse(value);
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 10.0, 20.0, 10.0),
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
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Text(
                                                      'Cuotas Mensuales',
                                                      style: AzaBankTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF0C0F10),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Cuota Mensual: \$${_model.resultado.toStringAsFixed(2)}',
                                                      style:
                                                          AzaBankTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: AzaBankTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              // Puedes ajustar según tus preferencias
                                              children: [
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    if (_todosLosCamposEstanLlenos() &&
                                                        sumaMontosInversion != null &&
                                                        montoM != null &&
                                                        sumaMontosInversion! > montoM!) {
                                                      // Mostrar la alerta de confirmación
                                                      _mostrarAlerta(context);
                                                    } else {
                                                      // Mostrar mensaje de error
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Todos los campos son obligatorios o el monto es superior al permitido',
                                                            style: AzaBankTheme.of(context).titleSmall,
                                                          ),
                                                          duration: Duration(milliseconds: 4000),
                                                          backgroundColor: AzaBankTheme.of(context).error,
                                                        ),
                                                      );
                                                    }
                                                    // Limpiar campos
                                                    _model.textController1?.clear();
                                                    _model.textController2?.clear();
                                                    _model.textController3?.clear();
                                                    },

                                                  text: 'Enviar',
                                                  options: FFButtonOptions(
                                                    width: 130.0,
                                                    height: 55.0,
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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

                                                FFButtonWidget(
                                                  onPressed: () => {Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) => SinCreditosWidget()),
                                                    ),
                                                  },
                                                  text: 'Volver',
                                                  options: FFButtonOptions(
                                                    width: 130.0,
                                                    height: 55.0,
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                                    borderRadius:
                                                        BorderRadius.circular(12.0),
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
      ),
    );
  }
  bool _todosLosCamposEstanLlenos() {
    return _model.textController1!.text.isNotEmpty &&
        _model.textController2!.text.isNotEmpty &&
        _model.textController3!.text.isNotEmpty;
  }
}
