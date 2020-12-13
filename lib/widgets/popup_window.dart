import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.all(0.0),
        width: 30.0,
          height: 30,// you can adjust the width as you need
        child: PopupMenuButton<String>(
            onSelected: (String value) {
              print("You selected $value");
            },
          // captureInheritedThemes: false,
            icon: Image.asset('assets/images/ic_option_menu.png', width: 20, height: 20,),
            itemBuilder: (BuildContext context) {
              return [
                new PopupMenuWidget(
                  child: new Column(
                    children: [
                      InkWell(
                        child: Text('add'),
                        onTap: (){ Navigator.pop(context, 'add');},
                      ),InkWell(
                        child: Text('remove'),
                        onTap: (){ Navigator.pop(context, 'add');},
                      )
                    ],
                  ),
                ),
              ];
            }
        )
      );

  }
}

