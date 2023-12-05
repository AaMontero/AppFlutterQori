import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_widgets.dart';
import 'package:flutter/material.dart';
import '/pages/solicitud credito/solicit_credito_widget.dart';

class CreditosWidget extends StatefulWidget {
  const CreditosWidget({Key? key}) : super(key: key);

  @override
  State<CreditosWidget> createState() => _CreditosWidgetState();
}

class _CreditosWidgetState extends State<CreditosWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creditos"),
      ),
      body: Column(
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
                    Container(
                      width: 100.0,
                      height: 100.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/Avatar-seetings.png',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // Alinea el texto a la izquierda
                        children: [
                          Text(
                            'Nombre Completo',
                            style: TextStyle(
                              color: AzaBankTheme.of(context).primary,  // Color azul
                              fontFamily: 'Poppins',
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5.0), // Espaciado entre los textos, puedes ajustarlo según sea necesario
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
          EdgeInsetsDirectional.fromSTEB(40.0, 10.0, 40.0, 80.0),
          child: Container(

            width: 332.0,
            height: 250.0,
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
                        10.0, 0.0, 0.0, 30.0),
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
                          SizedBox(height: 5.0),
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
                          SizedBox(height: 5.0),
                          Text(
                            'Cuotas:     ',
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
                          SizedBox(height: 5.0),
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
                          SizedBox(height: 5.0),
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
                          SizedBox(height: 5.0),
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
          Padding(
            padding:
            EdgeInsetsDirectional.fromSTEB(
                0.0, 20.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: ()=>{
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SolicitCreditoWidget()),
                ),
              },
              text: 'Solicitud Credito',
              options: FFButtonOptions(
                width: 300.0,
                height: 55.0,
                padding: EdgeInsetsDirectional
                    .fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional
                    .fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: AzaBankTheme.of(context)
                    .primary,
                textStyle:
                AzaBankTheme.of(context)
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
                borderRadius:
                BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),

    );
  }
}


