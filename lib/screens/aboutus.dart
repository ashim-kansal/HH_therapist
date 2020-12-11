import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';

class AboutUs extends StatelessWidget {
  static const String RouteName = '/about_us';

  var title;

  AboutUs({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: title,
        child: Flexible(
          flex: 1,
          child: Text(
            HHString.terms,
            style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
          ),
        ));
  }
}
