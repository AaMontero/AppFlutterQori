import '../../main.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import 'package:flutter/material.dart';
import '../solicitud credito/solicit_credito_widget.dart';


class SinCreditosWidget extends StatefulWidget {
  const SinCreditosWidget({Key? key}) : super(key: key);

  @override
  State<SinCreditosWidget> createState() => _SinCreditosWidgetState();

}


class _SinCreditosWidgetState extends State<SinCreditosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  bool tieneCredito = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AzaBankTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 0.0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Créditos',
                            style: AzaBankTheme.of(context).headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Añadir el mensaje de texto
                            Text(
                              'No tienes crédito, puedes hacer clic en el siguiente botón y llenar el siguiente formulario',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red, // Puedes cambiar el color según tu preferencia
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            // Añadir el botón y el icono
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SolicitCreditoWidget()),
                                    ),
                                  },
                                  text: 'Solicitud Crédito',
                                  options: FFButtonOptions(
                                    width: 300.0,
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
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.blue,
                                  size: 24.0,
                                ),
                              ],
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
        ),
      ),
    );
  }
}


