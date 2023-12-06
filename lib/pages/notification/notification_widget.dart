import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import 'package:flutter/material.dart';
import 'notification_model.dart';
export 'notification_model.dart';

class NotificacionObjeto {
  String concepto;
  String fecha;
  double monto;

  // Constructor
  NotificacionObjeto({
    required this.concepto,
    required this.fecha,
    required this.monto,
  });
  String toString(){
    return "Objeto Notificación" + this.concepto + this.fecha + this.monto.toString();
  }
}
class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationModel _model;
  List<NotificacionObjeto> listaNotificaciones = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void cargarDatosDesdeFireBase() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        var email = user.email.toString();
        CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

        List<NotificacionObjeto> combinedList = []; // Lista que combina los resultados

        usuarios.doc(email).collection("ahorros").get().then((QuerySnapshot querySnapshot) {
          // Agregar elementos a la lista combinada
          combinedList.addAll(querySnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String concepto = 'Ahorros: ' + data['concepto'];
            double monto = data['monto'];
            String fecha = data['fecha'].toString();
            return NotificacionObjeto(concepto: concepto, fecha: fecha, monto: monto);
          }));
        }
        ).catchError((error) {
          print("Error al obtener datos de Firebase (ahorros): $error");
        });

        usuarios.doc(email).collection("inversiones").get().then((QuerySnapshot querySnapshot) {
          // Agregar elementos a la lista combinada
          combinedList.addAll(querySnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String concepto = 'Inversion: ' + data['concepto'];
            double monto = data['monto'];
            String fecha = data['fecha'].toString();
            return NotificacionObjeto(concepto: concepto, fecha: fecha, monto: monto);
          }
          )
          );

          // Actualizar el estado con la lista combinada después de ambas consultas
          setState(() {
            listaNotificaciones.clear();
            listaNotificaciones.addAll(combinedList);
            listaNotificaciones.sort((a, b) => DateTime.parse(b.fecha).compareTo(DateTime.parse(a.fecha)));
          });
        }).catchError((error) {
          print("Error al obtener datos de Firebase (inversiones): $error");
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cargarDatosDesdeFireBase();
    _model = createModel(context, () => NotificationModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Widget widgetNoticacion(concepto, monto, fecha){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3.0,
              color: Color(0x28000000),
              offset: Offset(0.0, 1.0),
            )
          ],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color(0xFFDBE2E7),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/notificacion.png',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    4.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$concepto',
                            style: AzaBankTheme.of(context)
                                .bodySmall
                                .override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '$fecha',
                            textAlign: TextAlign.end,
                            style: AzaBankTheme.of(context)
                                .bodySmall
                                .override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 10.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: Text(
                              '\$$monto',
                              style: AzaBankTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
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
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AzaBankTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Color(0x32000000),
                      offset: Offset(0.0, 1.0),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
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
                        'Notificaciones ',
                        style: AzaBankTheme.of(context).headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Transacciones Registradas',
                      style: AzaBankTheme.of(context).bodySmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF8B97A2),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listaNotificaciones.length,
                itemBuilder: (BuildContext context, int index) {
                  return widgetNoticacion(
                    listaNotificaciones[index].concepto,
                    listaNotificaciones[index].monto,
                    listaNotificaciones[index].fecha,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
