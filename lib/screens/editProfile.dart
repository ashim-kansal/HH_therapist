import 'package:flutter/material.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class EditProfilePage extends StatefulWidget {
  static const String RouteName = '/editProfile';

  EditProfilePage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<EditProfilePage> {

  String stateDropdown = 'Select State';
  String countryDropdown = 'Select Country';

  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Material(
                    child: ClipPath(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Container(
                                // width: 120,
                                // height: 140,
                                // decoration: BoxDecoration(
                                //   color: Color(0xffF2EEEE),
                                //   // shape: BoxShape.circle,
                                //   border: Border.all(color: Color(0xffF2EEEE)),
                                //   borderRadius: BorderRadius.all(Radius.circular(50.0))
                                // ),
                                child: Image.asset('assets/images/userimage.png', 
                                height: 120,
                                width: 90),)
                            ),
                           
                            Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
                                  child: HHEditText(
                                    hint: "Full Name",
                                    obscureText: false,
                                    controller: cpasswordController,
                                    error: widget.error,
                                    errorText:
                                    'Please enter your full name',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: "Email",
                                    obscureText: false,
                                    controller: cpasswordController,
                                    error: widget.error,
                                    errorText:
                                    'Please enter a valid email address',
                                  ),
                                ),
                                
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: "Phone Number",
                                    obscureText: false,
                                    controller: passwordController,
                                    error: widget.error,
                                    errorText:
                                    'Please enter a phone number',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: "Address",
                                    obscureText: false,
                                    controller: cpasswordController,
                                    error: widget.error,
                                    errorText:
                                    'Please enter a address',
                                  ),
                                ),
                                 Container(
                                  width: 290,
                                  // margin: EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.only(left: 20.0,right: 10.0,),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Color(0xffE9E7E7)),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: new DropdownButton<String>(
                                    value: stateDropdown,
                                    isExpanded: true,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconEnabledColor: Color(0xffC5C4C4),
                                    iconSize: 38,
                                    elevation: 16,
                                    style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                    items: <String>['Select State', 'Chandigarh', 'Haryana', 'Punjab'].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        stateDropdown = newValue;
                                      });
                                    },
                                  )) 
                                  // child: HHEditText(
                                  //   hint: "Select State",
                                  //   obscureText: false,
                                  //   controller: cpasswordController,
                                  //   error: widget.error,
                                  //   errorText:
                                  //   'Please select a state',
                                  // ),
                                ),
                                Container(
                                  width: 290,
                                  margin: EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(left: 20.0,right: 10.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Color(0xffE9E7E7)),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                  child: DropdownButtonHideUnderline (
                                    child: new DropdownButton<String>(
                                      isExpanded: true,
                                      value: countryDropdown,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconEnabledColor: Color(0xffC5C4C4),
                                      iconSize: 38,
                                      elevation: 16,
                                      style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                      items: <String>['Select Country', 'India', 'Canada', 'USA'].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          countryDropdown = newValue;
                                        });
                                      },
                                    ),
                                  )
                                  // HHEditText(
                                  //   hint: "Country",
                                  //   obscureText: false,
                                  //   controller: cpasswordController,
                                  //   error: widget.error,
                                  //   errorText:
                                  //   'Please select a country',
                                  // ),
                                ),

                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 50, 5, 15),
                                    child: HHButton(
                                      isEnable: true,
                                      title: "Save",
                                      type: 4,
                                      onClick: () {
                                      },
                                    ),
                                  ),
                                )
                                
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // elevation: 8.0,
                    // shadowColor: Colors.black38,
                    // borderRadius: BorderRadius.circular(8.0),
                    // borderOnForeground: true,
                  ),
                ],
              )),
          // backgroundColor: Colors.white,
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
