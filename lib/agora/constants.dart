


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const String FIRESTORE_USERS = "users";
const String FIRESTORE_CONTACTS = "contacts";
const String FIRESTORE_GROUPS = 'groups';
const String FIRESTORE_POSTS = "posts";
const String FIRESTORE_COMMENTS = "comments";
const String FIRESTORE_CHATS = "chats";
const String FIRESTORE_MESSAGES = "messages";


const String FIRESTORE_MEMBERS = "members";
const String MEMBER_VALUE_JOINED = 'joined';
const String MEMBER_VALUE_LEFT = 'left';
const String MEMBER_ROLE_USER = 'member';
const String MEMBER_ROLE_ADMIN = 'admin';


const String CALL_COLLECTION = "call";

const String CALL_STATUS_DIALLED = "dialled";
const String CALL_STATUS_RECEIVED = "received";
const String CALL_STATUS_MISSED = "missed";

const String REQUEST_STATUS_SENT = 'sent';
const String REQUEST_STATUS_RECEIVED = 'received';
const String FIRESTORE_REQUESTS = "requests";


class Constants{



  String getTimeFormat(int time) {
    String date = '';

    if (time > 0) {
      int years = (time / 31104000000).floor();
      if (years < 1) {
        int months = (time / 2592000000).floor();
        if (months < 1) {
          int week = (time / 604800000).floor();
          if (week < 1) {
            int day = (time / 86400000).floor();
            if (day < 1) {
              int hours = (time / 3600000).floor();
              if (hours < 1) {
                int min = (time / 60000).floor();
                if (min < 1) {
                  int sec = (time / 60000).floor();
                  if (sec < 1) {
                    date = 'Just Now';
                  } else {
                    date = '${sec}sec';
                  }
                } else {
                  date = '${min}m';
                }
              } else {
                date = '${hours}h';
              }
            } else {
              date = '${day}d';
            }
          } else {
            date = '${week}w';
          }
        } else {
          date = '${months}mon';
        }
      } else {
        date = '${years}yrs';
      }
    }

    print(date+"   "+time.toString());
    return date;
  }






}


class LoaderTransparent extends StatelessWidget {
  double height;
  double width;
  Color colorValue;
 // BuildContext context;

  LoaderTransparent({this.colorValue});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
        height: height,
        width: width,
        color: colorValue!=null?Colors.black45:colorValue,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 90.0,
                width: 90.0,
                child: Image.asset(
                  'assets/chappreylogowhite.gif',
                  fit: BoxFit.fill,
                ) // use you custom loader or default loader
              /*CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Colors.blue),
                    strokeWidth: 5.0)*/
            ),
          //  Text('LOADING',style: TextStyle(fontFamily: 'ProductSans',color: Colors.white),)
          ],
        )
    );
  }
}
