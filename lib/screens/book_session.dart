import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/sessions.dart';
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
        TharapistCell(name: 'Abc', role: 'Abcd', showBook: false, onClick: (){},),
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