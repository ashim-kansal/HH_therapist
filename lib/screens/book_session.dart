import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/schedule_widgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

class BookSessionPage extends StatefulWidget{

  static const String RouteName = '/schedule';

  @override
  State<StatefulWidget> createState() => BookSessionState();

}

class BookSessionState extends State<BookSessionPage>{

  @override
  Widget build(BuildContext context){
    return MyWidget(title: 'Schedule', child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
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
                    Text("Abc", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_35444D, fontFamily: "ProximaNova", fontWeight: FontWeight.w600),),
                  ]),
                  Row(children: [
                    Text("Role : Abcd", textAlign:TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070),),
                  ]),
                ],
              ) ,
            ],
          ),
        ),
        Container(height:50, child: SessionDateWidget()),
        SizedBox(height: 10,),
        Expanded(child: GridViewWidget(),),
        Container(
            child: HHButton(title: 'Save', type: 4, isEnable: true,onClick: (){
              Navigator.pushNamed(context, SessionPage.RouteName);
            },)
        )
      ],
    )
      // backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.

    );

  }
}