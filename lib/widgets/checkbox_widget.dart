import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class CheckBoxQuestion extends StatefulWidget{
  var ques;
  var options;
  Map<String, bool> option = {
    'One' : false,
    // 'Two' : false,
    // 'Three' : false,
  };

  CheckBoxQuestion({Key key, @required this.ques, this.options});

  @override
  State<StatefulWidget> createState() =>CheckBoxQuestionState();
}

class CheckBoxQuestionState extends State<CheckBoxQuestion>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Q. ',
            style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: HH_Colors.accentColor, fontFamily: "ProximaNova", fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(text: widget.ques, style: TextStyle(color: HH_Colors.grey_707070,  fontSize: 16, fontFamily: "ProximaNova")),
            ],
          ),
        ),
        Expanded(child:
        ListView(
          scrollDirection: Axis.horizontal,
          children: widget.option.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: widget.option[key],
              onChanged: (bool value) {
                setState(() {
                  widget.option[key] = value;
                });
              },
            );
          }).toList(),
        ))
      ],
    );
  }

}
