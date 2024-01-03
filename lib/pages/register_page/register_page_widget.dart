import 'package:cloud_firestore/cloud_firestore.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '/pages/login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'register_page_model.dart';
export 'register_page_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageWidget extends StatefulWidget {
  const RegisterPageWidget({Key? key}) : super(key: key);

  @override
  _RegisterPageWidgetState createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  late RegisterPageModel _model;
  var db = FirebaseFirestore.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String? correoReg;
  String? nombresReg;
  String? apellidosReg;
  String? numCelularReg;
  String? passwordReg;
  String? cargoReg;
  String? empresaReg;
  String? numCedulaReg;
  DateTime? selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
  }
  Future<bool> isCorreoRepetido(String correo) async {
    try {
      CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');
      QuerySnapshot querySnapshot = await usuarios.where('correo', isEqualTo: correo).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print('Error al verificar si el correo está repetido: $error');
      return false;
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+');
    return emailRegex.hasMatch(email);
  }
  bool isStrongPassword(String password) {
    // Validar que la contraseña tenga al menos una mayúscula, una minúscula,
    // un carácter especial (.,_&$@) y un número.
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final digitRegex = RegExp(r'[0-9]');
    final specialCharRegex = RegExp(r'[.,_&$@]');

    return upperCaseRegex.hasMatch(password) &&
        lowerCaseRegex.hasMatch(password) &&
        digitRegex.hasMatch(password) &&
        specialCharRegex.hasMatch(password);
  }
    registrar(correo, contrasenia, nombres, apellidos, numIdentificacion,
        numCelular, empresa, cargo, fechaNacimiento) async {
      print(numIdentificacion);
      // Validaciones
      if (correo.isEmpty || !isValidEmail(correo)) {
        showValidationError('Correo electrónico no válido');
        return;
      }
      if (!correo.contains('@')) {
        showValidationError('El correo electrónico debe contener el carácter "@"');
        return;
      }

      if (contrasenia.length < 7) {
        showValidationError('La contraseña es demasiado corta. Debe tener al menos 7 caracteres.');
        return;
      }
      if (!isStrongPassword(contrasenia)) {
        showValidationError('La contraseña debe tener al menos una mayúscula, una minúscula, un carácter especial (.,_&@) y un número.');
        return;
      }

      if (numIdentificacion.length < 10) {
        showValidationError('Cedula debe tener 10 dijitos');
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: correo,
          password: contrasenia,
        );
        final usuario = <String, dynamic>{
          "correo": correo,
          "nombres": nombres,
          "apellidos": apellidos,
          "identificacion": numIdentificacion,
          "numero_celular": numCelular,
          "empresa": empresa,
          "cargo": cargo,
          "fecha_nacimiento": fechaNacimiento
        };
        db.collection("usuarios").doc(numIdentificacion).set(usuario).then((_) =>
            print('Documento agregado con éxito para el correo: $correo'));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'Contraseña debil') {
          print('La contraseña proporcionada es demasiado débil.');
        } else if (e.code == 'correo ya en uso') {
          print('La cuenta ya existe para ese correo electrónico.');
        } else {
          print('Error en FirebaseAuth: $e');
        }
      } catch (e) {
        print('Error al registrar: $e');
      }


    }


    @override
    void initState() {
      super.initState();
      _model = createModel(context, () => RegisterPageModel());
      _model.textController1 ??= TextEditingController();
      _model.textController2 ??= TextEditingController();
      _model.textController3 ??= TextEditingController();
      _model.textController4 ??= TextEditingController();
      _model.textController5 ??= TextEditingController();
      _model.textController6 ??= TextEditingController();
      _model.textController7 ??= TextEditingController();
      _model.textController8 ??= TextEditingController();
    }

    @override
    void dispose() {
      _model.dispose();
      _model.textController1?.dispose();
      _model.textController2?.dispose();
      _model.textController3?.dispose();
      _model.textController4?.dispose();
      _model.textController5?.dispose();
      _model.textController6?.dispose();
      _model.textController7?.dispose();
      _model.textController8?.dispose();
      _unfocusNode.dispose();


      super.dispose();
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
                    color: AzaBankTheme
                        .of(context)
                        .primary,
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
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.scale,
                                  alignment: Alignment.bottomCenter,
                                  duration: Duration(milliseconds: 300),
                                  reverseDuration: Duration(milliseconds: 300),
                                  child: LoginPageWidget(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Registro',
                            style:
                            AzaBankTheme
                                .of(context)
                                .headlineMedium
                                .override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: AzaBankTheme
                        .of(context)
                        .secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 20.0),
                    child: SingleChildScrollView(
                      primary: false,

                      child: Column(
                        mainAxisSize: MainAxisSize.max,

                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Crear nueva cuenta',
                                  style: AzaBankTheme
                                      .of(context)
                                      .displaySmall
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme
                                        .of(context)
                                        .primary1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Illustration_2.png',
                                  width: 213.0,
                                  height: 165.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 40.0, 0.0, 10.0),
                            child:
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(
                                          5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        validator: (value){
                                          if(value!.isEmpty || !isValidEmail(value)){
                                            return 'Correo no valido';
                                          }
                                          return null;
                                        },
                                        controller: _model.textController1,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Correo Electrónico',
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
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme.of(context).primaryText,
                                        ),

                                        onChanged: (value) {
                                          correoReg = value;
                                        },
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        validator: (value){
                                          if (value!.isEmpty || value.length < 7) {
                                            return 'La contraseña es demasiado corta. Debe tener al menos 7 caracteres';
                                          }
                                          return null;
                                        },
                                        controller: _model.textController3,
                                        obscureText: !_model.passwordVisibility,
                                        decoration: InputDecoration(
                                          labelText: 'Contraseña',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () =>
                                                setState(
                                                      () =>
                                                  _model.passwordVisibility =
                                                  !_model.passwordVisibility,
                                                ),
                                            focusNode:
                                            FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.passwordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                  .visibility_off_outlined,
                                              color: AzaBankTheme.of(context).primaryText,
                                              size: 22.0,
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme.of(context).primaryText,
                                        ),
                                        keyboardType:
                                        TextInputType.visiblePassword,
                                        onChanged: (value) {
                                          passwordReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.textController4,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Nombres',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText,
                                        ),
                                        validator: _model
                                            .textController4Validator
                                            .asValidator(context),
                                        onChanged: (value) {
                                          nombresReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.textController5,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Apellidos',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText,
                                        ),
                                        validator: _model
                                            .textController5Validator
                                            .asValidator(context),
                                        onChanged: (value) {
                                          apellidosReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        validator: (value){
                                          if (value!.isEmpty || value.length < 10) {
                                            return 'N° Cedula debe tener 10 dijitos';
                                          }
                                          return null;
                                        },
                                        controller: _model.textController8,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Num. Identificacion',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText,
                                        ),
                                        onChanged: (value) {
                                          numCedulaReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.textController6,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Institución/Empresa',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText,
                                        ),
                                        validator: _model
                                            .textController6Validator
                                            .asValidator(context),
                                        onChanged: (value) {
                                          empresaReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.textController7,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Cargo',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText,
                                        ),
                                        validator: _model
                                            .textController7Validator
                                            .asValidator(context),
                                        onChanged: (value) {
                                          cargoReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AzaBankTheme
                                            .of(context)
                                            .orange,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 20.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.textController2,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Número Celular',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: AzaBankTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: AzaBankTheme
                                              .of(context)
                                              .primaryText,
                                        ),
                                        validator: _model
                                            .textController2Validator
                                            .asValidator(context),
                                        onChanged: (value) {
                                          numCelularReg = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0,
                                0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 310.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x12000000),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: Colors.orange,
                                        // Cambia el color del borde según tus necesidades
                                        width: 2.0,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () => _selectDate(context),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Fecha de Nacimiento  ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Icon(Icons.calendar_today),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5.0, 20.0, 5.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      // Validaciones de campos
                                      if (correoReg == null || !isValidEmail(correoReg!)) {
                                        showValidationError('Correo electrónico no válido, debe tener "@"');
                                        return;
                                      }

                                      if (passwordReg == null || passwordReg!.length < 7) {
                                        showValidationError('La contraseña debe tener al menos 7 caracteres');
                                        return;
                                      }
                                      if (numCedulaReg == null || numCedulaReg!.length < 10) {
                                        showValidationError('Cedula debe tener 10 dijitos');
                                        return;
                                      }
                                      bool isRepetido = await isCorreoRepetido(correoReg!);
                                      if (isRepetido) {
                                        showValidationError('Correo repetido');
                                        return;
                                      }

                                        //Validar todos los campos
                                      if (correoReg == null ||
                                          passwordReg == null ||
                                          nombresReg == null ||
                                          apellidosReg == null ||
                                          numCedulaReg == null ||
                                          numCelularReg == null ||
                                          empresaReg == null ||
                                          cargoReg == null ||
                                          selectedDate == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Por favor, completa todos los campos',
                                              style: AzaBankTheme
                                                  .of(context)
                                                  .titleSmall,
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: AzaBankTheme.of(context).error,
                                          ),
                                        );
                                        return;
                                      }
                                        registrar(
                                          correoReg!,
                                          passwordReg!,
                                          nombresReg!,
                                          apellidosReg!,
                                          numCedulaReg!,
                                          numCelularReg!,
                                          empresaReg!,
                                          cargoReg!,
                                          selectedDate,
                                        );

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Cuenta creada correctamente',
                                              style: AzaBankTheme.of(context).titleSmall,
                                            ),
                                            duration: Duration(milliseconds: 4000),
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
                                            child: LoginPageWidget(),
                                          ),
                                        );

                                    },
                                    text: 'Registro',
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
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¿Tienes una cuenta?',
                                  style: AzaBankTheme
                                      .of(context)
                                      .bodyMedium,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      3.0, 0.0, 0.0, 0.0),
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
                                          reverseDuration:
                                          Duration(milliseconds: 300),
                                          child: LoginPageWidget(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Inicia Sesión',
                                      style: AzaBankTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        color:
                                        AzaBankTheme
                                            .of(context)
                                            .orange,
                                        fontWeight: FontWeight.bold,
                                      ),
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
              ),
            ],
          ),
        ),
      );
    }

  void showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AzaBankTheme.of(context).titleSmall,
        ),
        duration: Duration(milliseconds: 4000),
        backgroundColor: AzaBankTheme.of(context).error,
      ),
    );
  }
  }



