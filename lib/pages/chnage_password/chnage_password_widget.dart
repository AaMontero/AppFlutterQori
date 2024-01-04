import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'chnage_password_model.dart';
export 'chnage_password_model.dart';

class ChnagePasswordWidget extends StatefulWidget {
  const ChnagePasswordWidget({Key? key}) : super(key: key);

  @override
  _ChnagePasswordWidgetState createState() => _ChnagePasswordWidgetState();
}

class _ChnagePasswordWidgetState extends State<ChnagePasswordWidget> {
  late ChnagePasswordModel _model;
  String? email;
  String? passViejo;
  String? nuevaContrasenia;
  String? confirmarNuevaContrasenia;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  void cargarUsuario(){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        email = user.email.toString();
      }
    });
  }
  Future<String> cambiarPassWord(String nuevaContrasenia, String confNuevaContrasenia) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (nuevaContrasenia == confNuevaContrasenia) {
      if (isStrongPassword(nuevaContrasenia)) {
        try {
          await user?.updatePassword(nuevaContrasenia);
          return "cambio exitoso";
        } catch (error) {
          return "Error al cambiar la contraseña: $error";
        }
      } else {
        return "La contraseña debe tener al menos una legra mayúscula, minúscula, un número, y un caracter. especial ";
      }
    } else {
      return "Las contraseñas no son iguales";
    }
  }

  bool isStrongPassword(String contrasenia) {
    // Validar que la contraseña tenga al menos una mayúscula, una minúscula,
    // un carácter especial (.,_&$@) y un número.
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final digitRegex = RegExp(r'[0-9]');
    final specialCharRegex = RegExp(r'[.,_&$@]');

    return upperCaseRegex.hasMatch(contrasenia) &&
        lowerCaseRegex.hasMatch(contrasenia) &&
        digitRegex.hasMatch(contrasenia) &&
        specialCharRegex.hasMatch(contrasenia);
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChnagePasswordModel());
     cargarUsuario();
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _model.textController1?.text = '';
          _model.textController2?.text = '';
          _model.textController3?.text = '';
        }));
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: AzaBankTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                        child: InkWell(
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
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Cambiar Contraseña',
                          style: AzaBankTheme.of(context).headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: AzaBankTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30.0,
                        color: Color(0x123629B7),
                        offset: Offset(0.0, -5.0),
                        spreadRadius: 30.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Escriba su nueva contraseña',
                                style: AzaBankTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AzaBankTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 1.0, 0.0, 10.0),
                              child: Container(
                                width: 310.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: AzaBankTheme.of(context).orange,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 20.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController2,
                                    obscureText: !_model.passwordVisibility2,
                                    decoration: InputDecoration(
                                      hintText: 'Nueva Contraseña',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model.passwordVisibility2 =
                                              !_model.passwordVisibility2,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordVisibility2
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color:
                                              AzaBankTheme.of(context).orange,
                                          size: 22.0,
                                        ),
                                      ),
                                    ),
                                    style: AzaBankTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0C0F10),
                                        ),
                                    keyboardType: TextInputType.phone,
                                    validator: _model.textController2Validator
                                        .asValidator(context),
                                    onChanged:(value) => nuevaContrasenia = value,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Repita su nueva contraseña ',
                                style: AzaBankTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AzaBankTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 1.0, 0.0, 10.0),
                              child: Container(
                                width: 310.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: AzaBankTheme.of(context).orange,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 20.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController3,
                                    obscureText: !_model.passwordVisibility3,
                                    decoration: InputDecoration(
                                      hintText: 'Nueva Contraseña',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model.passwordVisibility3 =
                                              !_model.passwordVisibility3,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordVisibility3
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color:
                                              AzaBankTheme.of(context).orange,
                                          size: 22.0,
                                        ),
                                      ),
                                    ),
                                    style: AzaBankTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0C0F10),
                                        ),
                                    keyboardType: TextInputType.phone,
                                    validator: _model.textController3Validator
                                        .asValidator(context),
                                    onChanged: (value) => confirmarNuevaContrasenia = value,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    String cambio = await cambiarPassWord(nuevaContrasenia!, confirmarNuevaContrasenia!);
                                    if(cambio == "cambio exitoso"){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Contraseña modificada exitosamente',
                                            style: TextStyle(
                                              color: AzaBankTheme.of(context)
                                                  .primary3,
                                            ),
                                          ),
                                          duration: Duration(milliseconds: 4000),
                                          backgroundColor:
                                          AzaBankTheme.of(context).green,
                                          action: SnackBarAction(
                                            label: 'Okay ',
                                            textColor:
                                            AzaBankTheme.of(context).primary3,
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.scale,
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  duration:
                                                  Duration(milliseconds: 300),
                                                  reverseDuration:
                                                  Duration(milliseconds: 300),
                                                  child: NavBarPage(
                                                      initialPage:
                                                      'Settingspage'),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                      _model.textController2?.clear();
                                      _model.textController3?.clear();
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            cambio,
                                            style: TextStyle(
                                              color: AzaBankTheme.of(context)
                                                  .primary3,
                                            ),
                                          ),
                                          duration: Duration(milliseconds: 4000),
                                          backgroundColor:
                                          AzaBankTheme.of(context).orange,
                                          action: SnackBarAction(
                                            label: 'Okay ',
                                            textColor:
                                            AzaBankTheme.of(context).primary3,
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.scale,
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  duration:
                                                  Duration(milliseconds: 300),
                                                  reverseDuration:
                                                  Duration(milliseconds: 300),
                                                  child: NavBarPage(
                                                      initialPage:
                                                      'Settingspage'),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }



                                  },
                                  text: 'Cambiar Contraseña',
                                  options: FFButtonOptions(
                                    width: 130.0,
                                    height: 55.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: AzaBankTheme.of(context).primary,
                                    textStyle: AzaBankTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
