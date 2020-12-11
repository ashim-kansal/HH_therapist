import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class FruitsList {
  String name;
  int index;
  FruitsList({this.name, this.index});
}

class RadioGroupWidget extends State {



  // Default Radio Button Item
  String radioItem = 'Yes';
  int _radioValue1 = -1;

  // Group Value for Radio Button.
  int id = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Yes",
    ),
    FruitsList(
      index: 2,
      name: "No",
    )
  ];

  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            new Radio(
              value: 0,
              groupValue: _radioValue1,
            ),
            new Text(
              'Yes',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValue1,
            ),
            new Text(
              'No',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ]
            // fList.map((data) => Radio(
            //   // title: Text("${data.name}"),
            //   groupValue: id,
            //   value: data.index,
            //   onChanged: (val) {
            //     setState(() {
            //       radioItem = data.name ;
            //       id = data.index;
            //     });
            //   },
            // )).toList(),

        )
    );
  }
}
