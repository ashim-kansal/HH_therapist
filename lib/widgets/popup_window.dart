import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
/// An arbitrary widget that lives in a popup menu
class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({ Key key, this.height, this.child }) : super(key: key);

  @override
  final Widget child;

  @override
  final double height;

  @override
  bool get enabled => false;

  @override


  @override
  _PopupMenuWidgetState createState() => new _PopupMenuWidgetState();

  @override
  bool represents(T value) {
    // sTODO: implement represents
    throw UnimplementedError();
  }
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}


class HHOptionButton extends StatelessWidget{

  final VoidCallback onClickCancel;
  final VoidCallback onClickReSchedule;
  HHOptionButton({this.onClickCancel, this.onClickReSchedule});


  @override
  Widget build(BuildContext context) {
    return
      Container(
          padding: const EdgeInsets.all(0.0),
          width: 20,
          height: 40,
          //   height: 35,// you can adjust the width as you need
          child: PopupMenuButton<String>(
              offset: Offset(40,40),

              onSelected: (String value) {
                print("You selected $value");
              },
              // captureInheritedThemes: false,
              icon: Image.asset('assets/images/dot.png', height: 60,),
              itemBuilder: (BuildContext context) {
                return [
                  new PopupMenuWidget(

                      child:
                      Container(

                        child:  Column(
                          children: [
                            InkWell(
                              child: Text('cancel'),

                              onTap: (){ Navigator.pop(context, 'cancel');
                              onClickCancel();
                              },
                            ),
                            SizedBox(height: 5,),
                            Container(
                              color: HH_Colors.borderGrey,
                              height: 0.5,
                              width: 100,
                            ),
                            SizedBox(height: 5,),
                            InkWell(
                              child: Text('re-schedule'),
                              onTap: (){ Navigator.pop(context, 're-schedule');
                              onClickReSchedule();
                              },
                            )
                          ],
                        ),

                      )
                  ),
                ];
              }
          )
      );

  }
}

