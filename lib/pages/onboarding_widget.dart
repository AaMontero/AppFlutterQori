import 'package:aza_bank/components/data/contents_onboarding.dart';
import 'package:aza_bank/index.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key? key}) : super(key: key);

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  int currenIndex = 0;
  late PageController _controller;
  @override
  void initState(){
    _controller = PageController();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors:[
            Colors.indigo,
            Colors.blue,
          ])),
          child: Column(
            children: [
              Expanded(child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index){
                    setState(() {
                      currenIndex=index;
                    });
                  },
                  itemBuilder: (_,i){
                    return SingleChildScrollView(
                      child: Padding(padding: EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Image.asset(contents[i].image),
                            SizedBox(height:20),
                            Text(
                              contents[i].text,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text (
                              contents[i].descripcion,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        contents.length, (index) => buildPage(index, context))),
              ),
              Container(
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.all(40),
                child: MaterialButton(
                  onPressed: () async{
                    if (currenIndex == contents.length -1){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_)=>  NavBarPage(initialPage: 'HomePage')),);
                    }
                    _controller.nextPage(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    );
                  },
                  color: Colors.indigo,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child :Text(
                    currenIndex == contents.length -1 ?"Continuar": "Siguiente",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),

      )
    );
  }
  Container buildPage(int index, BuildContext context){
    return Container(
      height: 10,
      width: currenIndex==index ? 20 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currenIndex==index ? Colors.red : Colors.green.withOpacity(0.4)
      ),
    );
  }
}
