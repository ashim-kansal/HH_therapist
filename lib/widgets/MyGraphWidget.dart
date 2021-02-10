import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/linechart.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class MyGraphWidget extends StatefulWidget{
  List<WeekSlotModal> weekSlotData;

  MyGraphWidget({this.weekSlotData});

  @override
  State<StatefulWidget> createState() => MyGraphWidgetState();

}

class MyGraphWidgetState extends State<MyGraphWidget>{
  int val = 0;

  @override
  void initState() {
    super.initState();
    print(widget.weekSlotData.length.toString());
    val = val??0;
    if(widget.weekSlotData.length>0)
      widget.weekSlotData[0].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Column(

        children: [

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
              // reverse: true,
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

    });
  }

}
