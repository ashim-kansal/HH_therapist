import 'package:flutter/material.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';

class NotesPage extends StatefulWidget {
  static const String RouteName = '/notes';

  List<int> mList;
  int count = 1;

  @override
  State<StatefulWidget> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    widget.mList ?? List();
    widget.count ?? 0;
  }

  void addItem() {
    widget.count + 1;
    widget.mList.add(widget.count);
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
                          addItem();
                        },
                        child: Icon(
                          Icons.add_circle_outlined,
                          color: HH_Colors.accentColor,
                        ),
                      ),
                    ])),
            Expanded(
                child:             ListView.builder(
              itemBuilder: (context, index) => Container(
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
                      HHString.note,
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
                        '22 Nov, 2020, 1:30 PM',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15, color: HH_Colors.grey_707070),
                      ),
                    ]),)
                  ],
                ),
              ),
              itemCount: 10,
            )
            )
          ],
        ));
  }
}
