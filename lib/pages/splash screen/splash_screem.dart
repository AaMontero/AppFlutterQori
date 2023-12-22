import 'package:aza_bank/index.dart';
import 'package:flutter/material.dart';

class SplashScreem extends StatefulWidget {
  const SplashScreem({Key? key}) : super(key: key);

  @override
  State<SplashScreem> createState() => _SplashScreemState();
}

class _SplashScreemState extends State<SplashScreem> {

@override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 3);
    Future.delayed(d,(){
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomePageWidget()),

      (route) => false);
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(children: [
      Container(
      decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage("assets/images/azul.png"),
        fit: BoxFit.cover,
      )
      ),
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: ListTile(
            titleTextStyle: TextStyle(color: Colors.white),
            title: Text('Almagro',style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            subtitle: Text("Bienvenido a la App",style: TextStyle(fontSize: 30,color: Colors.white),
              textAlign: TextAlign.center,

            ),
          ),
        ),
      ),
      const Padding(
          padding: EdgeInsets.all(110),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CircularProgressIndicator(
          color: Colors.indigo,
        ),
      ),
      )
],),
    );
  }
}
