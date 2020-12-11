import 'package:flutter/material.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class ProfilePage extends StatefulWidget {
  static const String RouteName = '/profile';

  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<ProfilePage> {

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
          title: Text('Profile', style: TextStyle(color: Colors.white)),
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

                            Flexible(
                              
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: HH_Colors.borderGrey,
                                      width: 0.5
                                    ))
                                  ),
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHTextView(
                                        title: "Name",
                                        size: 16,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child:HHTextView(
                                        title: "John Doe",
                                        size: 14,
                                        color: Color(0xff707070)
                                      ),
                                    )
                                  ],)
                                ),
                                 Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: HH_Colors.borderGrey,
                                      width: 0.5
                                    ))
                                  ),
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHTextView(
                                        title: "Email",
                                        size: 16,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child:HHTextView(
                                        title: "JohnDoe@gmail.com",
                                        size: 14,
                                        color: Color(0xff707070)
                                      ),
                                    )
                                  ],)
                                ),
                                 Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: HH_Colors.borderGrey,
                                      width: 0.5
                                    ))
                                  ),
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHTextView(
                                        title: "Phone",
                                        size: 16,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      alignment: Alignment.topLeft,
                                      child:HHTextView(
                                        title: "+91675667675",
                                        size: 14,
                                        color: Color(0xff707070)
                                      ),
                                    )
                                  ],)
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: HH_Colors.borderGrey,
                                      width: 0.5
                                    ))
                                  ),
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHTextView(
                                        title: "Address",
                                        size: 16,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                   Container(
                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                     alignment: Alignment.topLeft,
                                     child:  HHTextView(
                                      title: "#2444, adr",
                                      size: 16,
                                      color: Color(0xff707070)
                                    ),
                                   )
                                  ],)
                                ),
                              ],)
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 50, 5, 15),
                                child: HHButton(
                                  isEnable: true,
                                  title: "Edit",
                                  type: 4,
                                  onClick: () {
                                    Navigator.pushNamed(context, EditProfilePage.RouteName);
                                  },
                                ),
                              ),
                            )

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
