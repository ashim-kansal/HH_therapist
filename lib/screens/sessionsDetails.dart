import 'dart:async';
import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/GetDrinkingDiaryList.dart' as Diary;
import 'package:flutter_app/model/JournalList.dart';
import 'package:flutter_app/model/PatientAssesmentList.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart' as SessionModal;
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyGraphWidget.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/journalWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/utils/DateTimeUtils.dart';
import 'package:flutter_app/widgets/MyExpansionTile.dart';



class SessionDetails extends StatefulWidget{
  static const String RouteName = '/sessionsDetails';

  SessionModal.Result session;
  String patientId;

  SessionDetails({Key key, this.session, this.patientId}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>SessionPageState();
}

class SessionPageState extends State<SessionDetails>{
  bool isSwitched = true;
  bool isAssesments = false;
  bool isDiary = false;
  bool isJournling = false;
  List<Diary.Result> graphData;
  String label = '';
  var prescriptionPath;
  String prescriptionName;
  String handoutPath;
  String handoutName;
  Future assesmentList;
  Future journalList;
  Future drinkingDiaryList;
  int pos = 0;
  var mDiaryList;
  var journalListItems;
  var assesmentListItems;
  var jounal1;

  // PlatformFile prescription;
  // PlatformFile handOut;

  File pFile;
  File hFile;

  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    InAppAPIServices inAppAPIServices = new InAppAPIServices();

    assesmentList= inAppAPIServices.getPatientAssesments(widget.patientId);
    journalList= inAppAPIServices.getPatientJournal(widget.patientId);
    drinkingDiaryList= inAppAPIServices.getDrinkingDiaryList(widget.patientId);
  }

  _pickDocument(type) async {
      String result = '';
      try {
        result = await FlutterDocumentPicker.openDocument();
        print(result);
        
        switch (type) {
          case "prescription":
            print({
                pFile = File(result),
                prescriptionPath = result,
                prescriptionName = result.split('/').last,
              });
            // print(result.files.single.path);
            setState(() {
              pFile = File(result);
              prescriptionPath = result;
              prescriptionName = result.split('/').last;
            });
            break;
          case "handout":
            // print(result.files.single.path);
            setState(() {
              hFile = File(result);
              handoutPath = result;
              handoutName = result.split('/').last;
            });
            break;
          default:
        }
      } catch (e) {
        print(e);
        result = 'Error: $e';
      } finally {
      
      }
      return result;
    }

    
  // void uploadDoc(type) async{

  //   String result = _pickDocument(type);
  //   // FilePickerResult result = await FilePicker.platform.pickFiles(
  //   //       type: FileType.custom,
  //   //       allowMultiple: false,
  //   //       allowedExtensions: ['jpg', 'pdf', 'doc'],
  //   //     );

  //   switch (type) {
  //     case "prescription":
  //       print(
  //         {
  //         pFile = File(result),
  //         prescriptionPath = result,
  //         prescriptionName = result.split('/').last,
  //       }
  //       );
  //       // print(result.files.single.path);
  //       setState(() {
  //         pFile = File(result);
  //         prescriptionPath = result;
  //         prescriptionName = result.split('/').last;
  //       });
  //       break;
  //     case "handout":
  //       // print(result.files.single.path);
  //       setState(() {
  //         hFile = File(result);
  //         handoutPath = result;
  //         handoutName = result.split('/').last;
  //       });
  //       break;
  //     default:
  //   }
  // }

