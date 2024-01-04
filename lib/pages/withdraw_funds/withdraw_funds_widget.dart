import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import 'package:flutter/material.dart';
import '../../theme/aza_bank_widgets.dart';
import 'withdraw_funds_model.dart';
export 'withdraw_funds_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
class InversionAporte {
  String concepto;
  String fecha;
  double monto;
  InversionAporte({
    required this.concepto,
    required this.fecha,
    required this.monto,
  });
  String toString() {
    return "Objeto Ahorro" + this.concepto + this.fecha + this.monto.toString();
  }
  InversionAporteDTO toDTO() {
    DateTime parsedFecha = DateFormat('dd-MM-yyyy').parse(this.fecha);
    return InversionAporteDTO(
      concepto: this.concepto,
      fecha: parsedFecha,
      monto: this.monto,
    );
  }

}

class InversionAporteDTO{
  String concepto;
  DateTime fecha;
  double monto;
  InversionAporteDTO({
    required this.concepto,
    required this.fecha,
    required this.monto,
});

  InversionAporte fromDTO() {
  return InversionAporte(
  concepto: this.concepto,
  fecha: DateFormat('dd-MM-yyyy').format(this.fecha),
  monto: this.monto,
  );
}
}
class WithdrawFundsWidget extends StatefulWidget {
  const WithdrawFundsWidget({Key? key}) : super(key: key);

  @override
  _WithdrawFundsWidgetState createState() => _WithdrawFundsWidgetState();
}

class _WithdrawFundsWidgetState extends State<WithdrawFundsWidget> {
  late WithdrawFundsModel _model;
  File? file;
  String? url;
  String? email;
  String? identificacion;
  double? saldoTotal = 0;
  List<InversionAporte> listaAportes = [];
  List<InversionAporteDTO> listaAportesDto = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late CollectionReference coleccionUsuarios;
  late CollectionReference coleccionNotificaciones;


  int get pageViewCurrentIndex => _model.pageViewController != null &&
          _model.pageViewController!.hasClients &&
          _model.pageViewController!.page != null
      ? _model.pageViewController!.page!.round()
      : 0;

  @override
  void initState() {
    super.initState();
    cargarDatosDesdeFireBase();
    _model = createModel(context, () => WithdrawFundsModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Widget widgetTransaccion(
      String fechaTransaccion, double montoTransaccion, String concepto) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
            child: Container(
              width: double.infinity,
              height: 110.0,
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Fecha: ',
                                style: AzaBankTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '$fechaTransaccion',
                                style: AzaBankTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Monto Transacción: ',
                                style: AzaBankTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '${montoTransaccion < 0 ? '-' : ''}\$${montoTransaccion.abs()}',
                                style: AzaBankTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AzaBankTheme.of(context).primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Concepto',
                                style: AzaBankTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '$concepto',
                                style: AzaBankTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AzaBankTheme.of(context).primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  getImageGaleria() async {

    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    DateTime nowDate = DateTime.now();
    String now = nowDate.toString();
    String fechaFormateada = DateFormat('dd-MM-yyyy').format(nowDate);
    var path = '$identificacion/inversiones/$now.jpg';
    if (image != null) {

      file = File(image.path);
      var refStorage = firebase_storage.FirebaseStorage.instance.ref(path);
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
      print("La url es la siguiente: "+ url.toString());
      Map<String, dynamic> nuevaNotificacion = {
        'concepto': 'Inversion',
        'estado': true,
        'fecha' : fechaFormateada,
        'identificacion': identificacion,
        'urlImagen': url

      };
      coleccionNotificaciones.add(nuevaNotificacion)
          .then((DocumentReference doc) =>
      print('Elemento agregado con id: ${doc.id}'));
    } else {
      print("La imagen es nula");
    }
    setState(() {});
  }

  void cargarDatosDesdeFireBase() {
    coleccionNotificaciones = FirebaseFirestore.instance.collection('notificaciones');
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        email = user.email.toString();
        coleccionUsuarios = FirebaseFirestore.instance.collection('usuarios');
        QuerySnapshot querySnapshot = await coleccionUsuarios.where('correo', isEqualTo: email).get();
        if(querySnapshot.docs.isNotEmpty){
          DocumentSnapshot document = querySnapshot.docs.first;
          DocumentReference doc= document.reference;
          Map<String, dynamic> userData = document.data() as Map<String,
              dynamic>;
          this.identificacion = userData["identificacion"];
          doc.collection("inversiones")
              .get()
              .then((QuerySnapshot querySnapshot) {
            setState(() {
              listaAportes.clear();
              listaAportes
                  .addAll(querySnapshot.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                String concepto = data['concepto'];
                double monto = double.parse(data['monto'].toString());
                String fecha = data['fecha'].toString();
                return InversionAporte(
                    concepto: concepto, fecha: fecha, monto: monto);
              }
              )
              );
              listaAportes.sort((a, b) => b.fecha.compareTo(a.fecha));
              saldoTotal = listaAportes
                  .map((aporte) => aporte.monto)
                  .fold(0.0, (a, b) => a! + b);
              print("Saldo total: " + saldoTotal.toString());
            }
            );
            setState(() {
              listaAportesDto.clear();
              print("Esta entrando al segundo state");
              listaAportesDto = listaAportes.map((aporte) => aporte.toDTO()).toList();
              listaAportesDto.sort((a, b) => b.fecha.compareTo(a.fecha));
              listaAportes.clear();
              listaAportesDto.forEach((element) {
                listaAportes.add(element.fromDTO());
              });
            });

          }).catchError((error) {
            print("Error al obtener datos de Firebase: $error");
          });
        }else{
          print('No se pudieron cargar los datos');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AzaBankTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Inversiones',
                        style: AzaBankTheme.of(context).headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 500.0,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _model.pageViewController ??=
                          PageController(initialPage: 0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {

                                              },
                                              text: 'Saldo/Trans',
                                              options: FFButtonOptions(
                                                width: 160.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                color: AzaBankTheme.of(context)
                                                    .primary,
                                                textStyle:
                                                AzaBankTheme.of(context)
                                                    .bodyMedium
                                                    .override(
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
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () async {
                                                await getImageGaleria();

                                                if (file != null) {
                                                  Image.file(file!);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Foto Subida Correctamente',
                                                        style:
                                                        AzaBankTheme.of(
                                                            context)
                                                            .titleSmall
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: AzaBankTheme.of(
                                                              context)
                                                              .primary3,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 3000),
                                                      backgroundColor:
                                                      AzaBankTheme.of(
                                                          context)
                                                          .green,
                                                    ),
                                                  );
                                                } else {
                                                  print(
                                                      'No se ha subido ninguna foto.');
                                                }
                                              },
                                              text: 'Subir',
                                              iconData: Icons.camera_alt,
                                              options: FFButtonOptions(
                                                width: 160.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                color: Color(0xFFF2F1F9),
                                                textStyle:
                                                AzaBankTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
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
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 150.0,
                                              height: 150.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                'assets/images/Illustration_3.png',
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  style:
                                                  AzaBankTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Poppins',
                                                    fontSize: 25.0,
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
                                                          30.0 // Color negro
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
                                  Container(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: listaAportes.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return widgetTransaccion(
                                              listaAportes[index].fecha,
                                              listaAportes[index].monto,
                                              listaAportes[index].concepto,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              );
                            }),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
