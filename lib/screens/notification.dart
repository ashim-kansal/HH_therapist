import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/NotificationList.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';

class NotificationPage extends StatefulWidget {
  static const String RouteName = '/notification';

  NotificationPage({Key key, this.title}) : super(key: key);
  String title;

  @override
  State<StatefulWidget> createState() =>_NotificationState();
  // _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

  Future<NotificationListing> notificationFuture;
  List<Result> list;

  @override
  void initState() {
    super.initState();
    notificationFuture = getNotificationList();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }

  //delete notification
  void deleteNotification (String notificationId) {
    print(notificationId);

    InAppAPIServices inAppAPIServices = new InAppAPIServices();
    buildShowDialog(context);

    inAppAPIServices.deleteNotification(notificationId).then((value) => {
      Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
      ()=> {
        showToast(value.responseMsg),
      }),
      
      if(value.responseCode == 200){
        notificationFuture = getNotificationList(),
      }
    });
  }

  // show circular 
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

    //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).Notification, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body:  new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: FutureBuilder<NotificationListing>(
              future: notificationFuture,
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasError){
                    return Container(
                      child: Center(
                        child: HHTextView(title: AppLocalizations.of(context).no_record_found, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,),
                      ),
                    );
                  }
                  return ListView.separated(itemBuilder: (context, index) {
                    var _date = snapshot.data.result[index].createdAt;
                    Moment createdDt = Moment.parse('$_date');
                    return Column(children: [
                      NotificationList(title:
                          snapshot.data.result[index].title,
                          subtitle: createdDt.format("dd MMM, yyyy"),
                          onDelete: () {
                            deleteNotification(snapshot.data.result[index].id);

                            // snapshot.data.result.indexWhere((element) => element.id == snapshot.data.result[index].id);
                          },
                      ),
                      
                    ],);
                  }, 
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 1);
                  },
                  itemCount: snapshot.data.result.length);
                }else {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
              )
            ));
  }
}