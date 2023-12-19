import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '/main.dart';
import '/pages/accountandcard/accountandcard_widget.dart';
import '/pages/notification/notification_widget.dart';
import '/pages/withdraw_funds/withdraw_funds_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/pages/transfer_funds/transferencia_widget.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  String? nombresUsuarioActivo;
  String? apellidosUsuarioActivo;
  String? email;
  String? cargoUsuarioActivo;
  String? empresaUsuarioActivo;
  String? identificacionUsuarioActivo;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  cargarDatosUsuario() async {
    final preferences = await SharedPreferences.getInstance();


    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        email = user.email.toString();
        CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');
        QuerySnapshot querySnapshot = await usuarios.where('correo', isEqualTo: email).get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          Map<String, dynamic> userData = document.data() as Map<String,
              dynamic>;
          setState(() {

            nombresUsuarioActivo = userData['nombres'];
            apellidosUsuarioActivo = userData['apellidos'];
            cargoUsuarioActivo = userData['cargo'];
            empresaUsuarioActivo = userData['empresa'];
          });

          preferences.setString('nombres', userData['nombres']);
          preferences.setString('apellidos', userData['apellidos']);
          preferences.setString('correo', userData['correo']);
          preferences.setString('empresa', userData['empresa']);
          preferences.setString('cargo', userData['cargo']);
          preferences.setString('identificacion', userData['identificacion']);

        }
      }
    });
    identificacionUsuarioActivo = preferences.getString('identificacion') ?? "";
    print("La identificacion que llega a inicio es: " +identificacionUsuarioActivo!);
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AzaBankTheme.of(context).primary,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: AzaBankTheme.of(context).primary,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 15.0, 5.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
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
                                      reverseDuration:
                                          Duration(milliseconds: 300),
                                      child: NavBarPage(
                                          initialPage: 'Settingspage'),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 35.0,
                                  height: 35.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/usuario.png',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Hola, $nombresUsuarioActivo',
                                  style: AzaBankTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color:
                                            AzaBankTheme.of(context).primary3,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: NotificationWidget(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.notification_important,
                              color: AzaBankTheme.of(context).primary3,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: AzaBankTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 20.0),
                        child: InkWell(
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
                                child: AccountandcardWidget(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 221.0,
                            decoration: BoxDecoration(
                              color:
                                  AzaBankTheme.of(context).secondaryBackground,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/card-bg.png',
                                ).image,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 0.0, 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        '$nombresUsuarioActivo',
                                        style: AzaBankTheme.of(context)
                                            .displaySmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '$apellidosUsuarioActivo',
                                          style: AzaBankTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '$empresaUsuarioActivo',
                                          style: AzaBankTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '$cargoUsuarioActivo',
                                          style: AzaBankTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Código para ahorros
                            /*InkWell(
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
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: AccountandcardWidget(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30.0,
                                      color: Color(0x123629B7),
                                      offset: Offset(0.0, -5.0),
                                      spreadRadius: 30.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/account-icon.svg',
                                      width: 28.0,
                                      height: 28.0,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      'Ahorros',
                                      textAlign: TextAlign.center,
                                      style: AzaBankTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AzaBankTheme.of(context)
                                                .secondaryText,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
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
                                    reverseDuration:
                                    Duration(milliseconds: 300),
                                    child: WithdrawFundsWidget(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30.0,
                                      color: Color(0x123629B7),
                                      offset: Offset(0.0, -5.0),
                                      spreadRadius: 30.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/wedraw-icon.svg',
                                      width: 28.0,
                                      height: 28.0,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      'Inversión',
                                      textAlign: TextAlign.center,
                                      style: AzaBankTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: AzaBankTheme.of(context)
                                            .secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: NavBarPage(
                                        initialPage: 'Creditos'),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30.0,
                                      color: Color(0x123629B7),
                                      offset: Offset(0.0, -5.0),
                                      spreadRadius: 30.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/credit_card.svg',
                                      width: 28.0,
                                      height: 28.0,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      'Crédito',
                                      textAlign: TextAlign.center,
                                      style: AzaBankTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AzaBankTheme.of(context)
                                                .secondaryText,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TransferenciaWidget())
                                );
                              },
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30.0,
                                      color: Color(0x123629B7),
                                      offset: Offset(0.0, -5.0),
                                      spreadRadius: 30.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/tranfer-icon.svg',
                                      width: 28.0,
                                      height: 28.0,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      'Transferencia',
                                      textAlign: TextAlign.center,
                                      style: AzaBankTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: AzaBankTheme.of(context)
                                            .secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [




                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
