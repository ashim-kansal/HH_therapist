import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/linechart.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:simple_moment/simple_moment.dart';

class MyGraphWidget extends StatefulWidget{
  List<WeekSlotModal> weekSlotData;

  MyGraphWidget({this.weekSlotData});

  @override
  State<StatefulWidget> createState() => MyGraphWidgetState();

}

class MyGraphWidgetState extends State<MyGraphWidget>{
  int val = 0;
  String label = '';

  @override
  void initState() {
    super.initState();
    label = label??"";
    print(widget.weekSlotData.length.toString());
    val = val??0;
    if(widget.weekSlotData.length>0)
      widget.weekSlotData[0].isSelected = true;

    label = getlabel();
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Column(

        children: [
          Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: HH_Colors.primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),
                // Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                Text(label, style: TextStyle(color: Colors.white),),
                // Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                SizedBox(width: 10,),
              ],
            ),
          ),
          Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child:
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: HH_Colors.color_white,),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: widget.weekSlotData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left:20,top:10,right:20,bottom: 10),
                        child: Center(
                          child: Text(
                            widget.weekSlotData[index].weekName,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: widget.weekSlotData[index].isSelected??false? HH_Colors.accentColor:HH_Colors.grey_585858, fontFamily: "ProximaNova",
                                fontWeight: FontWeight.w700),
                          ),),
                      ),
                      onTap: (){
                        setItemSelected(index);
                      },
                    );

                  },
                  separatorBuilder: (context, index) {
                    return Divider( height: 20,);
                  },
                ),
              )),
          SizedBox(width: 10,),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child:
            Container(
              height: MediaQuery.of(context).size.height/3,


              child: widget.weekSlotData[val].mData != null && widget.weekSlotData[val].mData.length > 0 ? SimpleLineChart.withData(widget.weekSlotData[val].mData)
                  :Center(child:HHTextView(
                title: "No data found.",
                color: HH_Colors.purpleColor,
                size: 17,
                textweight: FontWeight.w600,
              )),
            ),
          )

        ],
      ),

    );
  }

  void setItemSelected(int index) {
    setState(() {
      val = index;
      for (int i = 0; i < widget.weekSlotData.length; i++){
        if(index == i) {
          widget.weekSlotData[i].isSelected = true;
        }else{
          widget.weekSlotData[i].isSelected = false;
        }
      }
      label=getlabel();

    });
  }

  String getlabel() {
    DateTime wk = widget.weekSlotData[val].id;
    return getDateLabel(getFirstWeekDate(wk)) +" - "+ getDateLabel(getLastDateOfWeek(wk));
    // List<>widget.weekSlotData[val]
  }

  String getDateLabel(mdate){
    Moment date = Moment.parse(mdate.toString());
    return date.format("dd MMM");

  }

  DateTime getFirstWeekDate(DateTime date){
    return date.subtract(Duration(days: date.weekday - 1));
  }

  DateTime getLastDateOfWeek(DateTime date){
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }
}
