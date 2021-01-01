import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/popup_window.dart';

class SessionCard extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  var drname = "";
  var sdate = "";
  final VoidCallback onClick;

  SessionCard(
      {@required this.name, @required this.role, this.completed, this.onClick, this.drname, this.sdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
        child: Card(
        elevation: 5,
            color: HH_Colors.color_F2EEEE,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: (){
            onClick();
          },
          child:  Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sdate, style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070),),
                    // Image.asset('assets/images/ic_option_menu.png', width: 20, height: 20,)
                    HHOptionButton(onClickCancel: (){}, onClickReSchedule: (){
                      Navigator.pushNamed(context, BookSessionPage.RouteName);
                    },)
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                    children: [Text(name ,textAlign:TextAlign.start,style: TextStyle(fontSize: 16, color: HH_Colors.grey_585858)),
                    ]),
                Row(
                    children: [Text('Dr. '+drname ,textAlign:TextAlign.start,style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070)),
                    ]),
                Row(
                  children: [
                    ButtonTheme(
                      height: 35,
                      minWidth: 35,
                      child: RaisedButton(

                        color: Colors.white,
                        child: Icon(Icons.chat
                          , color: HH_Colors.primaryColor, size: 18,),
                        onPressed: (){
                          // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                        },
                        shape: CircleBorder(                            side: BorderSide(color: HH_Colors.primaryColor)),
                      ),
                    ),

                    ButtonTheme(
                        height: 35,
                        minWidth: 35,
                        child: RaisedButton(

                            color: Colors.white,
                            child: Icon(Icons.video_call, color: HH_Colors.primaryColor,size: 18,),
                            onPressed: (){
                              // Navigator.pushNamed(context, ResetPasswordPage.RouteName);
                            },
                          shape: CircleBorder(                            side: BorderSide(color: HH_Colors.primaryColor)),
                        )),

                  ],
                )

              ],
            ),
          ),
        )
        ));
  }
}

class AssessmentQuestionCell extends StatelessWidget {
  var title = "";
  int quesType;
  var completed = false;
  final VoidCallback onClick;

  AssessmentQuestionCell({@required this.title,
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
              style:
              TextStyle(fontSize: 16, color: HH_Colors.grey_707070)),
          quesType == 0 ? getInputQuest() : quesType == 1
              ? getSingleChoiceQuest()
              : getMultiChoiceQuest(),
        ],
      ),
    );
  }

  Widget getInputQuest() {
    return Container();
  }

  Widget getSingleChoiceQuest() {
    return MySingleChoiceQuesWidget();
  }

  Widget getMultiChoiceQuest() {
    return Container();
  }
}

class MySingleChoiceQuesWidget extends StatefulWidget {

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MySingleChoiceQuesWidget> {
  var options= ['Yes', 'No'];

  Widget build(BuildContext context) {
    String _site = options[0];

    return Row(
      children: getOptions(options, _site),
    );
  }

  getOptions(options, _site) {
    final children = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      children.add(getRadioOption(options[i], _site, (){}));
    }
    return children;
  }
  Widget getRadioOption(String title, String _site, String Function() param2){
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: _site,
          onChanged: (String value) {

          },
          activeColor: HH_Colors.grey_707070,
        ),
        Text(title, style: TextStyle(fontSize: 16,color: HH_Colors.grey_707070),),

      ],
    );
  }

}

class UpcomingSessionItem extends StatelessWidget {
  var name = "";
  var role = "";
  var completed = false;
  var drname = "";
  var sdate = "";
  final VoidCallback onClick;
  final VoidCallback onClickCancel;

  UpcomingSessionItem(
      {@required this.name, @required this.role, this.completed, this.onClick, this.drname, this.sdate, this.onClickCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 10, 10, 10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(name, textAlign:TextAlign.start,style: TextStyle(fontSize: 16, color: HH_Colors.grey_585858),),
                      ]),
                      Row(children: [
                        Text(sdate, textAlign:TextAlign.start,style: TextStyle(fontSize: 15, color: HH_Colors.grey_707070),),
                      ]),
                    ],
                  ),

                  completed?
                      Row(
                        children: [
                          Icon(Icons.check_box, color: HH_Colors.color_17AB35,),
                          Text('Completed', style: TextStyle(color: HH_Colors.color_17AB35),)

                        ],
                      )
                      :
                  Row(
                    children: [
                      ButtonTheme(
                        height: 35,
                        minWidth: 35,
                        child: RaisedButton(
                          color: Colors.white,
                          child: Icon(Icons.chat, color: HH_Colors.primaryColor, size: 18,),
                          onPressed: (){
                            Navigator.pushNamed(context, ChatPage.RouteName);
                          },
                          shape: CircleBorder( side: BorderSide(color: HH_Colors.primaryColor, width: 1)),

                        ),
                      ),

                      ButtonTheme(
                          height: 35,
                          minWidth: 35,
                          child: RaisedButton(

                              color: Colors.white,
                              child: Icon(Icons.video_call, color: HH_Colors.primaryColor,size: 18,),
                              onPressed: (){
                                Navigator.pushNamed(context, ReviewPage.RouteName);
                              },
                            shape: CircleBorder(side: BorderSide(color: HH_Colors.primaryColor, width: 1)),
                          )),
                      HHOptionButton(onClickCancel: (){
                        onClickCancel();
                      },
                      onClickReSchedule: (){
                        Navigator.pushNamed(context, BookSessionPage.RouteName);
                      },)
                    ],
                  )
                ],

              ),


            )));
  }
}
