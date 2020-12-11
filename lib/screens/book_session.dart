import 'package:flutter/material.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Schedule', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body: Material(
            color: Theme.of(context).accentColor,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  TharapistCell(name: 'Abc', role: 'Abcd', showBook: false, onClick: (){},),
                  Expanded(child: SessionDateWidget()),
                  Expanded(child: GridViewWidget(),)
                ],
              )
              // backgroundColor: Colors.white,
              // This trailing comma makes auto-formatting nicer for build methods.
            )));

  }
}