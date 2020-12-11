import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class InputBoxQuestion extends StatefulWidget{
  var ques;
  TextEditingController controller;

  InputBoxQuestion({Key key, @required this.ques, this.controller});

  @override
  State<StatefulWidget> createState() =>InputBoxQuestionState();
}

class InputBoxQuestionState extends State<InputBoxQuestion>{

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children:[
          Text('Q. ', style: TextStyle(fontSize: 18, color: HH_Colors.accentColor, fontFamily: "ProximaNova", fontWeight: FontWeight.w500),),
          Flexible(child:Text(widget.ques, textAlign: TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070,  fontSize: 16))),

        ]),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width/3,
          height: 30,
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child:         TextField(
            minLines: 1,
            maxLines: 1,

            decoration: InputDecoration(
              border: normalOutlineInputBorder(),
            ),


          )
          ,
        ),
        SizedBox(height: 10,),
      ],
    );
  }

}
