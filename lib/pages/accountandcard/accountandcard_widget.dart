import 'package:image_picker/image_picker.dart';

import '/components/add_card_info_section/add_card_info_section_widget.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '/pages/delete_card/delete_card_widget.dart';
import 'package:flutter/material.dart';
import 'accountandcard_model.dart';
export 'accountandcard_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';



class AccountandcardWidget extends StatefulWidget {
  const AccountandcardWidget({Key? key}) : super(key: key);

  @override
  _AccountandcardWidgetState createState() => _AccountandcardWidgetState();
}

class _AccountandcardWidgetState extends State<AccountandcardWidget> {
  File? file;
  String? url;
  late AccountandcardModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  int get pageViewCurrentIndex => _model.pageViewController != null &&
          _model.pageViewController!.hasClients &&
          _model.pageViewController!.page != null
      ? _model.pageViewController!.page!.round()
      : 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountandcardModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }
  Widget widgetTransaccion(String fechaTransaccion, double montoTransaccion, String concepto){
    return
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            0.0, 20.0, 0.0, 0.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
        Expanded(
        child:
      Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          20.0, 10.0, 20.0, 10.0),
      child: Container(
        width: double.infinity,
        height: 110.0,
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
          borderRadius:
          BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding:
          EdgeInsetsDirectional.fromSTEB(
              5.0, 5.0, 5.0, 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(
                    10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          'Fecha: ',
                          style:
                          AzaBankTheme.of(
                              context)
                              .titleMedium
                              .override(
                            fontFamily:
                            'Poppins',
                            color: Colors
                                .black,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          '$fechaTransaccion',
                          style:
                          AzaBankTheme.of(
                              context)
                              .titleMedium
                              .override(
                            fontFamily:
                            'Poppins',
                            color: Colors
                                .black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(
                    10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          'Monto Transacción: ',
                          style:
                          AzaBankTheme.of(
                              context)
                              .titleSmall
                              .override(
                            fontFamily:
                            'Poppins',
                            color: Colors
                                .black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          '\$$montoTransaccion',
                          style:
                          AzaBankTheme.of(
                              context)
                              .titleMedium
                              .override(
                            fontFamily:
                            'Poppins',
                            color: AzaBankTheme.of(
                                context)
                                .primary,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(
                    10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          'Concepto',
                          style:
                          AzaBankTheme.of(
                              context)
                              .titleSmall
                              .override(
                            fontFamily:
                            'Poppins',
                            color: Colors
                                .black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          '$concepto',
                          style:
                          AzaBankTheme.of(
                              context)
                              .titleMedium
                              .override(
                            fontFamily:
                            'Poppins',
                            color: AzaBankTheme.of(
                                context)
                                .primary,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        ),
            ],
        ),
      );
  }

  getImageGaleria() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
      await picker.pickImage(source: ImageSource.gallery);

    if(image!= null){
      file = File(image!.path);
      print("El path es el siguiente:"+ file.toString());
      var refStorage = firebase_storage.FirebaseStorage.instance.ref("nombre.jpg");
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
    }else{
      print ("La imagen es nula");
    }

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    String saldo = "50";
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AzaBankTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 10.0),
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
                        'Ahorro - Detalles',
                        style: AzaBankTheme.of(context).headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 500.0,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _model.pageViewController ??=
                          PageController(initialPage: 0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Saldo/Transacciones',
                                          options: FFButtonOptions(
                                            width: 200.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: AzaBankTheme.of(context)
                                                .primary,
                                            textStyle: AzaBankTheme.of(context)
                                                .bodyMedium
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
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            await getImageGaleria();
                                            print("Entra al metodo");
                                            if(file!= null) Image.file(file!);
                                          },
                                          text: 'Agregar',
                                          options: FFButtonOptions(
                                            width: 150.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFF2F1F9),
                                            textStyle: AzaBankTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
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
                                      ],
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
                                            'assets/images/dinero_icon.webp',
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                          child: RichText(
                                            text: TextSpan(
                                              style: AzaBankTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Poppins',
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Saldo Actual: ',
                                                  style: TextStyle(
                                                    color: AzaBankTheme.of(context).primary,  // Color azul
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '\$$saldo',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 30.0// Color negro
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
                              widgetTransaccion("2024-12-08", 50.15, "Transferencia"),
                              widgetTransaccion("2025-01-08", 150.15, "Transferencia"),
                              widgetTransaccion("2026-02-08", 80.15, "Transferencia"),
                              widgetTransaccion("2026-03-08", 115.15, "Transferencia"),
                              widgetTransaccion("2026-04-08", 95.50, "Transferencia"),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 20.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            await _model.pageViewController
                                                ?.animateToPage(
                                              0,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          text: 'Account',
                                          options: FFButtonOptions(
                                            width: 150.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFF2F1F9),
                                            textStyle: AzaBankTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color:
                                                      AzaBankTheme.of(context)
                                                          .secondaryText,
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
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Cards',

                                          options: FFButtonOptions(
                                            width: 150.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: AzaBankTheme.of(context)
                                                .primary,
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
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
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
                                        child: DeleteCardWidget(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 215.0,
                                    decoration: BoxDecoration(
                                      color: AzaBankTheme.of(context)
                                          .primaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: Image.asset(
                                          'assets/images/fqvhn_1.png',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25.0, 25.0, 25.0, 25.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'John Smith',
                                                style: AzaBankTheme.of(context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 33.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Amazon Platinium',
                                                  style: AzaBankTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  ' 4756  **** **** 7645',
                                                  style:
                                                      AzaBankTheme.of(context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 15.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  '\$3.469.52',
                                                  style:
                                                      AzaBankTheme.of(context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
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
                                    0.0, 20.0, 0.0, 0.0),
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
                                        child: DeleteCardWidget(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 215.0,
                                    decoration: BoxDecoration(
                                      color: AzaBankTheme.of(context)
                                          .primaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: Image.asset(
                                          'assets/images/mmfwi_2.png',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25.0, 25.0, 25.0, 25.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'John Smith',
                                                style: AzaBankTheme.of(context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 33.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Amazon Platinium',
                                                  style: AzaBankTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  ' 4756  **** **** 7645',
                                                  style:
                                                      AzaBankTheme.of(context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 15.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  '\$3.469.52',
                                                  style:
                                                      AzaBankTheme.of(context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
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
                                    0.0, 50.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          barrierColor: Color(0x00000000000),
                                          context: context,
                                          builder: (bottomSheetContext) {
                                            return GestureDetector(
                                              onTap: () => FocusScope.of(
                                                      context)
                                                  .requestFocus(_unfocusNode),
                                              child: Padding(
                                                padding: MediaQuery.of(
                                                        bottomSheetContext)
                                                    .viewInsets,
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.65,
                                                  child:
                                                      AddCardInfoSectionWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => setState(() {}));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Card Added successfully ',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                AzaBankTheme.of(context).orange,
                                          ),
                                        );
                                      },
                                      text: 'Add Card',
                                      options: FFButtonOptions(
                                        width: 130.0,
                                        height: 55.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