   // show circular

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child:CircularProgressIndicator(),
          );
      });
  }

  void onSubmit() async {
    if(prescriptionPath == null && handoutPath == null && noteController.text.trim() == ""){
      return;
    }

    var noteText = noteController.text;
    InAppAPIServices inAppAPIServices = new InAppAPIServices();
    buildShowDialog(context);
    inAppAPIServices.addPrescription(widget.session.id.toString(), pFile, hFile, noteController.text.toString()).then((value) => {
       Navigator.of(context).pop(),
      Timer(Duration(seconds: 1),
      ()=> {
        showToast(value.responseMsg)
      }),
      if(value.responseCode == 200){
        noteController.clear(),
         setState(() {
          hFile = null;
          handoutPath = null;
          handoutName = null;
          pFile = null;
          prescriptionPath = null;
          prescriptionName = null;
        }),
      }
    });
  }

   //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: widget.session.patientId.firstName+' '+widget.session.patientId.lastName, child: Container(
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
                      LimitedBox(
                        maxHeight: MediaQuery.of(context).size.height / 3.7,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: FutureBuilder<PatientAssesmentList>( 
                            future: assesmentList,
                            builder: (context,snapshot){
                              if(snapshot.connectionState == ConnectionState.done){
                                if(snapshot.hasError){
                                  return  HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
                                }
                                var item = snapshot.data.result;
                                if(item.length == 0){
                                  return Container(
                                    child: HHTextView(title: "No data found.",
                                      color: HH_Colors.purpleColor,
                                      size: 18, 
                                      textweight: FontWeight.w500));
                                }
                                return Container(
                                  color: HH_Colors.color_FBF4F4,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                    return Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                                      child: AssesmentItem(title: item[index].title, 
                                      value: item[index].remarks.toString().split(":")[0],
                                      subTitle: "Remarks:"));
                                        },
                                      itemCount: item.length,
                                  ));
                              }else {
                                return Container(
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              }
                            }
                          ),
                        ) 
                       
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
                        margin: EdgeInsets.only(top: 10),
                        // height: MediaQuery.of(context).size.height / 3.7,
                        child:
                          FutureBuilder<Diary.GetDrinkingDiaryList>(
                          future: drinkingDiaryList,
                          builder: (context,snapshot){
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return  HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
                              }

                              if(snapshot.data.result.length == 0){
                                return HHTextView(
                                        title: "No data found.",
                                        color: HH_Colors.purpleColor,
                                        size: 18,
                                        textweight: FontWeight.w500,
                                      );
                              }

                              // SchedulerBinding.instance.addPostFrameCallback((_){
                              //   setState(() {
                              //     mDiaryList = snapshot.data.result;
                              //   });
                              // });

                              graphData = getGraphData(snapshot.data.result, pos);
                              label = getLabel(graphData);
                              List<WeekSlotModal> weekSlotData = getWeeks(snapshot.data.result);

                             

                              // var item = snapshot.data.result;
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: snapshot.data.result != null && snapshot.data.result.length > 0 ? MyGraphWidget(weekSlotData: weekSlotData.reversed.toList(),) : HHTextView(
                                  title: "No data found.",
                                  color: HH_Colors.purpleColor,
                                  size: 17,
                                  textweight: FontWeight.w600,
                                ),
                              );
                            }else {
                              return Container(
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                          }
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
                    }, 
                    bColor: HH_Colors.orange_FF8A73, arrowContainerColor: HH_Colors.light_FBB7A9),
                    isJournling == true ?
                      Container(
                        // color: HH_Colors.color_FBF4F4,
                        // margin: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height / 3.7,
                        padding: EdgeInsets.all(10),
                        child: Container(
                          child: FutureBuilder<JournalList>( 
                                future: journalList,
                                builder: (context,snapshot){
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasError){
                                      return HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600);
                                    }
                                
                                    if(snapshot.data.result.length == 0){
                                      return HHTextView(
                                              title: "No data found.",
                                              color: HH_Colors.purpleColor,
                                              size: 18,
                                              textweight: FontWeight.w500,
                                            );
                                    }

                                    return Container(
                                      color: HH_Colors.color_FBF4F4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Color(0xffEDEDF8),
                                          color: HH_Colors.color_FBF4F4,
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            var _date = snapshot.data.result[index].createdAt;
                                            Moment createdDt = Moment.parse('$_date');
                                            return Column(children: [
                                                MyExpansionTile(
                                                title: Text(''),
                                            headerBackgroundColor: HH_Colors.color_9ca031,
                                            leading: Text(
                                              createdDt.format("dd/MM/yyyy"),
                                            style: TextStyle(color: Colors.white),
                                            ),
                                            children: [
                                            Container(
                                            color: HH_Colors.color_EDEDF8,
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.only(
                                            left: 15, top: 15, bottom: 10, right: 10),
                                            child: ExpandableListTile(result:snapshot.data.result[index], date:createdDt.format("hh:mm a"))
                                            )
                                            ],
                                            )
                                                    // Container(
                                                    //   margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                    //   padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight:  Radius.circular(8.0)),
                                                    //     color: Color(0xffCBCEFC),
                                                    //   ),
                                                    //   child: Container(
                                                    //       child: Stack(children: [
                                                    //        Row(
                                                    //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //          crossAxisAlignment: CrossAxisAlignment.center,
                                                    //          children: [
                                                    //             Padding(
                                                    //               padding: EdgeInsets.only(top: 0),
                                                    //               child:  HHTextView(color: HH_Colors.color_white,
                                                    //               title: createdDt.format("dd/mm/yyyy"),
                                                    //               size: 16,
                                                    //               textweight: FontWeight.w600,),
                                                    //             ),
                                                    //
                                                    //             Container(
                                                    //               // alignment: Alignment.bottomRight,
                                                    //               child: IconButton(icon: Icon(
                                                    //                 Icons.keyboard_arrow_right_outlined,
                                                    //                 size: 32,
                                                    //                 color: HH_Colors.color_white,
                                                    //               ), onPressed: () {
                                                    //
                                                    //                },),
                                                    //             )
                                                    //          ],
                                                    //        )
                                                    //       ],)
                                                    //     ),
                                                    // ),
                                                    // // for (Question  quess in snapshot.data.result[index].questions)
                                                    // Container(
                                                    //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                    //   padding: EdgeInsets.fromLTRB(10, 5, 10, 2),
                                                    //   color: HH_Colors.color_EDEDF8,
                                                    //   child: ExpandableListTile(
                                                    //     result: snapshot.data.result[index],
                                                    //   ),
                                                    // )

                                                  ],);
                                          },
                                          itemCount: snapshot.data.result.length,
                                        ),
                                      ),
                                    );
                                  }else {
                                    return Container(
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }
                                }
                              )
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            AddFileCard(title: "Add Prescription", size: 22, 
              selectDoc: (){
                _pickDocument("prescription");
              },
              filename:prescriptionName
            ),
            AddFileCard(title: "Add Handout", size: 22, selectDoc: (){
              _pickDocument("handout");
            }, filename:handoutName)
          ],)
        ),
        
        Container(
          padding: EdgeInsets.fromLTRB(20,0,20,40),
          // margin: EdgeInsets.only(bottom: 20),
          child: HHEditText(
            hint: "Write Notes",
            minLines: 4,
            controller: noteController,
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
                    // Navigator.pop(context);
                    onSubmit();
                },
              ),
            ),
          )
      ],
      ),)
    ),
    );
  }
  List<Diary.Result> getGraphData(List<Diary.Result> result, int pos) {
    List<Diary.Result> mList = new List();
    if(result.length > pos){
      if(result.length > pos+7){
        mList.addAll(result.getRange(pos, pos+7));
      }else{
        mList.addAll(result.getRange(pos, result.length));
      }
    }
    return mList;
  }

  String getLabel(List<Diary.Result> graphData) {
    if(graphData.length > 0) {
      String start = getDateLabel(graphData[0].date);
      String end = getDateLabel(graphData[graphData.length - 1].date);
      return end+" to "+start;
    }

    return  '';
  }
  String getDateLabel(mdate){
    Moment date = Moment.parse(mdate.toString());
    return date.format("dd MMM");

  }
  List<WeekSlotModal> getWeeks(List<Diary.Result> data){
    List<WeekSlotModal> slots = List();
    if(!data.isEmpty && data.length > 0){
      DateTime firstDate = getFirstWeekDate(data[data.length-1].date);
      DateTime lastDate = data[0].date.add(Duration(days: DateTime.daysPerWeek - data[0].date.weekday));

      int totalWeeks =(((lastDate.difference(firstDate).inDays)+1)/7).floor() ;
      print("total weeks : "+totalWeeks.toString());
      for(int i=0; i<totalWeeks; i++){
        slots.add(WeekSlotModal(id:firstDate, weekName: "Week "+(i+1).toString(), mData: getWeekDataFromList(firstDate, data) ));
        firstDate = firstDate.add(Duration(days: 7));
      }
    }
    print(slots.toString());
    return slots;
  }
}

