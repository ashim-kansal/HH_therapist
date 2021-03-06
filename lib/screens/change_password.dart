import 'package:flutter/material.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';

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

  String confPasswordErrorMsg = "Please enter a confirm password";

  bool secureOld = true;
  bool secureNew = true;
  bool secureConfirm = true;

  void passwordHandler(BuildContext context) {

    String oldpwd = oldPasswordController.text;
    String newpassword = newPasswordController.text;
    String confpassword = cPasswordController.text;

    var pwdRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if(oldpwd.trim().length == 0 && newpassword.trim().length == 0 && confpassword.trim().length == 0){
      setState(() {
        errorOld = true;
        errorNew = true;
        errorConfirm = true;
      });
      return;
    }

    if(oldpwd.trim().length == 0){
      setState(() {
        errorOld = true;
        errorNew = false;
        errorConfirm = false;
      });
      return;
    }

    if(newpassword.trim().length == 0 || !pwdRegex.hasMatch(newpassword)){
      setState(() {
        errorOld = false;
        errorNew = true;
        errorConfirm = false;
      });
      return;
    }

    if(confpassword.trim().length == 0 || !pwdRegex.hasMatch(confpassword)){
      setState(() {
        errorOld = false;
        errorNew = false;
        errorConfirm = true;
      });
      return;
    }

    if(confpassword != newpassword){
      setState(() {
        confPasswordErrorMsg = AppLocalizations.of(context).confPasswordErrorMsg;
        errorOld = false;
        errorNew = false;
        errorConfirm = true;    
      });
    }

    setState(() {
        confPasswordErrorMsg = AppLocalizations.of(context).password_donotmatch;
        errorOld = false;
        errorNew = false;
        errorConfirm = true;    
      });

      SettingAPIService settingAPIService = new SettingAPIService();

      settingAPIService.changePassword(oldpwd, newpassword, confpassword).then((value) => {
        showToast(value.responseMsg),
        if(value.responseCode == 200){
          oldpwd = '',
          newpassword = '',
          confpassword = ''
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
                    hint: AppLocalizations.of(context).old_password,
                    obscureText: secureOld,
                    controller: oldPasswordController,
                    error: errorOld,
                    errorText: 'Please enter correct old password',
                    showeye: true,
                    onClickEye: () {
                      print("Count was selected.");
                      setState(() {
                        secureOld = !secureOld;
                      });
                    },
                ),
                SizedBox(height: 10,),
                HHEditText(
                    hint: AppLocalizations.of(context).new_password,
                    obscureText: secureNew,
                    controller: newPasswordController,
                    error: errorNew,
                    errorText: 'Please enter a valid password',
                    showeye: true,
                    onClickEye: () {
                      print("Count was selected.");
                      setState(() {
                        secureNew = !secureNew;
                      });
                    },
                ),
                SizedBox(height: 10,),
                HHEditText(
                    hint: AppLocalizations.of(context).change_password,
                    obscureText: secureConfirm,
                    controller: cPasswordController,
                    error: errorConfirm,
                    errorText: confPasswordErrorMsg,
                    showeye: true,
                    onClickEye: () {
                      print("Count was selected.");
                      setState(() {
                        secureConfirm = !secureConfirm;
                      });
                    },
                )
              ],
            ),
            HHButton(title: AppLocalizations.of(context).save, type: 4, isEnable: true,
            onClick: (){ passwordHandler(context);},)
          ],
        ),
      )
  );
}
