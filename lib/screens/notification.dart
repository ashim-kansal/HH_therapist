import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/message.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  static const String RouteName = '/notification';

  NotificationPage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return new MyWidget(
      title: 'Notification',
      sideMargin: 15,
        child: new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(children: [
              Padding(padding: EdgeInsets.only(bottom: 5),
                child: NotificationList(title: 
                  "Your Order No. #YUUNB01 is accepted by the Aurvedic Pharmacy.",
                    subtitle: "Now"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 5),
                child: NotificationList(title: 
                  "Your Order No. #YUUNB01 is accepted by the Aurvedic Pharmacy.",
                    subtitle: "Now"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 5),
                child: NotificationList(title: 
                  "Your Order No. #YUUNB01 is accepted by the Aurvedic Pharmacy.",
                    subtitle: "Now"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 5),
                child: NotificationList(title: 
                  "Your Order No. #YUUNB01 is accepted by the Aurvedic Pharmacy.",
                    subtitle: "Now"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 5),
                child: NotificationList(title: 
                  "Your Order No. #YUUNB01 is accepted by the Aurvedic Pharmacy.",
                    subtitle: "Now"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 5),
                child: NotificationList(title: 
                  "Your Order No. #YUUNB01 is accepted by the Aurvedic Pharmacy.",
                    subtitle: "Now"),
              ),

            ],)
            ));
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}