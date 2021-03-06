import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget{

  var title= "";
  double sideMargin=20;
  Widget child;
  bool showFloatingButton = false;

  MyWidget({Key key, @required this.title, @required this.child, this.sideMargin, this.showFloatingButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(color: Colors.white)),
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
                padding: EdgeInsets.all(sideMargin != null ? sideMargin : 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    color: Colors.white),
                child: child

              // backgroundColor: Colors.white,
              // This trailing comma makes auto-formatting nicer for build methods.
            )),
        floatingActionButton: new Visibility(
          visible: showFloatingButton??false? true:false,
          child: new FloatingActionButton(child: new Icon(Icons.add),
          ),
    ),
    );

  }
}