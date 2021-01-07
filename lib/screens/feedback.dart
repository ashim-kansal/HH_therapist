import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';

class FeedbackPage extends StatefulWidget {
  static const String RouteName = '/feedback';

  @override
  State<StatefulWidget> createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  bool isSwitched = false;
  var error = false;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSwitched ?? true;
  }

  void submitHandler() {
    var text = textController.text;

    if(text.trim().length == 0){
      setState(() {
        error = true;
      });
      return;
    }

    setState(() {
      error = false;
    });

    InAppAPIServices inAppAPIServices = new InAppAPIServices();
    buildShowDialog(context);
    inAppAPIServices.submitQuery(text).then((value) => {
      Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
      ()=> {
        showToast(value.responseMsg),
      }),

      // showToast(value.responseMsg),
      if(value.responseCode == 200){
        text = "",

        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return CustomAlertDialog(
              title: "We appreciate your feedback. Our team will have a look at it shortly.",
                onClick: (){
                  Navigator.pop(context);
                }
            );
          },
        ),
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

  @override
  Widget build(BuildContext context) => MyWidget(
      title: 'Contact Us',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Column(children: [
                HHTextView(
                  color: HH_Colors.color_707070,
                  title: "Please use this form to connect us",
                  size: 16,
                    textweight:FontWeight.w600

                ),
                SizedBox(
                  height: 10,
                ),
                HHEditText(
                  minLines: 5,
                  controller: textController,
                  error: error,
                  errorText: 'Please enter your thoughts.',
                ),
              ])),
          HHButton(title: "Send", type: 4, onClick: (){
            submitHandler();
          },)

        ],
      ));
}
