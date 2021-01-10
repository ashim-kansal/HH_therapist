import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String RouteName = '/reset_password';

  ResetPasswordPage({Key key, this.title}) : super(key: key);

  final String title;
  var pwderror = false;
  var cpwderror = false;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  bool securePwd = true;
  bool secureCPwd = true;

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
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

  void resetPwdHandler(){

    String password = passwordController.text;
    String cPassword = cpasswordController.text;

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if(password.trim().length == 0 && cPassword.trim().length == 0){
      setState(() {
        widget.pwderror = true;
        widget.cpwderror = true;
      });
      return;
    }

    if(password.trim().length == 0 || !pwdRegex.hasMatch(password)){
      setState(() {
        widget.pwderror = true;
        widget.cpwderror = false;
      });
      return;
    }

    if(cPassword.trim().length == 0 || !pwdRegex.hasMatch(cPassword)){
      setState(() {
        widget.pwderror = false;
        widget.cpwderror = true;
      });
      return;
    }

    setState(() {
      widget.pwderror = false;
      widget.cpwderror = false;
    });

    //show circular bar
    buildShowDialog(context);
    //API call
    APIService apiService = new APIService();
    apiService.resetPwdAPIHandler(password, cPassword).then((value) => {
      //  showToast(value.responseMsg),
      Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
        ()=> {
          showToast(value.responseMsg),
      }),

      if(value.responseCode == 200){

        Timer(Duration(seconds: 2),
          ()=> {
            Navigator.pop(context),
            Navigator.pushNamed(context, LoginPage.RouteName),
        }),
       
      }
    });
    // _resetPwdAPIHandler(password, cPassword);                                
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

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).reset_password, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Material(
                    child: ClipPath(
                      // color: Colors.white,
                      // padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),

                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Image.asset('assets/images/ic_new_password.png', height: 118,width: 75,),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                  AppLocalizations.of(context).enter_new_pass_below,
                                style: TextStyle(color: Color(0xff8d8d8d)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
                                  child: HHEditText(
                                    hint: AppLocalizations.of(context).enter_new_pass,
                                    obscureText: securePwd,
                                    controller: passwordController,
                                    error: widget.pwderror,
                                    errorText:
                                    AppLocalizations.of(context).pls_enter_new_pass,
                                    showeye: true,
                                    onClickEye: () {
                                      setState(() {
                                        securePwd = !securePwd;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: AppLocalizations.of(context).confirm_password,
                                    obscureText: secureCPwd,
                                    controller: cpasswordController,
                                    error: widget.cpwderror,
                                    errorText:
                                    AppLocalizations.of(context).valid_confirm_pass,
                                    showeye: true,
                                    onClickEye: () {
                                      setState(() {
                                        secureCPwd = !secureCPwd;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                                  child: HHButton(
                                    isEnable: true,
                                    title: AppLocalizations.of(context).reset,
                                    type: 2,
                                    onClick: () {
                                      resetPwdHandler();
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 8.0,
                    shadowColor: Colors.black38,
                    borderRadius: BorderRadius.circular(8.0),
                    borderOnForeground: true,
                  ),
                ],
              )),
          // backgroundColor: Colors.white,
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
