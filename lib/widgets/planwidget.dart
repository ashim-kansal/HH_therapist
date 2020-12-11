import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';

class PlanWidget extends StatefulWidget {

  String title;
  String program_type;
  var price = 0;
  String desc;

  final VoidCallback onClick;

  PlanWidget({ Key key, @required this.title,@required  this.program_type,@required  this.desc,@required  this.price, this.onClick}): super(key: key);


  @override
  PlanWidgetState createState() => PlanWidgetState();
}

class PlanWidgetState extends State<PlanWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),

      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme
                .of(context)
                .accentColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title,
                style: TextStyle(color: Colors.white, fontSize: 22),),
              SizedBox.fromSize(size: Size(8, 8),),

              Text(widget.program_type, textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 15),),
              SizedBox.fromSize(size: Size(8, 8),),

              Text(widget.price.toString(), textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 44),),
              SizedBox.fromSize(size: Size(8, 8),),

              Text(widget.desc, textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 16),),
              SizedBox.fromSize(size: Size(8, 20),),

              RaisedButton(
                  child: Text( widget.price <= 0 ? 'Free':'Buy Now', style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    widget.onClick();
                  },
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.fromLTRB(40, 20,40,20),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
              )

            ],
          ),
        ),
      ),
    );
  }
}