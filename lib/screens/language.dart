import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';

class LanguagePage extends StatefulWidget {
  static const String RouteName = '/select_anguage';

  @override
  State<StatefulWidget> createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> {
  bool english = false;
  bool french = false;
  bool spanish = false;

  @override
  void initState() {
    super.initState();
    english = true;
    french = true;
    spanish = true;
  }

  @override
  Widget build(BuildContext context) => MyWidget(
      title: HHString.select_language,
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('English',
                        style: TextStyle(
                            fontSize: 16,
                            color: HH_Colors.grey_35444D,
                            fontFamily: "ProximaNova")),
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Checkbox(
                      value: english,
                      activeColor: HH_Colors.color_17AB35,
                      onChanged: (value) {
                        setState(() {
                          english = value;
                        });
                      },
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: HH_Colors.grey_707070,
            height: 0.5,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Français',
                        style: TextStyle(
                            fontSize: 16,
                            color: HH_Colors.grey_35444D,
                            fontFamily: "ProximaNova")),
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Checkbox(
                      value: this.french,
                      activeColor: HH_Colors.color_17AB35,
                      onChanged: (value) {
                        setState(() {
                          french = value;
                        });
                      },
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: HH_Colors.grey_707070,
            height: 0.5,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text('Español',
                      style: TextStyle(
                          fontSize: 16,
                          color: HH_Colors.grey_35444D,
                          fontFamily: "ProximaNova")),
                ]),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Checkbox(
                      value: spanish,
                      activeColor: HH_Colors.color_17AB35,
                      onChanged: (value) {
                        setState(() {
                          spanish = value;
                        });
                      },
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: HH_Colors.grey_707070,
            height: 0.5,
          ),
        ],
      ));
}
