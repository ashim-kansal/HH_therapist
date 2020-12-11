import 'package:flutter/material.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/assessment_cell.dart';

class MyAssessmentPage extends StatefulWidget{
  static const String RouteName = '/assessments';

  final assessments = ['AUDIT (Alcohol Use Disorder Identification Test)', 'Michigan Alcohol Test', 'AUDIT (Alcohol Use Disorder Identification Test)', 'Michigan Alcohol Test', ];

  @override
  State<StatefulWidget> createState() =>MyAssessmentState();
}

class MyAssessmentState extends State<MyAssessmentPage>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
      itemCount: widget.assessments.length,
      itemBuilder: (context, index) {
        return AssessmentCell(name: widget.assessments[index], completed: index%2 == 0, onClick: (){
          Navigator.pushNamed(context, AssessmentFormPage.RouteName, arguments: ScreenArguments(
            widget.assessments[index],index%2 == 0
          ));
        },);

      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    ),);
  }
}
