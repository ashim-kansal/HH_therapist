import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

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
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();

  TextEditingController currController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currController = controller1;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
              ],decoration: InputDecoration(
                border: InputBorder.none),
              enabled: false,
              controller: controller1,
              autofocus: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            )),
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
            ],decoration: InputDecoration(
              border: InputBorder.none),
            controller: controller2,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
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
            ],decoration: InputDecoration(
              border: InputBorder.none),
            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
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
            decoration: InputDecoration(
                border: InputBorder.none),
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      )
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('OTP Verification', style: TextStyle(color: Colors.white)),
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
                                        mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Resend code in: 00:48'),
                                  RaisedButton(
                                      
                                      child: Icon(Icons.arrow_right_alt_rounded,
                                        color: HH_Colors.color_white,
                                        size: 28,
                                      ),
                                    
                                      onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                                      },
                                      shape: CircleBorder()
                                  )
                                ],
                              ),
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

              )
          ),
          // backgroundColor: Colors.white,
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
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
