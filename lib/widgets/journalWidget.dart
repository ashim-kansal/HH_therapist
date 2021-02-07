import 'package:flutter/material.dart';
import 'package:flutter_app/model/JournalList.dart';
import 'package:flutter_app/utils/colors.dart';

class ExpandableListTile extends StatelessWidget{

  Result result;
  String date;

  ExpandableListTile({this.result, this.date});

  @override
  Widget build(BuildContext context) {
   return Column(

     children: _buildExpandableContent(result, date, context),
   );
  }
}

List<Widget> _buildExpandableContent(Result result,String _date, BuildContext context) {
  List<Widget> columnContent = [];

  for (Question ques in result.questions)
    columnContent.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            ques.question,
            style: TextStyle(
                color: HH_Colors.color_707070,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5,),
          Text(
            ques.answer,
            style: TextStyle(
                color: HH_Colors.grey_707070, fontSize: 16),
          ),

          SizedBox(height: 5,),
        ],
      ),
    );


  return columnContent;
}