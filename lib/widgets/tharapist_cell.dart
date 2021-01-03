import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/Notes.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/utils/colors.dart';

class TharapistCell extends StatelessWidget {
  var name = "";
  var role = "";
  var showBook = false;
  var patientid= "";
  final VoidCallback onClick;

  TharapistCell({@required this.name, @required this.role, this.showBook, this.onClick, this.patientid});


  @override
  Widget build(BuildContext context) {
    return               Container(
      padding: EdgeInsets.all(10),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/ic_avatar.png',
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text("$name", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_35444D, fontFamily: "ProximaNova", fontWeight: FontWeight.w600),),
                  ]),
                  Row(children: [
                    Text("Role : $role", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070),),
                  ]),
                  ],
               ) ,
            ],
          ),

          showBook?
          InkWell(
            child: Container(
            // margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: HH_Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Text('Book Session', style: TextStyle(color: HH_Colors.accentColor),),
          ) ,
          onTap: (){
            onClick();
          },): Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NotesPage.RouteName, arguments: NotesArguments(patientid));
                },
                child: Image.asset('assets/images/ic_file.png',
                    width: 25.0, height: 25.0),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                    Navigator.pushNamed(context, AssessmentFormPage.RouteName, arguments: ScreenArguments('Michigan alcohol Test', false));
                },
                child: Image.asset('assets/images/ic_unknown.png',
                    width: 25.0, height: 25.0),
              )
              
            ],
          )
        ],
      ),
    );
  }
}

class ChatUserCell extends StatelessWidget {
  var name = "";
  var online = false;
  var message = "";
  var profile = "";
  var time = "";
  final VoidCallback onClick;

  ChatUserCell({@required this.name, @required this.online, this.onClick, this.message,this.profile, this.time});


  @override
  Widget build(BuildContext context) {
    return
        InkWell(
          onTap: (){
            onClick();
          },
          child:Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: HH_Colors.color_D9D9D9),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: HH_Colors.color_F2EEEE,
            ),
            padding: EdgeInsets.all(10),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        profile,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    
                    // Image.asset(
                    //   'assets/images/ic_avatar.png',
                    //   height: 50,
                    //   width: 50,
                    // ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(children: [
                          Text(name, textAlign:TextAlign.start,style: TextStyle(fontSize:20,color: HH_Colors.grey_585858),),
                        ]),
                        Row(children: [
                          Text(message, textAlign:TextAlign.start,style: TextStyle(fontSize:15, color: HH_Colors.grey_707070),),
                        ]),
                      ],
                    ) ,
                  ],
                ),
                Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.topRight,
                  child: Text(time, textAlign: TextAlign.start ,style: TextStyle(color: HH_Colors.accentColor, fontSize: 11),),
                  )
                )
              ],
            ),
          ),
        );
  }
}

