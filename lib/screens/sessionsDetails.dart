import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/linechart.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';

class SessionDetails extends StatefulWidget{
  static const String RouteName = '/sessionsDetails';
  final assessments = ['abc', 'def', 'ghi' ];

  @override
  State<StatefulWidget> createState() =>SessionPageState();
}

class SessionPageState extends State<SessionDetails>{
  bool isSwitched = true;
  bool isAssesments = false;
  bool isDiary = false;
  bool isJournling = false;

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Session Details', child: Container(
      child: SingleChildScrollView(
        child: 
        Column(
        children: [
        // Card(
        //   elevation: 10,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   child: 
          Container(
            padding: EdgeInsets.fromLTRB(20, 40,20,20),
            child: Column(
              children: [
                Container(
                  child: Column(children: [
                    HHHomeButton(title: 'Assesment', type: 2, onClick: (){
                      setState(() {
                        isAssesments = !isAssesments;
                      });
                    }, bColor: HH_Colors.orange_FF8A73, arrowContainerColor: HH_Colors.light_FBB7A9),
                    isAssesments == true ?
                      Container(
                        color: HH_Colors.color_FBF4F4,
                        height: MediaQuery.of(context).size.height / 3.7,
                        child: Column(children: [
                          Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                          child: AssesmentItem(title: "Michigan Alcohol Test", value: "17/20", subTitle: "Total Obtained Marks")),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: AssesmentItem(title: "Michigan Alcohol Test", value: "17/20", subTitle: "Total Obtained Marks")),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: AssesmentItem(title: "Michigan Alcohol Test", value: "17/20", subTitle: "Total Obtained Marks")),
                        ],),
                      ) : Container()
                  ],),
                ),
                SizedBox(height: 15),
                Container(
                  child: Column(children: [
                    HHHomeButton(title: 'Drinking Diary', type: 2, onClick: (){
                      setState(() {
                        isDiary = !isDiary;
                      });
                    }, bColor: HH_Colors.orange_FF8A73, arrowContainerColor: HH_Colors.light_FBB7A9),
                    isDiary == true ?
                      Container(
                        color: HH_Colors.color_FBF4F4,
                        // height: MediaQuery.of(context).size.height / 3.7,
                        child: Column( children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: HH_Colors.primaryColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
                            ),
                            padding: EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                                Text('20th Oct to 14th Nov', style: TextStyle(color: Colors.white),),
                                Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                                SizedBox(width: 10,),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                              color: HH_Colors.color_F2EEEE,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight : Radius.circular(5.0))
                            ),
                            padding: EdgeInsets.fromLTRB(15,10,15,10),
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CalenderCell(date: '12', day: 'Mon',),
                                  CalenderCell(date: '13', day: 'Tue',),
                                  CalenderCell(date: '14', day: 'Wed',),
                                  CalenderCell(date: '15', day: 'Thu',),
                                  CalenderCell(date: '16', day: 'Fri',),
                                  CalenderCell(date: '17', day: 'Sat',),
                                  CalenderCell(date: '18', day: 'Sun',),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height/3,
                              child: SimpleLineChart.withSampleData(),
                            )

                          ),
                        ]
                        )
                      ) : Container()
                  ],),
                ),
                SizedBox(height: 15),
                 Container(
                  child: Column(children: [
                    HHHomeButton(title: 'Daily Journaling', type: 2, onClick: (){
                      setState(() {
                        isJournling = !isJournling;
                      });
                    }, bColor: HH_Colors.orange_FF8A73, arrowContainerColor: HH_Colors.light_FBB7A9),
                    isJournling == true ?
                      Container(
                        color: HH_Colors.color_FBF4F4,
                        // height: MediaQuery.of(context).size.height / 3.7,
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffEDEDF8),
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight:  Radius.circular(8.0)),
                                color: Color(0xffCBCEFC),
                              ),
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: Stack(children: [ 
                                    Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child:  HHTextView(color: HH_Colors.color_white,
                                      title: "14/11/2020",
                                      size: 16),
                                    ),

                                    Positioned(child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(icon: Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 32,
                                        color: HH_Colors.color_white,
                                      ), onPressed: () {  },),
                                    ))

                                  ],)
                                )
                                
                              ],)
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 10),
                              child: HHTextView(
                                title: "Lorem Ipsum is simply dummy text of the the printing and typesetting industry.",
                                size: 16,
                                color: HH_Colors.color_707070,),
                            )
                          ],),
                        ),
                      ) : Container()
                  ],),
                ),
              ],
            ),
          ),
        // ),
        // SizedBox(height: 30,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('Upcoming Sessions for Today', style: TextStyle(fontSize: 22, color: HH_Colors.grey_3d3d3d),),
        //     // Text('View All', style: TextStyle(color: HH_Colors.accentColor, fontSize: 15, ),),
        //   ],
        // ),
        // SizedBox(height: 15,),
        Container(
          padding: EdgeInsets.fromLTRB(20,0,20,20),
          // margin: EdgeInsets.only(bottom: 20),
          child: Row(children: [
            AddFileCard(title: "Add Prescription", size: 22, color: HH_Colors),
            AddFileCard(title: "Add Prescription", size: 22, color: HH_Colors),
          ],)
        ),
        
        Container(
          padding: EdgeInsets.fromLTRB(20,0,20,40),
          // margin: EdgeInsets.only(bottom: 20),
          child: HHEditText(
            hint: "Write Notes",
            minLines: 4,
          ),  
        ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: HHButton(
                isEnable: true,
                title: "Submit",
                type: 4,
                onClick: () {
                    Navigator.pop(context);
                },
              ),
            ),
          )
      ],
      ),)
    ),
    );
  }
}

