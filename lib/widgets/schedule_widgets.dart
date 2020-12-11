import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

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
          padding: EdgeInsets.all(15),
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


class SessionDateWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 4,
      childAspectRatio: 2,
      shrinkWrap: true,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(10, (index) {
        return Container(
          decoration: BoxDecoration(
            color: HH_Colors.grey_F2F2F2,
          ),
          padding: EdgeInsets.all(15),
          child: Center(child: Text(
            '16 Nov\nMon',
            textAlign: TextAlign.center,
            style: TextStyle(color: HH_Colors.grey_707070),
          ),),
        );
      })
    );
  }
}