DateTime getFirstWeekDate(DateTime date){
  return date.subtract(Duration(days: date.weekday - 1));
}

List<Diary.Result> getWeekDataFromList(DateTime weekStartDate, List<Diary.Result> data){
  List<Diary.Result> results = List();
  data.forEach((element) {
    if(weekStartDate.isSameDate(getFirstWeekDate(element.date))){
      results.add(element);
    }
  });

  List<Diary.Result> results1 = List();
  Diary.Result firstday = new Diary.Result();
  firstday.achivedGoal = 0;
  firstday.date = weekStartDate;

  results1.add(firstday);

  for(int i=2; i<8; i++){
    Diary.Result newDay = new Diary.Result();
    newDay.achivedGoal = 0;
    newDay.date = weekStartDate.add(Duration(days: i-1));
    results1.add(newDay);
  }

  results.forEach((element) {
    List<Diary.Result> list = List();
    list.add(element);
    results1[element.date.weekday-1] = element;
    // results1.sereplaceRange(element.date.weekday-1, element.date.weekday-1, list);
  });

  return results1;
}

class WeekSlotModal{
  DateTime id;
  String weekName;
  List<Diary.Result> mData;
  bool isSelected = false;

  WeekSlotModal({this.id, this.mData, this.weekName});

  setId(DateTime id){
    this.id = id;
  }
  setWeekName(String weekName){
    this.weekName = weekName;
  }
  setData(List<Diary.Result> mData){
    this.mData = mData;
  }
}

class SessionDetailsArguments {
  final SessionModal.Result data;
  final String patientId;

  SessionDetailsArguments(this.data, this.patientId);
}
