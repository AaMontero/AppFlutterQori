import '../../main.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import 'package:flutter/material.dart';
import '/pages/solicitud credito/solicit_credito_widget.dart';

class ConCreditosWidget extends StatefulWidget {
  const ConCreditosWidget({Key? key}) : super(key: key);

  @override
  State<ConCreditosWidget> createState() => _ConCreditosWidgetState();

}


class _ConCreditosWidgetState extends State<ConCreditosWidget> {
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
                            color: AzaBankTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Creditos',
                            style: AzaBankTheme.of(context).headlineMedium,
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
                              mainAxisAlignment:
                              MainAxisAlignment.center,
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
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nombre Completo',
                                        style: TextStyle(
                                          color: AzaBankTheme.of(context).primary,
                                          fontFamily: 'Poppins',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        'Monto: \$300.00',
                                        style: TextStyle(
                                          color: AzaBankTheme.of(context).primaryText,  // Color negro
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
                        padding:
                        EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 30.0, 50.0),
                        child: Container(

                          width: 332.0,
                          height: 310.0,
                          decoration: BoxDecoration(
                            color: Color(0x12000000),
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: AzaBankTheme.of(context).primaryText,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Padding (
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 40.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text(
                                      'Fecha Pago:     ',
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color: AzaBankTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Vencimiento:       ',
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color:
                                        AzaBankTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Cuotas Restantes:     ',
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color:
                                        AzaBankTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Tipo de cobro:    ',
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color:
                                        AzaBankTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Estado:      ',
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color:
                                        AzaBankTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Saldo:     ',
                                      style: AzaBankTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        color:
                                        AzaBankTheme.of(context)
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


