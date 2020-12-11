import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/checkbox_widget.dart';
import 'package:flutter_app/widgets/inputquestion_widget.dart';

class AssessmentCell extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  final VoidCallback onClick;

  AssessmentCell(
      {@required this.name, @required this.role, this.completed, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(name, maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 18, color: HH_Colors.grey_585858)),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    child: Container(
                      width: 70,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: HH_Colors.accentColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: Text(
                        completed ? 'Log Now' : 'View',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: HH_Colors.accentColor),
                      ),
                    ),
                    onTap: () {
                      onClick();
                    },
                  )
                ],
              ),
              Text(
                completed ? 'Submitted' : 'Pending',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15,
                    color: completed
                        ? HH_Colors.green_3DDB8C
                        : HH_Colors.primaryColor),
              ),
            ],
          ),
        ));
  }
}

class AssessmentQuestionCell extends StatelessWidget {
  var title = "";
  int quesType;
  var completed = false;
  final VoidCallback onClick;

  AssessmentQuestionCell(
      {@required this.title,
      @required this.quesType,
      this.completed,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070)),
          quesType == 0
              ? getInputQuest()
              : quesType == 1
                  ? getSingleChoiceQuest()
                  : getSingleChoiceQuest(),
        ],
      ),
    );
  }

  Widget getInputQuest() {
    return InputBoxQuestion(ques: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry?');
  }

  Widget getSingleChoiceQuest() {
    return MySingleChoiceQuesWidget(ques: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry?',);
  }

  Widget getMultiChoiceQuest() {
    return CheckBoxQuestion(ques: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry?');
  }
}

class MySingleChoiceQuesWidget extends StatefulWidget {
  var ques;

  MySingleChoiceQuesWidget({@required this.ques});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MySingleChoiceQuesWidget> {
  var options = ['Yes', 'No'];
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    widget.ques ?? "";
  }
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }


  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children:[
            Text('Q. ', style: TextStyle(fontSize: 18, color: HH_Colors.accentColor, fontFamily: "ProximaNova", fontWeight: FontWeight.w500),),
            Flexible(child:Text(widget.ques, textAlign: TextAlign.start,style: TextStyle(color: HH_Colors.grey_707070,  fontSize: 16))),
          ]),
          ButtonBar(
            alignment: MainAxisAlignment.start,

            children: <Widget>[
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    activeColor: HH_Colors.accentColor,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val);
                    },
                  ),
                  Text('Yes')

                ],
              ),

              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    activeColor: HH_Colors.accentColor,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val);
                    },
                  ),
                  Text('No')
                ],
              )
            ],
          )
        ]);
  }

  getOptions(options, _site) {
    final children = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      children.add(getRadioOption(options[i], _site, () {}));
    }
    return children;
  }

  Widget getRadioOption(String title, String _site, String Function() param2) {
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: _site,
          onChanged: (String value) {},
          activeColor: HH_Colors.grey_707070,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
        ),
      ],
    );
  }
}
