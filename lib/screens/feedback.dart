import 'package:flutter/material.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class FeedbackPage extends StatefulWidget {
  static const String RouteName = '/feedback';

  @override
  State<StatefulWidget> createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched ?? true;
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
                  title: "Please share your thoughts with us",
                  size: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                HHEditText(
                  minLines: 5,
                ),
              ])),
          HHButton(title: "Send", type: 4, onClick: (){
            // Navigator.pushNamed(context, Dashboard.RouteName);
          },)

        ],
      ));
}
