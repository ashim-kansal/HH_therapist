import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/model/GetBookingSlotsResponse.dart';

class GridViewWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
        crossAxisCount: 4,
        childAspectRatio: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: HH_Colors.grey_F2F2F2,
            ),
            padding: EdgeInsets.all(10),
            child: Center(child: Text(
              'Item $index',
              textAlign: TextAlign.center,
              style: TextStyle(color: HH_Colors.grey_707070),
            ),),
          );
        })
    );
  }
}


class SessionDateWidget extends StatefulWidget{
  List<Result> list;
  final ValueChanged<int> onSelectDate;

  SessionDateWidget({Key key,@required this.list, this.onSelectDate});


  @override
  State<StatefulWidget> createState() => SessionDateWidgetState();

}

class SessionDateWidgetState extends State<SessionDateWidget>{

  @override
  void initState() {
    super.initState();
    // widget.list??List();
    if(widget.list.length > 0)
      widget.list[0].isSelected = true;
    // populateData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: widget.list[index].isSelected ? HH_Colors.primaryColor : Colors.white,

            ),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: Text(
                DateFormat('d MMM\nEEE').format(widget.list[index].scheduleDate),
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.list[index].isSelected? Colors.white : HH_Colors.grey_707070),
              ),),
          ),
          onTap: (){
            setItemSelected(index);
          },
        );



      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void setItemSelected(int index) {
    widget.onSelectDate(index);
    setState(() {
      for (int i = 0; i < widget.list.length; i++){
        if(index == i) {
          widget.list[i].isSelected = true;
        }else{
          widget.list[i].isSelected = false;
        }
      }


    });
  }
}

class ListItem<String> {
  bool isSelected = false; //Selection property to highlight or not
  String data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}