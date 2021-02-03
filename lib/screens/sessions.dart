import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
// import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_app/agora/call_utilities.dart';
import 'package:flutter_app/agora/permissions.dart';

class SessionPage extends StatefulWidget{
  static const String RouteName = '/mysessions';

  @override
  State<StatefulWidget> createState() =>SessionPageState();


}

class SessionPageState extends State<SessionPage>{
  bool isSwitched = true;
  String searchText = "";

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  String name = '';
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() {

    UserAPIServices().getProfile().then((value) => {
      if (value.responseCode == 200) {
        setState(() {
          name = value.result.firstName+" "+value.result.lastName;
          profileImage = value.result.profilePic;
        })
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MyWidget(title: AppLocalizations.of(context).mysession, child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            child: TextField(
              onChanged: onSearchTextChanged,

              decoration: InputDecoration(
              hintText: 'Search',
              contentPadding: EdgeInsets.all(10),

            ),),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: HHButton(title: AppLocalizations.of(context).Upcoming,textSize: 18.0, type: 3, isEnable: isSwitched, onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              Flexible(child: HHButton(title: AppLocalizations.of(context).Completed,textSize: 18.0, type: 3, isEnable: !isSwitched,onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              // HHButton(title: 'Completed Sessions', type: 2)
            ],
          ),
          SizedBox(height: 20,),

          Expanded(
            child: isSwitched ? getUpcomingList() : getCompleteList()
          )


        ],
      ),
    ),
    );
  }
  onSearchTextChanged(String text) async {
    searchText = text;
    setState(() {});
  }

  Widget getUpcomingList(){
    return FutureBuilder<UpcomingSession>(
        future: upcomingSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return HHTextView(title: AppLocalizations.of(context).no_record_found,
                size: 18,
                color: HH_Colors.purpleColor,
                textweight: FontWeight.w600,);
            }
            print('hhhhhhhhhhhhhhhhhhhhhhhhhh'+snapshot.data.result.length.toString());

            List<Result> mList = snapshot.data.result;
            List<Result> searchList = List();

            if (searchText.length == 0){
              searchList.clear();
              searchList.addAll(mList);
            }else {
              searchList.clear();
              for (Result res in mList) {
                if (res.patientId.firstName.toLowerCase().contains(searchText.toLowerCase()))
                  searchList.add(res);
              }
            }
            print(searchList.length.toString());
            return ListView.separated(
              itemCount: searchList.length,
              itemBuilder: (context, index){
              var _date = searchList[index].createdAt;
              Moment createdDt = Moment.parse('$_date');
              return UpcomingSessionItem(
                name: searchList[index].programName,
                data: searchList[index],
                drname: searchList[index].patientId.firstName+" "+searchList[index].patientId.lastName,
                sdate: createdDt.format("dd MMM, yyyy")+' '+searchList[index].startTime,
                role: '', onClick: (){}, completed: !isSwitched,
                  onClickVideo: (){
                    callParticipent(snapshot.data.result[index].id, snapshot.data.result[index].patientId.id, snapshot.data.result[index]);
                  },
                onClickCancel: () {
                  setState(() {

                  });
                },);
            },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: isSwitched? 5: 2
                );
          } else
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
        }
      );

  }

  Widget getCompleteList(){
    return FutureBuilder<UpcomingSession>(
      future: completedSessoins(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return HHTextView(title: AppLocalizations.of(context).no_record_found, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
          }
          List<Result> mList = snapshot.data.result;
          List<Result> searchList = List();

          if (searchText.length == 0){
            searchList.clear();
            searchList.addAll(mList);
          }else {
            searchList.clear();
            for (Result res in mList) {
              if (res.patientId.firstName.toLowerCase().contains(searchText.toLowerCase()))
                searchList.add(res);
            }
          }
          return ListView.separated(
            itemCount: searchList.length,
            itemBuilder: (context, index){
            var _date = searchList[index].createdAt;
            Moment createdDt = Moment.parse('$_date');
            return UpcomingSessionItem(
              name: searchList[index].programName,
              data: searchList[index],
              drname: searchList[index].patientId.firstName+" "+searchList[index].patientId.lastName,
              sdate: createdDt.format("dd MMM, yyyy hh:mm a"),
              role: '', onClick: (){}, completed: !isSwitched,);
          },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: isSwitched? 5: 2
              );
        } else
          return Container(
            child: Center(child: CircularProgressIndicator(),),
          );
      });
  }


  void callParticipent(String sessionId, String patientId, Result result) {

    Permissions.cameraAndMicrophonePermissionsGranted().then((value) => {
      CallUtils.dial(
          from: result.therapistId,
          to: result.patientId.id,
          fromName: name,
          toName: result.patientId.firstName+' '+result.patientId.lastName,
          image: profileImage,
          toImage: result.patientId.profilePic,
          context: context,
          isVideo: true,
          sessionid: result.id,
          programName: result.programName),
      FirebaseFirestore.instance
          .collection("users")
          // ignore: deprecated_member_use
          .document(result.patientId.id)
          .snapshots()
          .forEach((element) async {
        if (element.data() != null) {
          String deviceId = element.data()["token"];

          FirebaseFirestore.instance.collection("notifications").add({
            "sendby": result.therapistId,
            "message": 'VIDEO Calling',
            "deviceid": deviceId,
          });
        }
      })
    });
  }


}

