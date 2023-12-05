import '/components/choose_accoun_section/choose_accoun_section_widget.dart';
//import '/components/choose_bank_section/choose_bank_section_widget.dart';
import '../../theme/aza_bank_checkbox_group.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import '../../theme/form_field_controller.dart';
import '/main.dart';
import '/pages/comfirm_tranfer/comfirm_tranfer_widget.dart';
import '/pages/solicitud credito/solicit_credito1_widget.dart';
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
  List<String> maritalStatusOptions = ['Soltero', 'Casado', 'Divorciado', 'Viudo'];
  String selectedStatus = 'Soltero';

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
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.textController1,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Nombres',
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
                                                ),
                                                style: AzaBankTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(context).primaryText,
                                                ),
                                                keyboardType: TextInputType.text,
                                                validator: _model.textController1Validator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.textController2,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Apellidos',
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
                                                ),
                                                style: AzaBankTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(context).primaryText,
                                                ),
                                                keyboardType: TextInputType.text,
                                                validator: _model.textController2Validator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.textController3,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Cedula',
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
                                                ),
                                                style: AzaBankTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(context).primaryText,
                                                ),
                                                keyboardType: TextInputType.text,
                                                validator: _model.textController3Validator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.textController4,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Telefono',
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
                                                ),
                                                style: AzaBankTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(context).primaryText,
                                                ),
                                                keyboardType: TextInputType.text,
                                                validator: _model.textController4Validator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.textController5,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Direccion',
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
                                                ),
                                                style: AzaBankTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(context).primaryText,
                                                ),
                                                keyboardType: TextInputType.text,
                                                validator: _model.textController5Validator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: TextFormField(
                                                controller: _model.textController6,
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
                                                ),
                                                style: AzaBankTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Poppins',
                                                  color: AzaBankTheme.of(context).primaryText,
                                                ),
                                                keyboardType: TextInputType.text,
                                                validator: _model.textController6Validator.asValidator(context),

                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 10.0),
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Estado Civil: ',
                                                    style: TextStyle(
                                                      color: AzaBankTheme.of(context).primaryText,
                                                      // Ajusta otros estilos según tus preferencias
                                                    ),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: selectedStatus,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedStatus = value!;
                                                      });
                                                    },
                                                    items: maritalStatusOptions.map((String status) {
                                                      return DropdownMenuItem<String>(
                                                        value: status,
                                                        child: Text(
                                                          status,
                                                          style: TextStyle(
                                                            color: AzaBankTheme.of(context).primaryText,
                                                            // Ajusta otros estilos según tus preferencias
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  Visibility(
                                                    visible: selectedStatus == 'Casado',
                                                    child: Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
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
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
                                                            child: TextFormField(
                                                              decoration: InputDecoration(
                                                                labelText: 'Cédula del Cónyuge',
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
                                                                labelStyle: TextStyle(
                                                                  fontFamily: 'Poppins',
                                                                  color: AzaBankTheme.of(context).primaryText,
                                                                ),
                                                              ),
                                                              style: AzaBankTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Poppins',
                                                                color: AzaBankTheme.of(context).primaryText,
                                                              ),
                                                              keyboardType: TextInputType.number,
                                                              validator: (value) {
                                                                if (selectedStatus == 'Casado' && value!.isEmpty) {
                                                                  return 'Por favor, ingrese la cédula del cónyuge';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),

                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),





                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () =>{
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => SolicitCredito1Widget()),
                                              ),
                                            },
                                            text: 'Siguiente',
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
