import 'package:flutter/material.dart';
import 'package:flutter_app/api/Assessment_services.dart';
import 'package:flutter_app/model/SubmitAssessmentResponse.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter/scheduler.dart';


class AssessmentFormPage extends StatefulWidget {
  static const String RouteName = '/assessment_form';
  String id;

  AssessmentFormPage({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssessmentFormState();
}

class AssessmentFormState extends State<AssessmentFormPage> {
  Future<SubmitAssessmentResponse> apiCall;
  String title = '';

  @override
  void initState() {
    super.initState();
    // apiCall = getAssessments(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: 'Questionaire',
        child: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<SubmitAssessmentResponse>(
              future: getAssessments(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('No Data Found'),);
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Questionaire',
                        style: TextStyle(
                            fontSize: 22,
                            color: HH_Colors.accentColor,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.separated(
                            itemCount: snapshot.data.result.length,
                            itemBuilder: (context, index) {
                              return buildContainerForQuestionWithAnswer(index, snapshot.data.result[index]);
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          )),

                    ],
                  );


                } else
                  return Container(
                    child: Center(child: CircularProgressIndicator(),),
                  );
              }),
        ));
  }

  Column buildContainerForQuestionWithAnswer(int index, Result question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.questionText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 16,
                color: HH_Colors.grey_707070,
                fontFamily: "ProximaNova")),
        Text(question.options[0].answer,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 16,
                color: HH_Colors.grey_707070,
                fontWeight: FontWeight.w600,
                fontFamily: "ProximaNova"))
      ],
    );
  }


}

class AssessmentArguments {
  final String id;

  AssessmentArguments(this.id);
}
