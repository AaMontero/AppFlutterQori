import 'package:aza_bank/index.dart';
import 'package:aza_bank/pages/creditos/creditos_widget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class SplashScreem1 extends StatefulWidget {
  const SplashScreem1({Key? key}) : super(key: key);

  @override
  State<SplashScreem1> createState() => _SplashScreem1State();
}

class _SplashScreem1State extends State<SplashScreem1> {

  @override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 3);
    Future.delayed(d,(){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavBarPage(initialPage: 'HomePage')),

              (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/azul1.png"),
                fit: BoxFit.cover,
              )
          ),

        ),

      ],),
    );
  }
}
