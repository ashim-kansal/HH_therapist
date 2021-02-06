import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
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
          width: 25,
          height: 40,
          //   height: 35,// you can adjust the width as you need
          child: PopupMenuButton<String>(
              offset: Offset(20,20),
              icon: Icon(Icons.more_vert, color: HH_Colors.grey_cccccc,),
              padding: EdgeInsets.all(8),
              onSelected: (String value) {
                print("You selected $value");
              },
              // captureInheritedThemes: false,
              itemBuilder: (BuildContext context) {
                return [
                  new PopupMenuWidget(
                      child:
                      Container(  
                        // padding: EdgeInsets.all(9.0),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FlatButton(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onPressed: (){ Navigator.pop(context, 'cancel');
                              onClickCancel();
                              }, child: HHTextView(title: "Cancel", size: 17, color: HH_Colors.color_3D3D3D, textweight: FontWeight.w500,)),
                            // InkWell(
                              
                            //   child: HHTextView(title: "Cancel", size: 17, color: HH_Colors.color_3D3D3D, textweight: FontWeight.w500,),
                            //   onTap: (){ Navigator.pop(context, 'cancel');
                            //   onClickCancel();
                            //   },
                            // ),
                            SizedBox(height: 5,),
                            Container(
                              color: HH_Colors.borderGrey,
                              height: 0.5,
                              // width: 100,
                            ),
                            SizedBox(height: 5,),
                            FlatButton(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onPressed: (){ Navigator.pop(context, 're-schedule');
                              onClickReSchedule();
                              }, child: HHTextView(title: "Re-Schedule", size: 17, color: HH_Colors.color_3D3D3D, textweight: FontWeight.w500,))
                            // InkWell(
                            //   child: HHTextView(title: "Re-Schedule", size: 17, color: HH_Colors.color_3D3D3D, textweight: FontWeight.w500,),
                            //   onTap: (){ Navigator.pop(context, 're-schedule');
                            //   onClickReSchedule();
                            //   },
                            // )
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

