import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class ChnagePasswordPage extends StatefulWidget {
  static const String RouteName = '/chnage_password';

  @override
  State<StatefulWidget> createState() => ChnagePasswordPageState();
}

class ChnagePasswordPageState extends State<ChnagePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  bool errorOld = false;
  bool errorNew = false;
  bool errorConfirm = false;

  @override
  Widget build(BuildContext context) => MyWidget(
      title: HHString.change_password,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                HHEditText(
                    hint: "Old Password",
                    obscureText: true,
                    controller: oldPasswordController,
                    error: errorOld,
                    errorText: 'Please enter correct old password',
                    showeye: true
                ),
                SizedBox(height: 10,),
                HHEditText(
                    hint: "New Password",
                    obscureText: true,
                    controller: newPasswordController,
                    error: errorNew,
                    errorText: 'Please enter a valid password',
                    showeye: true
                ),
                SizedBox(height: 10,),
                HHEditText(
                    hint: "Confirm Password",
                    obscureText: true,
                    controller: cPasswordController,
                    error: errorConfirm,
                    errorText: 'Passwords do not matched',
                    showeye: true
                )
              ],
            ),
            HHButton(title: 'Save', type: 4, isEnable: true,)
          ],
        ),
      )
  );
}
