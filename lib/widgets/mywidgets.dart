import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';

class HHButton extends StatelessWidget {
  var title = "";
  var type = 1;
  double textSize = 22;
  final VoidCallback onClick;
  bool isEnable = true;

  HHButton({@required this.title, @required this.type, this.onClick, this.isEnable, this.textSize});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      elevation: 5.0,
      // color: isEnable ? HH_Colors.,
      // color: type == 1
      //     ? Theme.of(context).primaryColor
      //     : type == 2 ? HH_Colors.orange_FF8A73 : HH_Colors.purpleColor,
      color: type == 1
          ? (isEnable??false ? Theme.of(context).primaryColor:HH_Colors.color_F2EEEE)
          : type == 2 ? HH_Colors.orange_FF8A73: type == 4 ? HH_Colors.purpleColor :isEnable??false ?Theme.of(context).accentColor:HH_Colors.color_F2EEEE,
      onPressed: () {
        onClick();
      },
      child: Text(
        title,
        style: TextStyle(color: isEnable??false ?Colors.white:HH_Colors.color_949494,
        fontSize: textSize == null ? 22: textSize, fontWeight: FontWeight.w500, fontFamily: "ProximaNova"),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class HHHomeButton extends StatelessWidget {
  var title = "";
  var type = 1;
  final VoidCallback onClick;

  HHHomeButton({@required this.title, @required this.type, this.onClick});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.only(left: 20),
      color: HH_Colors.accentColor,
      onPressed: () {
        onClick();
      },

      focusColor: HH_Colors.accentColor,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "ProximaNova"),
            textAlign: TextAlign.start,
          ),
          Container(
            color: HH_Colors.light_accentcolor,
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HHDrawerItem extends StatelessWidget {
  var title = "";
  var icon = "";
  final VoidCallback onClick;

  HHDrawerItem({@required this.title, @required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 18, fontFamily: "ProximaNova"),
              )
            ],
          ),
        ));
  }
}

class HHDrawerItem2 extends StatelessWidget {
  var title = "";
  final VoidCallback onClick;

  HHDrawerItem2({@required this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: HH_Colors.grey_707070, fontSize: 18, fontFamily: "ProximaNova"),
                )
              ],
            )));
  }
}

class HHTextView extends StatelessWidget {
  var title;
  double size;
  var color;

  HHTextView({@required this.title, @required this.size, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: color, fontSize: size));
  }
}

class HHTextViewBoarder extends StatelessWidget {
  var title;
  double size;
  var color;

  HHTextViewBoarder({@required this.title, @required this.size, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title, 
    style: TextStyle(color: color, fontSize: size));
  }
}

class HHEditText extends StatefulWidget {
  final String hint;
  final String text = "";
  final TextEditingController controller;

  final VoidCallback onClickEye;
  
  var minLines = 1;
  var error = false;
  var errorText = "";
  bool obscureText = false;
  var showeye = false;
  // var controller = null;
  var inputType = TextInputType.text;

  
  HHEditText(
      {Key key,
      this.hint,
      this.minLines,
      this.error,
      this.errorText,
      this.obscureText,
      this.inputType,
      this.controller,
      this.onClickEye,
      this.showeye})
      : super(key: key);

  @override
  HHEditTextState createState() => HHEditTextState();
}

class HHEditTextState extends State<HHEditText> {
  // final TextEditingController controller = TextEditingController();

  void Function() param2;

  @override
  void initState() {
    if (widget.minLines == null) widget.minLines = 1;
    widget.obscureText??false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // obscureText: widget.obscureText != null && widget.error ? true : false,
      obscureText: widget.obscureText??false ,
      controller: widget.controller,
      minLines: widget.minLines,
      maxLines: widget.minLines,
      decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: "ProximaNova", fontSize: 15, color: Color(0xff707070)),
          errorText: widget.error != null && widget.error ? widget.errorText : null,
          errorStyle: TextStyle(color: Color(0xffff8a73)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Color(0xffff8a73))),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.hint == null ? "" : widget.hint,
          errorBorder: errorOutlineInputBorder(),
          border: normalOutlineInputBorder(),
          suffixIcon: widget.showeye??false ?
              IconButton(
                icon: Icon(Icons.remove_red_eye, size: 20, color: Color(0xffCBCBCB)),
                onPressed: (){
                  // widget.obscureText = !widget.obscureText;
                  // print(widget.obscureText);
                  widget.onClickEye();
                  }
                ,
              )
              // const Icon(
                
              //     Icons.remove_red_eye,
              //     size: 20,
              //     color: Color(0xffCBCBCB),
              //   )
              : null),
    );
  }
}

class UndefinedView extends StatelessWidget {
  final String name;

  const UndefinedView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined', style: TextStyle(fontFamily: "ProximaNova"),),
      ),
    );
  }
}

class CalenderCell extends StatelessWidget{

  var day;
  var date;

      CalenderCell({Key key, this.day, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Text(day, style: TextStyle(fontSize: 12,color: HH_Colors.grey_585858, fontFamily: "ProximaNova"),),
          Text(date, style: TextStyle(fontSize: 12, color: HH_Colors.grey_585858, fontFamily: "ProximaNova"),)
        ],
      ),
    );
  }
}

class DrinkingDiaryCell extends StatelessWidget{

  var day;
  var date;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: EdgeInsets.fromLTRB(10,5,10,5),
      decoration: BoxDecoration(
        border: Border.all(color: HH_Colors.borderGrey, width: 0.8),
        borderRadius: BorderRadius.all(Radius.circular(5.0))

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Mon', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: HH_Colors.primaryColor, fontFamily: "ProximaNova"),),
              SizedBox(width: 10,),
              Container(
                padding: EdgeInsets.fromLTRB(5,2 ,5, 2),
                decoration: BoxDecoration(
                    color: HH_Colors.color_FFECE8,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Row(
                  children: [
                    Icon(Icons.library_add_check_outlined, color: HH_Colors.color_949494,size: 15,),
                    SizedBox(width: 10,),
                    Text('2 units', style: TextStyle(color: HH_Colors.color_949494,fontSize: 14))
                  ],
                ),

              ),

            ],
          ),
          InkWell(
            onTap: (){

            },
            child:           Row(
              children: [
                Icon(Icons.add_circle_outlined, color: HH_Colors.color_949494,),
                SizedBox(width: 5,),
                Text('Goal', style: TextStyle(fontSize: 14, color: HH_Colors.color_949494, fontFamily: "ProximaNova"),)
              ],
            )
            ,
          )

        ],
      ),
    );
  }
}



OutlineInputBorder normalOutlineInputBorder() {
  return OutlineInputBorder(
    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: HH_Colors.borderGrey, width: 0.2),
    
  );
}

OutlineInputBorder errorOutlineInputBorder() {
  return OutlineInputBorder(
    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Color(0xffff8a73)),
  );
}
