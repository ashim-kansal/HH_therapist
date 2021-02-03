import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/review.dart';

import 'call.dart';
import 'call_methods.dart';
import 'call_screen.dart';
import 'constants.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();
  static dial({String from, String to, context, bool isVideo, String fromName, String toName, String image, String toImage, String sessionid, String programName, int callDuration}) async {
    Call call = Call(
      callerId: from,
      callerName: fromName,
      callerPic:image,
      receiverId: to,
      receiverName: toName,
      receiverPic: toImage,
      isVideo: isVideo,
      channelId: Random().nextInt(1000).toString(),
      sessionid: sessionid,
      programName: programName,
      callDuration: callDuration
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call, myId: from,),
        ),
      ).then((value) =>{
        Navigator.pushNamed(context, ReviewPage.RouteName, arguments: ReviewPageArgument(sessionid, programName))
      });
    }
  }

}
