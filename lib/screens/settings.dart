import 'package:flutter/material.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/screens/change_password.dart';
import 'package:flutter_app/screens/feedback.dart';
import 'package:flutter_app/screens/language.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';

class SettingsPage extends StatefulWidget{
  static const String RouteName = '/settings';

  @override
  State<StatefulWidget> createState() =>SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>{

  bool isSwitched = false;

  String language = "";

  // bool notifyStatus = false; 

  UserAPIServices userAPIServices = new UserAPIServices();

  @override
  void initState() {
    super.initState();
    
    userAPIServices.getProfile().then((value) => {
      if (value.responseCode == 200) {
        setState(() {
          isSwitched = value.result.notificationStatus??false;
          language = value.result.appLanguage??"";
        })
      }
    });
    // isSwitched??true;
  }

  void notificationHandler(bool value){
    setState(() {
      isSwitched = value;
    });

    // API call
    SettingAPIService settingAPIService = new SettingAPIService();

    settingAPIService.updateNotificationStatus(value).then((value) => {
      showToast(value.responseMessage),
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
  Widget build(BuildContext context) => Column(
    children: [
      InkWell(
        onTap: (){
          Navigator.pushNamed(context, LanguagePage.RouteName, arguments: LanguageArguments(language));
        },
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/ic_change_language.png', height: 20, width: 20, color: HH_Colors.color_949494,),
                SizedBox(width: 10,),
                Text(AppLocalizations.of(context).change_language, style: TextStyle(fontSize: 18, color: HH_Colors.grey_707070, fontFamily: "ProximaNova")),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios_rounded, color: HH_Colors.accentColor,),
            )
          ],
        ),),
        Container(width: MediaQuery.of(context).size.width, color: HH_Colors.grey_707070, margin: EdgeInsets.fromLTRB(0,15, 0 ,15), height: 0.5,),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, ChnagePasswordPage.RouteName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/ic_password.png',height: 20, width: 20, color: HH_Colors.color_949494),
                  SizedBox(width: 10,),
                  Text(AppLocalizations.of(context).change_password, style: TextStyle(fontSize: 18, color: HH_Colors.grey_707070, fontFamily: "ProximaNova")),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.arrow_forward_ios_rounded, color: HH_Colors.accentColor,),
              )
            ],
          ),
        ),
        Container(width: MediaQuery.of(context).size.width, color: HH_Colors.grey_707070, margin: EdgeInsets.fromLTRB(0,15, 0 ,10), height: 0.5,),
      InkWell(
        onTap: (){},
        child:       Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_on_outlined, size: 20, color: HH_Colors.color_949494,),
                SizedBox(width: 10,),
                Text(AppLocalizations.of(context).Notifications, style: TextStyle(fontSize: 18, color: HH_Colors.grey_707070, fontFamily: "ProximaNova")),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Switch(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: isSwitched,
                onChanged: (value){
                  notificationHandler(value);
                },

              ),
            )
          ],
        ),

      ),
        Container(width: MediaQuery.of(context).size.width, color: HH_Colors.grey_707070, margin: EdgeInsets.fromLTRB(0,10, 0 ,15), height: 0.5,),
      InkWell(
        onTap: (){
          Navigator.pushNamed(context, FeedbackPage.RouteName);
        },
        child:    Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/ic_programs.png',height: 20, width: 20, color: HH_Colors.color_949494),
                SizedBox(width: 10,),
                Text('Contact to Admin', style: TextStyle(fontSize: 18, color: HH_Colors.grey_707070, fontFamily: "ProximaNova")),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios_rounded, color: HH_Colors.accentColor,),
            )
          ],
        ) ,

      ),

        Container(width: MediaQuery.of(context).size.width, color: HH_Colors.grey_707070, margin: EdgeInsets.fromLTRB(0,15, 0 ,20), height: 0.5,),

      InkWell(
        onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return DialogWithButtons(
                onDenyPress: () {
                  Navigator.pop(context);
                },

                onLogoutPress: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, LoginPage.RouteName);
                },
              );
            },
          );

        },
        child:    Row(
          children: [
            Image.asset('assets/images/ic_logout.png',height: 20, width: 20, color: HH_Colors.color_949494),
            SizedBox(width: 10,),
            Text(AppLocalizations.of(context).logout, style: TextStyle(fontSize: 18, color: HH_Colors.grey_707070, fontFamily: "ProximaNova")),
          ],
        ) ,

      ),

    ],
  );
}