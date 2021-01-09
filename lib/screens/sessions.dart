import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';

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

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'My Sessions', child: Container(
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
              Flexible(child: HHButton(title: 'Upcoming ',textSize: 18.0, type: 3, isEnable: isSwitched, onClick: (){
                setState(() {
                  isSwitched = !isSwitched;
                });
              },), flex: 1,),
              Flexible(child: HHButton(title: 'Completed ',textSize: 18.0, type: 3, isEnable: !isSwitched,onClick: (){
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
    // if (text.isEmpty) {
    //   setState(() {searchText = "";});
    //   return;
    // }

    // .forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });

    setState(() {});
  }

  Widget getUpcomingList(){
    return FutureBuilder<UpcomingSession>(
        future: upcomingSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return HHTextView(title: "No Record Found",
                size: 18,
                color: HH_Colors.purpleColor,
                textweight: FontWeight.w600,);
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
                sdate: createdDt.format("dd MMM, yyyy")+' '+searchList[index].startTime,
                role: '', onClick: (){}, completed: !isSwitched,
                  onClickVideo: (){
                    getToken(snapshot.data.result[index].therapistId, snapshot.data.result[index].id);
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
            return HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
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

  void getToken(therapistId, sessionId) {
    String roomName = 'room_'+sessionId;
    getTwilioToken(roomName, therapistId).then(
            (value) => {

          print(value.responseCode),

          if (value.responseCode == "200") {
            Navigator.pushNamed(context, VideoCallPage.RouteName, arguments: VideoPageArgument(therapistId, roomName, value.jwt)),
          }
        });


  }

}

