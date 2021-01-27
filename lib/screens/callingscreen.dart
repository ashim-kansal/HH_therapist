
import 'dart:async';
import 'dart:io';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/services/navigation_service.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/DBHelper.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:uuid/uuid.dart';

final FlutterCallkeep _callKeep = FlutterCallkeep();
bool _callKeepInited = false;

class Call {
  Call(this.number);
  String number;
  bool held = false;
  bool muted = false;
}

class Calling extends StatefulWidget {
  static const String RouteName = '/callingscreen';

  @override
  State<StatefulWidget> createState() => CallingState();
}


class CallingState extends State<StatefulWidget> {
  IncallManager incallManager = new IncallManager();
  Timer timer;
  String dropdownValue = 'English';
  final FlutterCallkeep _callKeep = FlutterCallkeep();
  Map<String, Call> calls = {};
  String newUUID() => Uuid().v4();

  final FirebaseMessaging fcm = FirebaseMessaging();

  void initState(){
    super.initState();
    incallManager.startRingtone(RingtoneUriType.DEFAULT, 'default', 30);

    timer = Timer(const Duration(seconds: 30), () {
      incallManager.stopRingtone();
      Timer(Duration(seconds: 1), ()=>
        {
          Navigator.pop(context, "Rejected"),
        });
    });

    fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on receive $message');
          String type = "";
          String status = "";

          if(Platform.isAndroid){
            type = message["data"]["type"];
            status = message["data"]["status"];
          }else{
            type = message["type"];
            status = message["status"];
          }
          if(type == 'call_status') {
            incallManager.stopRingtone();
            timer.cancel();
            Navigator.pop(context, status);
          }else if (type == "incoming_call"){
            messageHandler(message);
          }
        }, onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        // setState(() => _message = message["notification"]["title"]);
      }
    );

    //callkit
    _callKeep.on(CallKeepDidDisplayIncomingCall(), didDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), answerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), didPerformDTMFAction);
    _callKeep.on(
        CallKeepDidReceiveStartCallAction(), didReceiveStartCallAction);
    _callKeep.on(CallKeepDidToggleHoldAction(), didToggleHoldCallAction);
    _callKeep.on(
        CallKeepDidPerformSetMutedCallAction(), didPerformSetMutedCallAction);
    _callKeep.on(CallKeepPerformEndCallAction(), endCall);
    _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

    _callKeep.setup(<String, dynamic>{
      'ios': {
        'appName': 'HHPatient',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      },
    });
    //end callkit
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void removeCall(String callUUID) {
    // setState(() {
      calls.remove(callUUID);
    // });
  }

  void setCallHeld(String callUUID, bool held) {
    // setState(() {
      calls[callUUID].held = held;
    // });
  }

  void setCallMuted(String callUUID, bool muted) {
    // setState(() {
      calls[callUUID].muted = muted;
    // });
  }

  Future<void> answerCall(CallKeepPerformAnswerCallAction event) async {
    
    final String callUUID = event.callUUID;
    final String number = calls[callUUID].number;
    
    print('[answerCall] $callUUID, number: $number');
    _callKeep.backToForeground();
    

    DBProvider.db.getAllClients().then((value) => {
      print("clientRes11" +value.identity),
      _callKeep.endAllCalls(),
      callConnected(value.programname, 'Accepted').then((value1) => {
        if(value1.responseCode=='200'){
          NavigationService.instance.navigateToRoute(MaterialPageRoute(
            builder: (context) => VideoCallPage(identity: value.identity??"", roomName: value.roomname??""),
          )),
        }
      })
    });
  }

  Future<void> endCall(CallKeepPerformEndCallAction event) async {
    print('endCall: ${event.callUUID}');
    //  DBProvider.db.getAllClients().then((value) => {
    //   print("clientRes11" +value.identity),
    //   callConnected(value.programname,'Rejected').then((value1) => {
    //     if(value1.responseCode=='200'){
    //       // NavigationService.instance.navigateToRoute(MaterialPageRoute(
    //       //   builder: (context) => VideoCallPage(identity: value.identity??"", roomName: value.roomname??"", token: value.token??""),
    //       // )),
    //     }
    //   })
    // });
    removeCall(event.callUUID);
  }

  Future<void> didPerformDTMFAction(CallKeepDidPerformDTMFAction event) async {
    print('[didPerformDTMFAction] ${event.callUUID}, digits: ${event.digits}');
  }

  Future<void> didReceiveStartCallAction(
      CallKeepDidReceiveStartCallAction event) async {
    if (event.handle == null) {
      // @TODO: sometime we receive `didReceiveStartCallAction` with handle` undefined`
      return;
    }
    final String callUUID = event.callUUID ?? newUUID();
    // setState(() {
    //   calls[callUUID] = Call(event.handle);
    // });
    print('[didReceiveStartCallAction] $callUUID, number: ${event.handle}');

    _callKeep.startCall(callUUID, event.handle, event.handle);

    Timer(const Duration(seconds: 1), () {
      print('[setCurrentCallActive] $callUUID, number: ${event.handle}');
      _callKeep.setCurrentCallActive(callUUID);
    });
  }

  Future<void> didPerformSetMutedCallAction(
      CallKeepDidPerformSetMutedCallAction event) async {
    final String number = calls[event.callUUID].number;
    print(
        '[didPerformSetMutedCallAction] ${event.callUUID}, number: $number (${event.muted})');

    setCallMuted(event.callUUID, event.muted);
  }

   Future<void> didToggleHoldCallAction(
      CallKeepDidToggleHoldAction event) async {
    final String number = calls[event.callUUID].number;
    print(
        '[didToggleHoldCallAction] ${event.callUUID}, number: $number (${event.hold})');

    setCallHeld(event.callUUID, event.hold);
  }

  Future<void> hangup(String callUUID) async {
    _callKeep.endCall(callUUID);
    removeCall(callUUID);
  }

  Future<void> setOnHold(String callUUID, bool held) async {
    _callKeep.setOnHold(callUUID, held);
    final String handle = calls[callUUID].number;
    print('[setOnHold: $held] $callUUID, number: $handle');
    setCallHeld(callUUID, held);
  }

  Future<void> setMutedCall(String callUUID, bool muted) async {
    _callKeep.setMutedCall(callUUID, muted);
    final String handle = calls[callUUID].number;
    print('[setMutedCall: $muted] $callUUID, number: $handle');
    setCallMuted(callUUID, muted);
  }

  Future<void> updateDisplay(String callUUID) async {
    final String number = calls[callUUID].number;
    // Workaround because Android doesn't display well displayName, se we have to switch ...
    if (isIOS) {
      _callKeep.updateDisplay(callUUID,
          displayName: 'New Name', handle: number);
    } else {
      _callKeep.updateDisplay(callUUID,
          displayName: number, handle: 'New Name');
    }

    print('[updateDisplay: $number] $callUUID');
  }

  Future<void> displayIncomingCallDelayed(String number) async {
    Timer(const Duration(seconds: 3), () {
      displayIncomingCall(number);
    });
  }

  Future<void> displayIncomingCall(String number) async {
    final String callUUID = newUUID();
    // setState(() {
      calls[callUUID] = Call(number);
    // });
    print('Display incoming call now');
    final bool hasPhoneAccount = await _callKeep.hasPhoneAccount();
    if (!hasPhoneAccount) {
      await _callKeep.hasDefaultPhoneAccount(context, <String, dynamic>{
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      });
    }

    print('[displayIncomingCall] $callUUID number: $number');
    _callKeep.displayIncomingCall(callUUID, number,
        handleType: 'number', hasVideo: false);
  }

  void didDisplayIncomingCall(CallKeepDidDisplayIncomingCall event) {
    var callUUID = event.callUUID;
    var number = event.handle;
    print('[displayIncomingCall] $callUUID number: $number');
    // setState(() {
    //   calls[callUUID] = Call(number);
    // });
  }

  void onPushKitToken(CallKeepPushKitToken event) {
    SetStringToSP("voipToken", event.token);
    print('[onPushKitToken] token => ${event.token}');
  }

  Future messageHandler(message) async {
    print("payloadType: "+message["type"].toString());

    var payload = message.containsKey('data') ? message["data"] : message;
    
    if(payload["type"].toString() == "incoming_call"){
      print("payloadType22: "+payload["type"].toString());
      Client rnd = Client(identity: payload["receiverId"]??"", programname: payload["senderId"]??"", roomname: payload["room"]??"", token:"");
      await DBProvider.db.newClient(rnd);
      Timer(Duration(seconds: 1), ()=>
      {
        displayIncomingCall(payload["name"]??"HHPatient"),
        Timer(Duration(seconds: 40),()=>{
          _callKeep.endAllCalls()
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: HH_Colors.color_171717,

            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                     
                      child: Column(
                        children: [
                          Flexible(
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(30.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(color: HH_Colors.color_white)
                                ),
                                child: Image.asset('assets/images/call-p.png', height: 60,width: 60,),
                              )
                            ),
                            flex: 4,
                          ),
                          HHTextView(
                            title: "Calling...",
                            color: HH_Colors.color_white,
                            size: 18,
                            textweight: FontWeight.w500,
                          )
                        
                        ],
                      )
                    ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                      width: 340,
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: new GestureDetector(
                          onTap: () {
                            incallManager.stopRingtone();
                            Navigator.pop(context, "Rejected");
                          },
                          child: Image.asset('assets/images/redCall.png', height: 80,width: 80,),
                        )
                      
                      )
                    )
                  ),
              ],
            )
        )
    );
  }


}
