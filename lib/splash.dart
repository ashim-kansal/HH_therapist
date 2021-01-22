import 'dart:async';
import 'dart:io';

import 'package:flutter_app/utils/DBHelper.dart';
import 'package:flutter_app/utils/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:callkeep/callkeep.dart';
import 'package:flutter_app/services/navigation_service.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/DBHelper.dart';
import 'package:uuid/uuid.dart';

final FlutterCallkeep _callKeep = FlutterCallkeep();
bool _callKeepInited = false;

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('backgroundMessage: message => ${message.toString()}');
  var payload = message['data'];
  var callerId = payload['caller_id'] as String;
  var callerNmae = payload['caller_name'] as String;
  var uuid = payload['uuid'] as String;
  var hasVideo = payload['has_video'] == "true";

  final callUUID = uuid ?? Uuid().v4();
  _callKeep.on(CallKeepPerformAnswerCallAction(),
      (CallKeepPerformAnswerCallAction event) {
    print(
        'backgroundMessage: CallKeepPerformAnswerCallAction ${event.callUUID}');
    _callKeep.startCall(event.callUUID, callerId, callerNmae);

    Timer(const Duration(seconds: 1), () {
      print(
          '[setCurrentCallActive] $callUUID, callerId: $callerId, callerName: $callerNmae');
      _callKeep.setCurrentCallActive(callUUID);
    });
    //_callKeep.endCall(event.callUUID);
  });

  _callKeep.on(CallKeepPerformEndCallAction(),
      (CallKeepPerformEndCallAction event) {
    print('backgroundMessage: CallKeepPerformEndCallAction ${event.callUUID}');
  });
  if (!_callKeepInited) {
    _callKeep.setup(<String, dynamic>{
      'ios': {
        'appName': 'HHTherapist',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      },
    });
    _callKeepInited = true;
  }

  print('backgroundMessage: displayIncomingCall ($callerId)');
  _callKeep.displayIncomingCall(callUUID, callerId,
      localizedCallerName: callerNmae, hasVideo: hasVideo);
  _callKeep.backToForeground();
  return null;
}

class Call {
  Call(this.number);
  String number;
  bool held = false;
  bool muted = false;
}

class Splash extends StatefulWidget{

  static const String RouteName = '/';

  @override
  State<StatefulWidget> createState() =>SplashState();
}

class SplashState extends State<Splash>{


  String data = "";
  String nameKey = "_key_name";
  String token;

  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final FlutterCallkeep _callKeep = FlutterCallkeep();
  Map<String, Call> calls = {};
  String newUUID() => Uuid().v4();

  _register() {
    _firebaseMessaging.getToken().then((fcmtoken) => {
      SetStringToSP("deviceToken", fcmtoken),
      print(fcmtoken)
    });
  }


  getToken() async{
    var userToken = await GetStringToSP("token");

    setState(() {
      token = userToken;
    });
    token = userToken;
    print(userToken);
  }

