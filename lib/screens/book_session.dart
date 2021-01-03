import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/Therapist_service.dart' as service;
import 'package:flutter_app/model/GetBookingSlotsResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart' as Therapist;
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/schedule_widgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';
import 'package:meta/meta.dart';

class BookSessionPage extends StatefulWidget{

  TextEditingController noteTextController = TextEditingController();
  TextEditingController sessionTextController = TextEditingController();

  static const String RouteName = '/schedule';

  var name= '';
  var id= '';
  var sessionId= '';
  var role= '';
  var image= '';
  BookSessionPage({Key key, @required this.name, @required this.id, @required this.sessionId, @required this.role, @required this.image}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookSessionState();

}

class BookSessionState extends State<BookSessionPage>{
  int selectedDatePos = 0;
  int selectedSlotPos = 0;
  Future<GetBookingSlotsResponse> _listFuture;

  List<Result> list;

  _updateSelectedDate(int pos) {
    setState(() {
      selectedDatePos = pos;
      list[pos].isSelected = true;
      selectedSlotPos = 0;
    });
  }
  _updateSelectedSlot(int pos) {
    setState(() {
      selectedSlotPos = pos;
      // list[pos].isSelected = true;
    });
  }

  @override
  void initState() {
    list ?? List();
    _listFuture = getBookingSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MyWidget(title: 'Schedule', child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TharapistCell(name: widget.name, role: widget.role,
          image: widget.image, showBook: false, onClick: (){},),
        FutureBuilder<GetBookingSlotsResponse>(
            future: _listFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text("Not Found"),);
                }

                SchedulerBinding.instance.addPostFrameCallback((_){

                  setState(() {
                    list = snapshot.data.result;
                  });

                });

                return Expanded(child: Column(
                  children: [
                    Container(height:50, child: SessionDateWidget(list:snapshot.data.result, onSelectDate: _updateSelectedDate,)),
                    SizedBox(height: 10,),
                    Expanded(child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(snapshot.data.result[selectedDatePos].schedule.length, (index) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                color: index == selectedSlotPos?HH_Colors.primaryColor:HH_Colors.grey_F2F2F2,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Center(child: Text(
                                snapshot.data.result[selectedDatePos].schedule[index].startTime.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: index == selectedSlotPos?Colors.white:HH_Colors.grey_707070),
                              ),),
                            ),
                            onTap: (){
                              selectedSlotPos = index;
                            },
                          );
                        })
                    )),
                  ],
                ));
              } else
                return Container(
                  child: Center(child: CircularProgressIndicator(),),
                );
            }),
        HHTextView(
          color: HH_Colors.color_707070,
          title: "Session Type",
          size: 16,
        ),
        SizedBox(
          height: 10,
        ),
        HHEditText(
          minLines: 1,
          controller: widget.sessionTextController,
        ),HHTextView(
          color: HH_Colors.color_707070,
          title: "Notes",
          size: 16,
        ),
        SizedBox(
          height: 10,
        ),
        HHEditText(
          minLines: 3,
          controller: widget.noteTextController,
        ),
        Container(
            child: HHButton(title: 'Save', type: 4, isEnable: true,onClick: (){
              // Navigator.pushNamed(context, SessionPage.RouteName);
              bookSession();
            },)
        )
      ],
    )
      // backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.

    );

  }

  Future<GetBookingSlotsResponse> getBookingSlots() async {
    var response = await service.getSlotsForBooking(widget.id);
    return response;
  }

  void bookSession(){
    service.bookSession(list[selectedDatePos].schedule[selectedSlotPos].id, widget.sessionId).then(
            (value) => {

          print(value.responseCode),
          if (value.responseCode == 200) {
            Navigator.pop(context),
            Navigator.pushNamed(context, Dashboard.RouteName)
          }
        });

  }
}