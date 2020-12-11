import 'package:flutter/material.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class ReviewPage extends StatefulWidget {
  static const String RouteName = '/review';

  ReviewPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<ReviewPage> {

  String stateDropdown = 'Select State';
  String countryDropdown = 'Select Country';

  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Share Your Reviews', style: TextStyle(color: Colors.white)),
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
                                child: HHTextView(
                                  title: "Share Your Reviews for Session/ Therapist!" ,
                                  color: HH_Colors.purpleColor,
                                  size: 22,)
                             ),
                            ),

                            Flexible(
                              
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(3.0),
                                  
                                  child: HHTextView(
                                    title: "Tuesday, may 12th 2020",
                                    size: 22,
                                    color: HH_Colors.grey_707070,
                                  )
                                ),
                                 Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHTextView(
                                        title: "Alcohol Management Commented",
                                        size: 16,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child:HHTextView(
                                        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
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
                                  
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHTextView(
                                        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                        size: 16,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      alignment: Alignment.topLeft,
                                      child:HHTextView(
                                        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
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
                                
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: HHEditText(
                                        hint: "",
                                        controller: reviewController,
                                        error: widget.error,
                                        errorText:
                                        'Please enter your review',
                                      ),
                                    ),
                                   
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
                                  title: "Submit",
                                  type: 4,
                                  onClick: () {
                                    
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