  @override
  void initState() {
    super.initState();

    _callKeep.on(CallKeepDidDisplayIncomingCall(), didDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), answerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), didPerformDTMFAction);
    _callKeep.on(CallKeepDidReceiveStartCallAction(), didReceiveStartCallAction);
    _callKeep.on(CallKeepDidToggleHoldAction(), didToggleHoldCallAction);
    _callKeep.on(CallKeepDidPerformSetMutedCallAction(), didPerformSetMutedCallAction);
    _callKeep.on(CallKeepPerformEndCallAction(), endCall);
    _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

    _callKeep.setup(<String, dynamic>{
      'ios': {
        'appName': 'HHTherapist',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
            'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
      },
    });

    getToken();
    _register();
    getMessage();

    const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler(
      (MethodCall methodcall) async {
        if (methodcall.method == 'getAll') {
          return {"flutter." + nameKey: "[ No Name Saved ]"};
        }
        return null;
      },
    );

    checkIfUserLoggedIn();
  }

  void removeCall(String callUUID) {
    try {
      if(mounted)
      setState(() {
        calls.remove(callUUID);
      });
    }catch(e){

    }
  }

  void setCallHeld(String callUUID, bool held) {
    setState(() {
      calls[callUUID].held = held;
    });
  }

  void setCallMuted(String callUUID, bool muted) {
    setState(() {
      calls[callUUID].muted = muted;
    });
  }

  Future<void> answerCall(CallKeepPerformAnswerCallAction event) async {
    final String callUUID = event.callUUID;
    final String number = calls[callUUID].number;
    print('[answerCall] $callUUID, number: $number');
    _callKeep.backToForeground();
    _callKeep.endAllCalls();


    DBProvider.db.getAllClients().then((value) => {
      print("clientRes11" +value.identity),
      callConnected(value.programname,'Accepted').then((value1) => {
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
    DBProvider.db.getAllClients().then((value) => {
      print("clientRes11" +value.identity),
      callConnected(value.programname,'Rejected').then((value1) => {
        if(value1.responseCode=='200'){
          // NavigationService.instance.navigateToRoute(MaterialPageRoute(
          //   builder: (context) => VideoCallPage(identity: value.identity??"", roomName: value.roomname??"", token: value.token??""),
          // )),
        }
      })


    });
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
    setState(() {
      calls[callUUID] = Call(event.handle);
    });
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
    setState(() {
      calls[callUUID] = Call(number);
    });
  }

  void onPushKitToken(CallKeepPushKitToken event) {
    SetStringToSP("voipToken", event.token);
    print('[onPushKitToken] token => ${event.token}');
  }


  void getMessage(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on receive N message $message');

        if(Platform.isAndroid){
          print(message["data"]["type"]);
          if(message["data"]["type"].toString() == "incoming_call"){
            Client rnd = Client(identity: message["data"]["receiverId"], programname: message["data"]["senderId"]??"", roomname: message["data"]["room"], token: message["data"]["AccessToken"]??"");
            await DBProvider.db.newClient(rnd);
            Timer(Duration(seconds: 1),
                    ()=>{
                  displayIncomingCall(message["data"]["name"]),
                      Timer(Duration(seconds: 30),()=>{
                    _callKeep.endAllCalls()
                    })
                });
          }else if(message["data"]["type"].toString() == "call_status"){
          }
        }else{
          print(message["type"]);
          if(message["type"].toString() == "incoming_call"){
            Client rnd = Client(identity: message["receiverId"], programname: message["programName"], roomname: message["room"], token: message["AccessToken"]);
            await DBProvider.db.newClient(rnd);
            Timer(Duration(seconds: 1),
                    ()=>{
                  displayIncomingCall(message["name"]),
                      Timer(Duration(seconds: 30),()=>{
                        _callKeep.endAllCalls()
                      })
                });
          }else if(message["type"].toString() == "call_status"){
          }
        }

        // setState(() => _message = message["notification"]["title"]);
      }, onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        if(message["type"].toString() == "incoming_call"){
          Client rnd = Client(identity: message["receiverId"], programname: message["programName"], roomname: message["room"], token: message["AccessToken"]);
          await DBProvider.db.newClient(rnd);
          Timer(Duration(seconds: 1),
          ()=>{
            displayIncomingCall(message["type"]['name'])
          });
        }
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        if(message["type"].toString() == "incoming_call"){
          Client rnd = Client(identity: message["receiverId"], programname: message["programName"], roomname: message["room"], token: message["AccessToken"]);
          await DBProvider.db.newClient(rnd);
          Timer(Duration(seconds: 1),
          ()=>{
            displayIncomingCall(message["type"]['name'])
          });
        }
        // setState(() => _message = message["notification"]["title"]);
      }
    );
  }

  void navigateH() async {
    var sessionObj = await GetStringToSP("sMsg");
    print('object in msg $sessionObj');

    DBProvider.db.getAllClients().then((value) => {
      print("clientRes11" +value.identity),
      // print("clientRes" +storageRes.toString()),

      NavigationService.instance.navigateToRoute(MaterialPageRoute(
        builder: (context) => VideoCallPage(identity: value.identity, roomName: value.roomname, token: value.token),
      )),
    });
  }

  void checkIfUserLoggedIn() async {
  
     Timer(Duration(seconds: 4),
      ()=>{
            Navigator.pop(context),
            if (token != null) {
              Navigator.pushNamed(context, Dashboard.RouteName)
            }else{
              Navigator.pushNamed(context, SelectLanguage.RouteName)
            },
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        color: Color(0xff777CEA),
        child: Center(
          child: Image.asset('assets/images/ic_appicon_white.png',
          height: 100,
          width: 150,
        ),
        )
        

    );
  }
}


class CallStatus {
  CallStatusData status;
  CallStatus(this.status);
}

class CallStatusData {
  String status;
  CallStatusData(this.status);
}





