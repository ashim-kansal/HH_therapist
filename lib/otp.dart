import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class OtpPage extends StatefulWidget {
  static const String RouteName = '/otp';

  OtpPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpPage> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();

  TextEditingController currController = new TextEditingController();

  Timer _timer;
  int _start = 30;

  FocusNode firstinput;
  FocusNode secondinput;
  FocusNode thirdinput;
  FocusNode fourthinput;

  @override

  void initState() {
    super.initState();
    currController = controller1;

    firstinput = FocusNode();
    secondinput = FocusNode();
    thirdinput = FocusNode();
    fourthinput = FocusNode();
    
    startTimer();
  }

   void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
    void dispose() {
      super.dispose();
       _timer.cancel();
      controller1.dispose();
      controller2.dispose();
      controller3.dispose();
      controller4.dispose();

      firstinput.dispose();
      secondinput.dispose();
      thirdinput.dispose();
      fourthinput.dispose();
    }


    //API call

   _resendOtp () async {
      APIService apiService = new APIService();

      apiService.resendOTPAPIHandler().then((value) => {
        showToast(value.responseMsg),
        if(value.responseCode == 200){
          startTimer()
        }
      });
   }

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

    void focusToField(val, type) {

      switch (type) {
        case "first":
          if(val.trim().length != 0){
            secondinput.requestFocus();
          }
          break;
        case "second":
          if(val.trim().length == 0){
            firstinput.requestFocus();
            return;
          }
          thirdinput.requestFocus();
          break;
        case "third":
          if(val.trim().length == 0){
            secondinput.requestFocus();
            return;
          }
          fourthinput.requestFocus();
          break;
        case "fourth":
          if(val.trim().length == 0){
            thirdinput.requestFocus();
            return;
          }
          break;
        default:
      }
    }

    List<Widget> widgetList = [

      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(
                    width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: new BorderRadius.circular(4.0)),
            child: new TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              keyboardType: TextInputType.number,
              onChanged: (val) => focusToField(val, "first"),
              decoration: InputDecoration(
                border: InputBorder.none),
              enabled: true,
              controller: controller1,
              focusNode: firstinput,
              autofocus: true,
              // maxLength: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )
            ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            onChanged: (val) => focusToField(val, "second"),
            decoration: InputDecoration(
            border: InputBorder.none),
            controller: controller2,
            // autofocus: false,
            focusNode: secondinput,
            enabled: true,
            // maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            onChanged: (val) => focusToField(val, "third"),
            decoration: InputDecoration(
              border: InputBorder.none),
            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            focusNode: thirdinput,
            enabled: true,
            // maxLength: 1,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            onChanged: (val) => focusToField(val, "fourth"),
            decoration: InputDecoration(
                border: InputBorder.none),
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            focusNode: fourthinput,
            enabled: true,
            // maxLength: 1,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      )
    ];


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

  void otpVerifyHandler() {
    if(controller1.text.trim().length == 0 || controller2.text.trim().length == 0 || controller3.text.trim().length == 0 || controller4.text.trim().length == 0){
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return DialogWithSingleButton(
            title: "Alert",
            content: "Please enter the valid OTP.",
          );
        },
      );
      return;
    }
    String otp = controller1.text+controller2.text+controller3.text+controller4.text;
    
    //show circular bar
    buildShowDialog(context);
    // _otpAPIHandler(otp);
    APIService apiService = new APIService();

    apiService.otpAPIHandler(otp).then((value) => {
      Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
        ()=> {
          
          showToast(value.responseMsg),
      }),
      
      if(value.responseCode == 200){
        Timer(Duration(seconds: 2),
          ()=>{
          Navigator.pop(context),
            Navigator.pushNamed(context, ResetPasswordPage.RouteName),
        })
      }
    });
  }

    

    return MyWidget(
      title: 'OTP Verification',
      child: SingleChildScrollView(
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

                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Image.asset('assets/images/ic_otp.png', height: 100,width: 60,),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          'Please enter you registered email address. We will help you retrieve your password.',
                          style: TextStyle(color: Color(0xff8d8d8d)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    GridView.count(
                                        crossAxisCount: 4,
                                        // mainAxisSpacing: 10.0,
                                        shrinkWrap: true,
                                        primary: false,
                                        scrollDirection: Axis.vertical,
                                        children:
                                        List<Container>.generate(4,
                                                (int index) =>
                                                Container(
                                                    child: widgetList[
                                                    index])
                                        )),
                                  ])
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Resend code in: $_start'),
                            RaisedButton(

                                child: Icon(Icons.arrow_right_alt_rounded,
                                  color: HH_Colors.color_white,
                                  size: 28,
                                ),

                                onPressed: (){
                                  otpVerifyHandler();
                                  // Navigator.pop(context);
                                  // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                                },
                                shape: CircleBorder()
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: _start == 00.00 ? (

                          Container(
                            margin: EdgeInsets.only(top: 10, right: 40, left: 40),
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(
                                // shape: BoxShape.rectangle,
                                border: Border.all(color: HH_Colors.borderGrey),
                                borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Color(0xff707070), fontFamily: "ProximaNova"),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Resend OTP', 
                                      style: TextStyle(color: HH_Colors.blue_5580FF, decoration: TextDecoration.underline, decorationColor: HH_Colors.blue_5580FF, fontSize: 14, fontFamily: "ProximaNova"),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => {
                                          _resendOtp()
                                        }),
                                  ],
                                ),
                              )
                            )
                          )

                          // Container(
                          //   margin: EdgeInsets.only(top: 20),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.max,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       HHButton(title: "Resend OTP", type: 4, onClick: () {
                          //         _resendOtp();
                          //       },)
                          //     ],
                          //   ),
                          // )
                        ): null
                      )
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


        ),
      ) ,
    );
  }

  void inputTextToField(String str) {
    //Edit first textField
    if (currController == controller1) {
      controller1.text = str;
      currController = controller2;
    }

    //Edit second textField
    else if (currController == controller2) {
      controller2.text = str;
      currController = controller3;
    }

    //Edit third textField
    else if (currController == controller3) {
      controller3.text = str;
      currController = controller4;
    }
  }

  void deleteText() {
    if (currController.text.length == 0) {
    } else {
      currController.text = "";
      currController = controller4;
      return;
    }

    if (currController == controller1) {
      controller1.text = "";
    } else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    } else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    }
  }
}