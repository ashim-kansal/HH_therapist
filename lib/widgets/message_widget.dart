import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class MessageWidget extends StatefulWidget {

  var msg;
  var direction;
  var dateTime;

  MessageWidget({this.msg, this.direction, this.dateTime});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: widget.direction == 'left'
          ? new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Image.asset(
                'assets/images/in.png',
                fit: BoxFit.scaleDown,
                width: 30.0,
                height: 30.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      //for left corner

                     new Container(
                        margin: EdgeInsets.only(left: 6.0),
                        decoration: new BoxDecoration(
                          color: Color(0x2b2b2b2e),
                          border: new Border.all(
                              color: Color(0x2b2b2b2e),
                              width: .25,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          widget.msg,
                          style: new TextStyle(
                            fontFamily: 'Gamja Flower',
                            fontSize: 13.0,
                            color: Color(0xffffffff),
                          ),
                        ),
                        width: 180.0,
                      ),
                    ],
                  ),

                  //date time
                  new Container(
                    margin: EdgeInsets.only(left: 6.0),
                    decoration: new BoxDecoration(
                      color: Color(0x2b2b2b2e),
                      border: new Border.all(
                          color: Color(0x2b2b2b2e),
                          width: .25,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        topLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: new Text(
                      widget.dateTime,
                      style: new TextStyle(
                        fontSize: 8.0,
                        color: Color(0xffffffff),
                      ),
                    ),
                    width: 180.0,
                  ),
                ],
              ),
            ],
          )
      )
          : new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  //for right corner

                  new Container(
                    margin: EdgeInsets.only(right: 6.0),
                    decoration: new BoxDecoration(
                      color: HH_Colors.accentColor,
                      border: new Border.all(
                          color: HH_Colors.accentColor,
                          width: .25,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      widget.msg,
                      style: new TextStyle(
                        fontFamily: 'Gamja Flower',
                        fontSize: 20.0,
                        color: Color(0xffffffff),
                      ),
                    ),
                    width: 180.0,
                  ),
                ],
              ),

              //date time
              new Container(
                margin: EdgeInsets.only(right: 6.0),
                decoration: new BoxDecoration(
                  color: HH_Colors.accentColor,
                  border: new Border.all(
                      color: HH_Colors.accentColor,
                      width: .25,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0.0),
                    topLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                ),
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                child: new Text(
                  widget.dateTime,
                  style: new TextStyle(
                    fontSize: 8.0,
                    color: Color(0xffffffff),
                  ),
                ),
                width: 180.0,
              ),
            ],
          ),


        ],
      ),
    );
  }
}