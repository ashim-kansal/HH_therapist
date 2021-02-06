import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/PatientNotesList.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:toast/toast.dart';

class NotesPage extends StatefulWidget {
  static const String RouteName = '/notes';

  List<int> mList;
  int count = 1;

  String patientId;

  NotesPage({Key key, this.patientId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {


  TextEditingController noteController = TextEditingController();
  Future notesList;
  bool error = false;

  @override
  void initState() {
    super.initState();
    widget.mList ?? List();
    widget.count ?? 0;
  }

  void addItem() {

    if(noteController.text.trim().length == 0){
      setState(() {
        error=true;
      });
      return;
    }

    setState(() {
      error=false;
    });

    print(noteController.text);

    InAppAPIServices inAppAPIServices = new InAppAPIServices();

    inAppAPIServices.addNote(noteController.text, widget.patientId).then((value) => {
      showToast(value.responseMsg),
      if(value.responseCode == 200){
        Navigator.pop(context),
        noteController.text = '',
        setState((){}),
        // notesList = getPatientNotes(widget.patientId),
        // Timer(Duration(seconds: 3),
        // ()=> {
        //   Navigator.pop(context),
        // }),
        
      }
    });
    // widget.count + 1;
    // widget.mList.add(widget.count);
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
    return MyWidget(
        title: 'Notes',
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                            color: HH_Colors.grey_707070,
                            fontFamily: "ProximaNova"),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return DialogWithField(
                                  onClick: () {
                                    addItem();
                                  },
                                  noteErr: error,
                                  controller: noteController,
                                );
                            },
                          );
                          // addItem();
                        },
                        child: Icon(
                          Icons.add_circle_outlined,
                          color: HH_Colors.accentColor,
                        ),
                      ),
                    ])),
            Expanded(
                child: FutureBuilder<PatientNotesList>(
                  future: getPatientNotes(widget.patientId),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return HHTextView(title: AppLocalizations.of(context).no_record_found, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var _date = snapshot.data.result[index].updatedAt;
                          Moment createdDt = Moment.parse('$_date');
                          return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: HH_Colors.color_FFECE8,
                              border: Border.all(color: HH_Colors.color_D9D9D9),
                              shape: BoxShape.rectangle),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data.result[index].note,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: HH_Colors.grey_707070,
                                    fontFamily: "ProximaNova"),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(children: [
                                Icon(
                                  Icons.access_time_sharp,
                                  color: HH_Colors.accentColor,
                                  size: 15,
                                ),
                                Text(
                                  createdDt.format("dd MMM, yyyy, hh:mm a"),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15, color: HH_Colors.grey_707070),
                                ),
                              ]),)
                            ],
                          ),
                        );
                        },
                        itemCount: snapshot.data.result.length,
                      );
                    }else {
                      return Container(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                )
            )
          ],
        ));
  }
}

class NotesArguments {
  final String data;

  NotesArguments(this.data);
}
