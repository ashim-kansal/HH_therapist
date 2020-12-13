import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

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
  var securepwd = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // void dispose() {
    
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  void showPwd(){
    print("action");
    setState(() {
      securepwd = !securepwd;
    });
  }

  void loginHandler() {
  
    String email = emailController.text;
    String password = passwordController.text;

    var emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


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
    Navigator.pushNamed(context, Dashboard.RouteName);
  }

  // void checkIfValidate(email, password){
  //   var flag = true;

   
  // }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(

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
                              'Welcome back',
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
                              'Login into your existing account',
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
                                hint: "Enter Email Id",
                                controller: emailController,
                                error: emailerror,
                                errorText: 'Please enter a valid email address',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: 
                              HHEditText(
                                hint: "Enter Password",
                                obscureText: securepwd,
                                controller: passwordController,
                                error: pwderror,
                                errorText: 'Please enter a valid password',
                                showeye: true,
                                onClickEye: () {
                                  setState(() {
                                    securepwd = !securepwd;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: HHButton(title: "Login", type: 4, isEnable: true, 
                              onClick: (){
                                loginHandler();
                                // 
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
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ForgotPasswordPage.RouteName);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text('Forgot Password?', textAlign: TextAlign.center,

                      style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontFamily: "ProximaNova")),

                ),
              ),

              SizedBox(height: 15),


            ],
          )),
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
