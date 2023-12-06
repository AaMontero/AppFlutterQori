import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '/pages/exchangerate/exchangerate_widget.dart';
import '/pages/interestrate/interestrate_widget.dart';
import '/pages/searchfor_branch/searchfor_branch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
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
                        'Consejos',
                        style: AzaBankTheme.of(context).headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
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
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: Text(
                                  'Objetivos de Inversion',
                                  style: AzaBankTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF0C0F10),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  'Es importante que tengas claridad\nde lo que deseas para que puedas\nescoger los instrumentos, \ntiempos y perfil de riesgo que\n mejor se ajuste a tus objetivos.',
                                  style: AzaBankTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AzaBankTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 25.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/images/breach-icon.svg',
                                width: 100.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    height: 190.0,
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
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: Text(
                                  'Tener Paciencia',
                                  style: AzaBankTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF0C0F10),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  'Tener una actitud disciplinada\ny paciente, planificando\nuna estrategia en el tiempo,\npersistiendo en ella y evitar ser\ndominado por euforia en las\nalzas o pánico en las pérdidas,\nemociones que te llevarán\na tomar decisiones irracionales.',
                                  style: AzaBankTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AzaBankTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 30.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/images/exchnage-rate.svg',
                                width: 100.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,

                  child: Container(
                    width: double.infinity,
                    height: 150.0,
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
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: Text(
                                  'Asesórate',
                                  style: AzaBankTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF0C0F10),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  'Busca el consejo de gente que\nhaya tenido éxito o que sean\nreconocidos por dedicar sus\nesfuerzos a las inversiones.',
                                  style: AzaBankTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AzaBankTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 30.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/images/intrest-rate.svg',
                                width: 100.0,
                                height: 60.0,
                                fit: BoxFit.cover,
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


