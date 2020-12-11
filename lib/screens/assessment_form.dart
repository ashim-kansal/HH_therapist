import 'package:flutter/material.dart';
import 'package:flutter_app/models/AssessmentModel.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class AssessmentFormPage extends StatefulWidget {
  static const String RouteName = '/assessment_form';

  var title;


  var enable = false;

  AssessmentFormPage({
    Key key,
    @required this.title, this.enable
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssessmentFormState();
}

class AssessmentFormState extends State<AssessmentFormPage> {
  var data = [
    AssessmentModel(title: 'a', quesType: 0),
    AssessmentModel(title: 'b', quesType: 1),
    AssessmentModel(title: 'c', quesType: 2),
    AssessmentModel(title: 'c', quesType: 2),
    AssessmentModel(title: 'c', quesType: 2),
    AssessmentModel(title: 'c', quesType: 2),
    AssessmentModel(title: 'c', quesType: 2),
    AssessmentModel(title: 'c', quesType: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: 'Questionaire',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 22, color: HH_Colors.accentColor),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return MySingleChoiceQuesWidget(ques:'Do you feel you are a normal drinker?');
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            )),
            SizedBox(height: 10,),
            widget.enable? HHButton(title: 'Submit', type: 2,isEnable: true, onClick: () {

            }): Container(),
          ],
        ));
  }
}

class ScreenArguments {
  final String title;
  final bool completed;

  ScreenArguments(this.title, this.completed);
}
