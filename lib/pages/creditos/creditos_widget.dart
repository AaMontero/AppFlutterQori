import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../theme/aza_bank_theme.dart';
import '../../theme/aza_bank_util.dart';
import '../../theme/aza_bank_widgets.dart';
import 'package:flutter/material.dart';
import 'creditos_model.dart';
import 'sincreditos_widget.dart';

class CreditosWidget extends StatefulWidget {
  const CreditosWidget({Key? key}) : super(key: key);

  @override
  State<CreditosWidget> createState() => _CreditosWidgetState();

}


class _CreditosWidgetState extends State<CreditosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  bool tieneCredito = false;


  @override
  Widget build(BuildContext context) {

    if(tieneCredito){
      return ConCreditosWidget();
    }else {
      return SinCreditosWidget();
    }
  }

}


