import 'dart:math';

import 'package:flutter/material.dart';

import 'call.dart';
import 'call_methods.dart';
import 'call_screen.dart';
import 'constants.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({String from, String to, context, bool isVideo}) async {
    Call call = Call(
      callerId: from,
      callerName: from,
      callerPic: '',
      receiverId: to,
      receiverName: to,
      receiverPic: '',
      isVideo: isVideo,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call, myId: from,),
        ),
      );
    }
  }
}
