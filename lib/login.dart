import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/agora/constants.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/privacy.dart';
import 'package:flutter_app/screens/terms.dart';
import 'package:flutter_app/utils/DBHelper.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static const String RouteName = '/login';

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  var emailerror = false;
  var pwderror = false;
  bool securepwd = true;
  bool isChecked = false;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    DBProvider.db.isChecked().then((value) => {
      setState((){
        isChecked = value;
      })
    });
  }

  String token = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  void showPwd(){
    // print("action");
    setState(() {
      securepwd = !securepwd;
    });
  }

  // show circular 
  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child:CircularProgressIndicator(),
          );
      });
  }

  void loginHandler() async {

    var deviceToken = await GetStringToSP("deviceToken");

    var voipToken = await GetStringToSP("voipToken");

    String email = emailController.text;
    String password = passwordController.text;

    var emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

    if(email.trim().length == 0 && password.trim().length == 0){
      setState(() {
        emailerror = true;
        pwderror = true;
      });
      return;
    }

    if(email.trim().length == 0 || !emailRegex.hasMatch(email)){
      setState(() {
        emailerror = true;
        pwderror = false;
      });
      return;
    }

    if(password.trim().length == 0 || !pwdRegex.hasMatch(password)){
      setState(() {
        emailerror= false;
        pwderror = true;
      });
      return;
    }

    setState(() {
      emailerror = false;
      pwderror = false;
    });

    if(!isChecked){
      showToast("Please agree with terms & conditions");
      return;
    }
    DBProvider.db.setChecked(isChecked);


    APIService apiService = new APIService();
    buildShowDialog(context);

    _firebaseMessaging.getToken().then((fcmtoken) => {
      apiService.loginAPIHandler(email, password, fcmtoken, voipToken).then(
        (value) => {

          Navigator.of(context).pop(),
          Timer(Duration(seconds: 1),
          ()=> {
            showToast(value.responseMsg),
          }),
          
          print(value.responseCode),
          // ignore: unrelated_type_equality_checks
          if (value.responseCode == 200) {
            SetStringToSP("token", value.token),
            SetStringToSP("id", value.id??""),
            // SetStringToSP("userData", {"name": value.})
            print("userId:- "+value.id??""),
            FirebaseFirestore.instance
                .collection(FIRESTORE_USERS)
                .doc(value.id??"")
                .set({"token": fcmtoken}),

            Timer(Duration(seconds: 2),
              ()=>{
                  Navigator.pop(context),
                  Navigator.pushNamed(context, Dashboard.RouteName, arguments: DashboardArgument(value.id)),
              }
            ),
          }
        })
    });
    // loginModel(email, password);
   
  }

  //API call 

  // ignore: missing_return
  

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  void checkToken () async {
    var token = await GetStringToSP("token");
    print("objTo");
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
// Container(
//                                       child: Center(child: CircularProgressIndicator(),),
//                                     );
      body:
      Container(
          margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 9,
              ),
              Material(
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                child: Container(

                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Container(decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                            child: Image.asset('assets/images/ic_appicon_blue.png', height: 62, width: 104,),

                          )
                        ]),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              AppLocalizations.of(context).Welcome_back,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xff5c5c5c),
                                  fontWeight: FontWeight.bold, 
                                  fontFamily: "ProximaNova"),
                            ),
                          )
                        ]),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                            child: Text(
                              AppLocalizations.of(context).login_to_existing,
                              style: TextStyle(color: Color(0xff8d8d8d), fontSize: 15, fontFamily: "ProximaNova"),
                            ),
                          )
                        ]),
                        Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                              child: 
                              HHEditText(
                                hint: AppLocalizations.of(context).enter_email,
                                controller: emailController,
                                error: emailerror,
                                errorText: AppLocalizations.of(context).enter_valid_email,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: 
                              HHEditText(
                                hint: AppLocalizations.of(context).enter_password,
                                obscureText: securepwd,
                                controller: passwordController,
                                error: pwderror,
                                errorText: AppLocalizations.of(context).pass_validation_msg,
                                showeye: true,
                                onClickEye: () {
                                  print("Count was selected.");
                                  setState(() {
                                    securepwd = !securepwd;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHButton(title: AppLocalizations.of(context).login, type: 4, isEnable: true,
                              onClick: (){
                                loginHandler();
                               
                              },),
                            ),
                         
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                elevation: 8.0,
                shadowColor: Colors.black38,
                borderRadius: BorderRadius.circular(8.0),
                borderOnForeground: true,
              ),
              InkWell(
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pushNamed(context, ForgotPasswordPage.RouteName);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(AppLocalizations.of(context).forgot_password_, textAlign: TextAlign.center,

                      style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontFamily: "ProximaNova")),

                ),
              ),

              SizedBox(height: 15,),
              Container(
                child: Center(
                  child : Row(
                      children: <Widget>[
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: HH_Colors.purpleColor,
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                        Flexible(
                            child: Center(child:
                            RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context).agree_desc,
                                style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Color(0xff707070), fontFamily: "ProximaNova"),
                                children: <TextSpan>[
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.pushNamed(context, TermsPage.RouteName);
                                    },
                                text: AppLocalizations.of(context).terms_service, style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14, fontFamily: "ProximaNova")),
                                  TextSpan(text: '& ', style: TextStyle(color: Color(0xff707070), decoration: TextDecoration.none, fontSize: 14, fontFamily: "ProximaNova")),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.pushNamed(context, PrivacyPolicy.RouteName);
                                    },
                                    text: AppLocalizations.of(context).privacy, style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14, fontFamily: "ProximaNova")),
                                ],
                              ),
                            )
                              ,) ),
                      ]
                  ),
                ),
              ),


            ],
          )),
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
