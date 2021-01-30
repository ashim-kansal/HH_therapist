import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/screens/dashboard.dart';


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
}

class Splash extends StatefulWidget{

  static const String RouteName = '/';

  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{


  String data = "";
  String nameKey = "_key_name";
  String token;

  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  _register() {
    _firebaseMessaging.getToken().then((fcmtoken) => {
      SetStringToSP("deviceToken", fcmtoken),
      print(fcmtoken)
    });
  }

    getToken() async{
    var userToken = await GetStringToSP("token");

    setState(() {
      token = userToken;
    });
    token = userToken;
    print(userToken);
  }

  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp();

    getToken();
    _register();
    getMessage();

    const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler(
      (MethodCall methodcall) async {
        if (methodcall.method == 'getAll') {
          return {"flutter." + nameKey: "[ No Name Saved ]"};
        }
        return null;
      },
    );

    checkIfUserLoggedIn();
  }



  void getMessage(){
    int lastMessageId = 0;

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on receive N message $message');

      },
        onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      }
    );
  }

  void checkIfUserLoggedIn() async {
  
     Timer(Duration(seconds: 4),
      ()=>{
            Navigator.pop(context),
            if (token != null) {
              Navigator.pushNamed(context, Dashboard.RouteName)
            }else{
              Navigator.pushNamed(context, SelectLanguage.RouteName)
            },
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        color: Color(0xff777CEA),
        child: Center(
          child: Image.asset('assets/images/ic_appicon_white.png',
          height: 100,
          width: 150,
        ),
        )
        

    );
  }
}




