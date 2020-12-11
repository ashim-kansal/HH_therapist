import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widgets/linechart.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class DrinkingDiaryPage extends StatefulWidget{
  static const String RouteName = '/drinking_diary';


  @override
  State<StatefulWidget> createState() => DrinkingDiaryPageState();
}
class DrinkingDiaryPageState extends State<DrinkingDiaryPage>{

  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'Drinking Diary',
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: HH_Colors.primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
              ),
              padding: EdgeInsets.all(5),
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
              child:             Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height/3,
                child: SimpleLineChart.withSampleData(),
              )

            ),
              SizedBox(height: 20,),
            DrinkingDiaryCell(),
            DrinkingDiaryCell(),
            DrinkingDiaryCell(),
            DrinkingDiaryCell(),
            DrinkingDiaryCell(),
            DrinkingDiaryCell(),
            DrinkingDiaryCell(),

          ],
        )
    );
  }

}