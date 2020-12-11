import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/screens/dashboard.dart';

class Splash extends StatefulWidget{

  static const String RouteName = '/';

  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>{
                  Navigator.pop(context),
                  Navigator.pushNamed(context, Dashboard.RouteName )
                }
    );
  }
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        color: Color(0xff777CEA),
        child: 
        // Column(children: [
          Flexible(
            // child: Container(
              child: Image.asset('assets/images/ic_appicon_white.png', 
                height: 100,
                width: 150,
                fit: BoxFit.none,
                cacheHeight: 100,
                cacheWidth: 150,
                ),
                
            ),
            
          // )
          
        // ],)
       
        

    );
  }
}


