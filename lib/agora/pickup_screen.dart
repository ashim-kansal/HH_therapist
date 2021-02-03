
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/agora/permissions.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'cached_image.dart';
import 'call.dart';
import 'call_methods.dart';
import 'call_screen.dart';

class PickupScreen extends StatefulWidget {
  final Call call;
  final String myId;

  PickupScreen({
    @required this.call,
    @required this.myId,
  });

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final CallMethods callMethods = CallMethods();
  // final LogRepository logRepository = LogRepository(isHive: true);
  // final LogRepository logRepository = LogRepository(isHive: false);

  bool isCallMissed = true;


  @override
  void dispose() {
    FlutterRingtonePlayer.stop();
    super.dispose();
  }

  @override
  void initState() {

    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.bell,
      looping: true, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(flex: 1,),

            Column(
              children: [
                Text("Incoming",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.blue),),
             //   Text("00:00",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue),)

              ],
            ),
            Spacer(flex: 15,),
            Container(child: 
              getImageView(widget.call.callerPic)??"",
              margin: EdgeInsets.symmetric(horizontal: 40),),
            Spacer(flex: 8,),
            Text(widget.call.callerName,style: TextStyle(fontSize: 25,color: Colors.blue),),
            Spacer(flex: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 25),
                Expanded(
                  child: GestureDetector(
                      child: Image.asset("assets/accept.png"),
                      onTap: ()  {
                        FlutterRingtonePlayer.stop();
                        // await Permissions.cameraAndMicrophonePermissionsGranted()
                        //     ?
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CallScreen(call: widget.call, myId: widget.myId,),
                          ),
                        ).then((value) =>{
                            Navigator.pushNamed(context, ReviewPage.RouteName, arguments: ReviewPageArgument(widget.call.sessionid, widget.call.programName))
                          });
                            // : {};
                      }),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: GestureDetector(
                      child: Image.asset("assets/decline.png"),
                      onTap: () async {
                        isCallMissed = false;
                        FlutterRingtonePlayer.stop();
                        await callMethods.endCall(call: widget.call);
                      },),
                ),
                SizedBox(width: 25),


              ],
            ),
            Spacer(flex: 8,),

          ],
        ),
      ),
    );
  }

  //
  getImageView(String callerPic) {
    if(callerPic?.isEmpty) {
      return Image.asset('assets/doctor_image.png');
    } else {
      return CircleAvatar(
                radius: 55,
                backgroundColor: HH_Colors.color_F2EEEE,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.call.callerPic) ,
                  radius: 52,
                ),
              );
    }
  }

}
