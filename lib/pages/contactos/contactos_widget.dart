import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
//import '../../theme/aza_bank_widgets.dart';
import 'contactos_model.dart';
export 'contactos_model.dart';

class ContactosWidget extends StatefulWidget {
  const ContactosWidget ({Key? key}) : super(key: key);

  @override
  _ContactosWidgetState createState() => _ContactosWidgetState();
}

class _ContactosWidgetState extends State<ContactosWidget> {
 late ContactosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContactosModel());
    _model.dispose();
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
                                child: NavBarPage(initialPage: 'Settingspage'),
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
                            'Contactos',
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
                            0.0, 30.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Text(
                                        'Contactanos',
                                        style: TextStyle(
                                          color: AzaBankTheme
                                              .of(context)
                                              .primary,
                                          fontFamily: 'Poppins',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),

                      /*Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
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
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                    SvgPicture.asset(
                                      'assets/images/facebook.svg',
                                      width: 100.0,
                                      height: 60.0,
                                      fit: BoxFit.cover,
                                    ),
                                    ],

                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                      child: Text(
                                        'Facebook',
                                        style: AzaBankTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0C0F10),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // Agrega más texto si es necesario
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
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
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                  child: SvgPicture.asset(
                                    'assets/images/instagram.svg',
                                    width: 100.0,
                                    height: 60.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                      child: Text(
                                        'Instagram',
                                        style: AzaBankTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0C0F10),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // Agrega más texto si es necesario
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),*/


                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
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
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                  child: SvgPicture.asset(
                                    'assets/images/whatsapp.svg',
                                    width: 100.0,
                                    height: 60.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                      child: Text(
                                        '',
                                        style: AzaBankTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0C0F10),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // Agrega más texto si es necesario
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
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
                              children: [

                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 5.0),
                                      child: Text(
                                        'InFormacion de la empresa\nDireccion de la empreza\nUbicacion',
                                        style: AzaBankTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0C0F10),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // Agrega más texto si es necesario
                                  ],
                                ),
                              ],
                            ),
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