import 'package:aza_bank/pages/transfer_funds/transferencia_widget.dart';

import '/components/comfirm_tranfer_section/comfirm_tranfer_section_widget.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'comfirm_tranfer_model.dart';
export 'comfirm_tranfer_model.dart';

class ComfirmTranferWidget extends StatefulWidget {
  const ComfirmTranferWidget({Key? key}) : super(key: key);

  @override
  _ComfirmTranferWidgetState createState() => _ComfirmTranferWidgetState();
}

class _ComfirmTranferWidgetState extends State<ComfirmTranferWidget> {
  late ComfirmTranferModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComfirmTranferModel());
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
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
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
                                child: NavBarPage(initialPage: 'homePage'),
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
                          'Transferencia',
                          style: AzaBankTheme.of(context).headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Confirmar transaccion ',
                                style: AzaBankTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 0.0,
                        endIndent: 0.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'From Account',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '809678856757',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Beneficiary',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Adonis Justin Mark',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Beneficiary Account',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '78687868686',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Beneficiary Bank',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'GTBank ',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Amount',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '\$ 5000',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Note',
                                  style: AzaBankTheme.of(context).bodySmall.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'From Jimy',
                                  style: AzaBankTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: AzaBankTheme.of(context).secondaryText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () {


                                },
                                text: 'Comfirmar Transferencia',
                                options: FFButtonOptions(
                                  width: 130.0,
                                  height: 55.0,
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                            ),



                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding:
                              EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 10.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                     var confirmDialogResponse = await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('¡Atención!'),
                                            content: Text('¿Cancelar esta transacción?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Si'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                          false;
                                      if (confirmDialogResponse) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TransferenciaWidget()),
                                        );
                                      }
                                    },

                                  text: 'Cancelar',
                                  options: FFButtonOptions(
                                    width: 130.0,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: Colors.blue,
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
                              ),
                            ],

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
    );
  }
}
