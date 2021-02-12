import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/agora/pickup_layout.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/screens/chatlist.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/utils/colors.dart';

class Dashboard extends StatefulWidget {
  static const String RouteName = '/home';

  String userId;

  Dashboard({Key key, this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var tabIndex = 0;
  String title = 'Dashboard';
  String id = '';
  int count = 0;

  List<Widget> listScreens;
  List<String> listNames = ['Dashboard', 'Patient Chat', 'Settings'];

  @override
  void initState() {
    super.initState();
    listScreens = [HomePage(), ChatListPage(), SettingsPage()];
    GetStringToSP("id").then((value) => {
      print("stoage value:- "+value),
          setState(() => {id = value})
        });
    getProfile();
  }

  void getProfile() {
    UserAPIServices userAPIServices = new UserAPIServices();

    userAPIServices.getProfile().then((value) => {
      if (value.responseCode == 200)
        {
          setState(() {
            count = value.result.totalUnreadNotificationList??0;
          })
        }
    });
  }


  @override
  Widget build(BuildContext context) => PickupLayout(
      myId: widget.userId??"11",
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text(
              tabIndex == 0
                  ? AppLocalizations.of(context).dashboard
                  : tabIndex == 1
                      ? AppLocalizations.of(context).mychat
                      : AppLocalizations.of(context).settings,
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          leading: Container(
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(
                  Icons.people_alt,
                  color: Colors.white,
                ),
                onPressed: () =>
                    {Navigator.pushNamed(context, ProfilePage.RouteName)},
              )),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child:new Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_on_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => {
                        Navigator.pushNamed(context, NotificationPage.RouteName).then((value) => {
                          getProfile()
                        })
                      },
                    ),
                    showBadge()
                  ],
                )
                )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: HH_Colors.accentColor,
            unselectedItemColor: HH_Colors.grey_707070,
            unselectedLabelStyle: TextStyle(color: HH_Colors.grey_707070),
            backgroundColor: Colors.white,
            currentIndex: tabIndex,
            onTap: (int index) {
              setState(() {
                tabIndex = index;
                // title = listNames[tabIndex];
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  tabIndex == 0
                      ? 'assets/images/ic_home_select.png'
                      : 'assets/images/ic_home.png',
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context).dashboard),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/ic_chat.png',
                  height: 25,
                  width: 25,
                  color: tabIndex == 1
                      ? HH_Colors.accentColor
                      : HH_Colors.grey_707070,
                ),
                title: Text(AppLocalizations.of(context).mychat),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  tabIndex == 2
                      ? 'assets/images/ic_settings_select.png'
                      : 'assets/images/ic_settings.png',
                  height: 25,
                  width: 25,
                ),
                title: Text(AppLocalizations.of(context).settings),
              )
            ]),
        body: Material(
            color: Theme.of(context).accentColor,
            child: Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    color: Colors.white),
                child: listScreens[tabIndex])),
      ));

  Widget showBadge() {
    return count>0 ? new Positioned(
      right: 0,
      child: new Container(
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: BoxConstraints(
          minWidth: 12,
          minHeight: 12,
        ),

      ),
    ) : Container();
  }
}

class DashboardArgument{

  String userId;
  DashboardArgument(this.userId);
}