import 'package:aza_bank/pages/onboarding_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '../splash screen/splash_screem1.dart';
import '/main.dart';
import '/pages/forgot_password/forgot_password_widget.dart';
import '/pages/register_page/register_page_widget.dart';
import '/pages/welcome_page/welcome_page_widget.dart';
import 'package:flutter/material.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;
  String? correo = "";
  String? password = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
  }
  Future<void> actualizarTokenEnFirestore(String email, String fcmToken) async {
    print("Entra al metodo futuro");
    try {
      print("Entra en el try");
      CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');
      QuerySnapshot querySnapshot = await usuarios.where('correo', isEqualTo: email).get();
      if(querySnapshot.docs.isNotEmpty){
        print("Esta entrando a la parte del token");
        DocumentSnapshot document = querySnapshot.docs.first;
        DocumentReference usuariosCollection = document.reference;
        DocumentSnapshot usuariosSnapshot = await usuariosCollection.get();
        if (usuariosSnapshot.exists) {
          await usuariosCollection.update({'token': fcmToken});
          print('Token actualizado correctamente en Firestore.');
        } else {
          print('No se encontró un usuario con el correo electrónico proporcionado.');
        }
      }else{

      }

    } catch (error) {
      print('Error al actualizar el token en Firestore: $error');
    }
  }


  Future<bool> logearSesionCorreoPass(correoPar, passwordPar) async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fCMToken = await firebaseMessaging.getToken();
    print('El token que llega a logear es: $fCMToken');
    try {
      actualizarTokenEnFirestore(correoPar, fCMToken!);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: correoPar,
          password: passwordPar
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Usuario no encontrado') {
        print('No se encontró ningún usuario para ese correo electrónico.');
      } else if (e.code == 'contraseña incorrecta') {
        print('contraseña incorrecta');
      }
    }
    return false;
  }

  Future<bool> checkIfFirstTimeAfterLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeAfterLogin') ?? true;

    if (isFirstTime) {
      // Si es la primera vez después de iniciar sesión, actualiza el valor
      prefs.setBool('isFirstTimeAfterLogin', false);

    }

    return isFirstTime;
  }


  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
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
                                child: WelcomePageWidget(),
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
                          'Inicio Sesión',
                          style:
                              AzaBankTheme.of(context).headlineMedium.override(
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
                  color: AzaBankTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Illustration.png',
                                width: 218.0,
                                height: 170.0,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 0.0, 0.0, 20.0),
                                child: Container(
                                  width: 310.0,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x12000000),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: AzaBankTheme.of(context).orange,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 20.0, 0.0),
                                    child: TextFormField(
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
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AzaBankTheme.of(context)
                                                .primaryText,
                                          ),
                                      validator: _model.textController1Validator
                                          .asValidator(context),
                                      onChanged: (value){
                                        correo = value;
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
                              0.0, 5.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 0.0, 0.0, 10.0),
                                child: Container(
                                  width: 310.0,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x12000000),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: AzaBankTheme.of(context).orange,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 20.0, 0.0),
                                    child: TextFormField(
                                      controller: _model.textController2,
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Contraseña',
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
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordVisibility =
                                                !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: AzaBankTheme.of(context)
                                                .primaryText,
                                            size: 22.0,
                                          ),
                                        ),
                                      ),
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AzaBankTheme.of(context)
                                                .primaryText,
                                          ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: _model.textController2Validator
                                          .asValidator(context),
                                      onChanged: (value) {
                                        password = value;
                                      }
                                    ),
                                  ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
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
                                        child: ForgotPasswordWidget(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '¿Olvidaste tu contraseña ?',
                                    textAlign: TextAlign.end,
                                    style: AzaBankTheme.of(context).bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 20.0, 5.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    BuildContext currentContext = context;

                                    //Validaciones
                                    if (correo == null || !isValidEmail(correo!)) {
                                      showValidationError('Correo electrónico no válido');
                                      return;
                                    }

                                    if (password == null || password!.length < 6) {
                                      // Muestra un mensaje de error para la contraseña
                                      showValidationError('Contraseña incorrecta');
                                      return;
                                    }


                                    print("Credenciales: " + correo!);
                                    print("Credenciales: " + password!);

                                    bool isFirstTime = await checkIfFirstTimeAfterLogin();

                                    if(await logearSesionCorreoPass(correo, password)){


                                      print('isFirstTime: $isFirstTime');

                                      if (isFirstTime) {
                                      Navigator.pushReplacement(
                                           currentContext,
                                           PageTransition(
                                             type: PageTransitionType.scale,
                                             alignment: Alignment.bottomCenter,
                                             duration: Duration(milliseconds: 300),
                                             reverseDuration: Duration(milliseconds: 300),
                                             child:  OnboardingWidget(),
                                           ),
                                         );

                                      } else{
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                            duration: Duration(milliseconds: 200),
                                            reverseDuration: Duration(milliseconds: 200),
                                            child: SplashScreem1(),
                                          ),
                                        );

                                        Navigator.pushReplacement(
                                          currentContext,
                                          PageTransition(
                                            type: PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                            duration: Duration(milliseconds: 300),
                                            reverseDuration: Duration(milliseconds: 300),
                                            child: NavBarPage(initialPage: 'HomePage'),
                                          ),
                                        );
                                      }
                                    } else {
                                      print("No se pudo acceder a la cuenta");
                                    }

                                  },
                                  text: 'Ingresar',
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


                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿No tienes una cuenta? ',
                                style: AzaBankTheme.of(context).bodyMedium,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
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
                                        child: RegisterPageWidget(),
                                      ),
                                    );

                                  },
                                  child: Text(
                                    'Registrarse',
                                    style: AzaBankTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AzaBankTheme.of(context).orange,
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


}
