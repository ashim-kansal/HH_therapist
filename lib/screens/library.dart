import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class LibraryPage extends StatefulWidget {
  static const String RouteName = '/library';
  final docs = [
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
  ];

  LibraryPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(10, (index) {
                  return
                  Card(child:
                    InkWell(
                      onTap:(){},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.account_circle_outlined),
                            Text('Social-Posts.docx', textAlign: TextAlign.center,style: TextStyle(fontSize:13,color: HH_Colors.grey_585858, fontFamily: "ProximaNova", fontWeight: FontWeight.bold),)
                            ,Text('By Sophie Solmini 14/11/2020 12:30 PM', textAlign: TextAlign.center, style: TextStyle(fontSize:12,color: HH_Colors.accentColor),)
                          ,HHButton(title: 'Download', type: 4, isEnable: true,)
                          ],
                        ),
                      ),
                    ),);
                })
            )),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: HHButton(title: 'Search Nearest Pharmacies',type: 1,isEnable: true,),
            ),
          ],

        ));
  }
}