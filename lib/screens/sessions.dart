import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
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
            child: TextField(decoration: InputDecoration(
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

  Widget getUpcomingList(){
    return FutureBuilder<UpcomingSession>(
        future: upcomingSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
            }
            return ListView.separated(
              itemCount: snapshot.data.result.length,
              itemBuilder: (context, index){
              var _date = snapshot.data.result[index].createdAt;
              Moment createdDt = Moment.parse('$_date');
              return UpcomingSessionItem(
                name: snapshot.data.result[index].programName, 
                id: snapshot.data.result[index].id,
                therapistId: snapshot.data.result[index].therapistId,
                drname: snapshot.data.result[index].patientId.firstName+" "+snapshot.data.result[index].patientId.lastName,
                sdate: createdDt.format("dd MMM, yyyy")+' '+snapshot.data.result[index].startTime,
                role: '', onClick: (){}, completed: !isSwitched,
                patientId: snapshot.data.result[index].patientId.id,
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
          return ListView.separated(
            itemCount: snapshot.data.result.length,
            itemBuilder: (context, index){
            var _date = snapshot.data.result[index].createdAt;
            Moment createdDt = Moment.parse('$_date');
            return UpcomingSessionItem(
              name: snapshot.data.result[index].programName,
              id: snapshot.data.result[index].id,
              therapistId: snapshot.data.result[index].therapistId,
              drname: snapshot.data.result[index].patientId.firstName+" "+snapshot.data.result[index].patientId.lastName,
              sdate: createdDt.format("dd MMM, yyyy hh:mm a"),
              patientId: snapshot.data.result[index].patientId.id,
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

}

