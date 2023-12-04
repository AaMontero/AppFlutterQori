import '/components/choose_accoun_section/choose_accoun_section_widget.dart';
//import '/components/choose_bank_section/choose_bank_section_widget.dart';
import '../../theme/aza_bank_checkbox_group.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '../../theme/form_field_controller.dart';
import '/main.dart';
import '/pages/comfirm_tranfer/comfirm_tranfer_widget.dart';
import 'package:flutter/material.dart';
import 'solict_credito_modelo.dart';
export 'solict_credito_modelo.dart';



class SolicitCreditoWidget extends StatefulWidget {
  const SolicitCreditoWidget({Key? key}) : super(key: key);

  @override
  _SolicitCreditoWidgetState createState() => _SolicitCreditoWidgetState();
}

class _SolicitCreditoWidgetState extends State<SolicitCreditoWidget> {
  late SolicitCreditoModel _model;

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
    _model = createModel(context, () => SolicitCreditoModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _model.textController4 ??= TextEditingController();
    _model.textController5 ??= TextEditingController();
    _model.textController6 ??= TextEditingController();
    _model.textController7 ??= TextEditingController();
    _model.textController8 ??= TextEditingController();
    _model.textController9 ??= TextEditingController();
    _model.textController10 ??= TextEditingController();
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Solicitud de Credito',
                            style: AzaBankTheme.of(context).headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 15.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Color(0x00000000),
                          context: context,
                          builder: (bottomSheetContext) {
                            return GestureDetector(
                              onTap: () => FocusScope.of(context)
                                  .requestFocus(_unfocusNode),
                              child: Padding(
                                padding: MediaQuery.of(bottomSheetContext)
                                    .viewInsets,
                                child: Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.65,
                                  child: ChooseAccounSectionWidget(),
                                ),
                              ),
                            );
                          },
                        ).then((value) => setState(() {}));
                      },
                      child: Container(
                        width: 332.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0x12000000),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: AzaBankTheme.of(context).orange,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'VISA **** **** **** 1234',
                                    style: AzaBankTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: AzaBankTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  Text(
                                    'Available balance : 10,000\$',
                                    style: AzaBankTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Poppins',
                                      color:
                                      AzaBankTheme.of(context).orange,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: Icon(
                                    Icons.attach_money_rounded,
                                    color: AzaBankTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1.0,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _model.pageViewController ??=
                                PageController(initialPage: 0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Datos Personales',
                                            style: AzaBankTheme.of(context).headlineMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 20.0, 10.0, 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: 332.0,
                                            height: 55.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x12000000),
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: AzaBankTheme.of(context)
                                                    .orange,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                _model.textController1,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                  'Cedula de Identidad',
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  errorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                ),
                                                style: AzaBankTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(
                                                      context)
                                                      .primaryText,
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                validator: _model
                                                    .textController1Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: 332.0,
                                            height: 55.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x12000000),
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: AzaBankTheme.of(context)
                                                    .orange,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                _model.textController2,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                  'Nombre Completo',
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  errorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                ),
                                                style: AzaBankTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(
                                                      context)
                                                      .primaryText,
                                                ),
                                                validator: _model
                                                    .textController2Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: 332.0,
                                            height: 55.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x12000000),
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: AzaBankTheme.of(context)
                                                    .orange,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                _model.textController3,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Telefono',
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  errorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                ),
                                                style: AzaBankTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(
                                                      context)
                                                      .primaryText,
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                validator: _model
                                                    .textController3Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: 332.0,
                                            height: 55.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x12000000),
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: AzaBankTheme.of(context)
                                                    .orange,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                _model.textController4,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Note',
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  errorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                ),
                                                style: AzaBankTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(
                                                      context)
                                                      .primaryText,
                                                ),
                                                keyboardType:
                                                TextInputType.multiline,
                                                validator: _model
                                                    .textController4Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: 332.0,
                                            height: 55.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x12000000),
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color: AzaBankTheme.of(context)
                                                    .orange,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                _model.textController4,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Monto',
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  errorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(4.0),
                                                      topRight:
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                ),
                                                style: AzaBankTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(
                                                      context)
                                                      .primaryText,
                                                ),
                                                keyboardType:
                                                TextInputType.multiline,
                                                validator: _model
                                                    .textController4Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),

                                        AzaBankCheckboxGroup(
                                          options: [
                                            'Save to directory of beneficiary '
                                          ],
                                          onChanged: (val) => setState(() =>
                                          _model.checkboxGroupValues1 =
                                              val),
                                          controller: _model
                                              .checkboxGroupValueController1 ??=
                                              FormFieldController<List<String>>(
                                                [],
                                              ),
                                          activeColor:
                                          AzaBankTheme.of(context).primary,
                                          checkColor: Colors.white,
                                          checkboxBorderColor:
                                          Color(0xFF95A1AC),
                                          textStyle: AzaBankTheme.of(context)
                                              .bodyMedium,
                                          itemPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 2.0, 0.0, 0.0),
                                          initialized:
                                          _model.checkboxGroupValues1 !=
                                              null,
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type:
                                                  PageTransitionType.scale,
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  reverseDuration: Duration(
                                                      milliseconds: 300),
                                                  child: ComfirmTranferWidget(),
                                                ),
                                              );
                                            },
                                            text: 'Guardar',
                                            options: FFButtonOptions(
                                              width: 130.0,
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
                                  ),
                                ],
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
