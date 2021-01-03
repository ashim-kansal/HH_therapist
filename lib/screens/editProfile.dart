import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:toast/toast.dart';

class EditProfilePage extends StatefulWidget {
  static const String RouteName = '/editProfile';

  Result data;

  EditProfilePage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  var error = false;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<EditProfilePage> {

  String stateDropdown = 'Select Province';
  String countryDropdown = 'Select Country';
 
  String countryCode;
  String profileImage;

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fname.dispose();
    lname.dispose();
  }

  @override
  void initState(){
    super.initState();
    fname.text = widget.data.firstName;
    lname.text = widget.data.lastName;
    number.text = widget.data.mobileNumber;
    address.text = widget.data.address;
    email.text = widget.data.email;
    profileImage = widget.data.profilePic;
  }

  void updateProfile () {
    UserAPIServices userAPIServices = new UserAPIServices();

    userAPIServices.updateProfileDetails(fname.text, lname.text, number.text, address.text).then((value) => {
      showToast(value.responseMessage),
      if(value.responseCode == 200){
        // Navigator.pushNamed(context, ProfilePage.RouteName)
      }
    });
  }

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Container(
                                child: profileImage == null ? Image.asset('assets/images/userimage.png', 
                                height: 120,
                                width: 90) : 
                                CircleAvatar(
                                  backgroundImage: NetworkImage(profileImage),
                                  radius: 46,
                                ),
                                )
                            ),
                           
                            Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 25, 5, 10),
                                  child: HHEditText(
                                    hint: "First Name",
                                    obscureText: false,
                                    controller: fname,
                                    error: widget.error,
                                    errorText:
                                    'Please enter your first name',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: "Last Name",
                                    obscureText: false,
                                    controller: lname,
                                    error: widget.error,
                                    errorText:
                                    'Please enter your last name',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: HHEditText(
                                    hint: "Email",
                                    obscureText: false,
                                    enabled: false,
                                    controller: email,
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
                                    controller: number,
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
                                    controller: address,
                                    error: widget.error,
                                    errorText:
                                    'Please enter a address',
                                  ),
                                ),
                                // Container(
                                //   width: 290,
                                //   margin: EdgeInsets.only(top: 10),
                                //   padding: const EdgeInsets.only(left: 20.0,right: 10.0),
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.rectangle,
                                //     border: Border.all(color: Color(0xffE9E7E7)),
                                //     borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                //   child: DropdownButtonHideUnderline (
                                //     child: new DropdownButton<String>(
                                //       isExpanded: true,
                                //       value: countryDropdown,
                                //       icon: Icon(Icons.arrow_drop_down),
                                //       iconEnabledColor: Color(0xffC5C4C4),
                                //       iconSize: 38,
                                //       elevation: 16,
                                //       style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                //       items: <String>['Select Country', 'India', 'Canada', 'USA'].map((String value) {
                                //         return new DropdownMenuItem<String>(
                                //           value: value,
                                //           child: new Text(value),
                                //         );
                                //       }).toList(),
                                //       onChanged: (String newValue) {
                                //         setState(() {
                                //           countryDropdown = newValue;
                                //         });
                                //       },
                                //     ),
                                //   )
                                // ),

                                // Container(
                                //   width: 290,
                                //   // margin: EdgeInsets.only(top: 5),
                                //   padding: const EdgeInsets.only(left: 20.0,right: 10.0,),
                                //   decoration: BoxDecoration(
                                //       shape: BoxShape.rectangle,
                                //       border: Border.all(color: Color(0xffE9E7E7)),
                                //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                //   child: DropdownButtonHideUnderline(
                                //     child: new DropdownButton<String>(
                                //     value: stateDropdown,
                                //     isExpanded: true,
                                //     icon: Icon(Icons.arrow_drop_down),
                                //     iconEnabledColor: Color(0xffC5C4C4),
                                //     iconSize: 38,
                                //     elevation: 16,
                                //     style: TextStyle(color: Color(0xff707070), fontFamily: "ProximaNova"),
                                //     items: <String>['Select Province', 'Chandigarh', 'Haryana', 'Punjab'].map((String value) {
                                //       return new DropdownMenuItem<String>(
                                        
                                //         value: value,
                                //         child: new Text(value),
                                //       );
                                //     }).toList(),
                                //     onChanged: (String newValue) {
                                //       setState(() {
                                //         stateDropdown = newValue;
                                //       });
                                //     },
                                //   )) 
                                // ),

                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
                                    child: HHButton(
                                      isEnable: true,
                                      title: "Save",
                                      type: 4,
                                      onClick: () {
                                        updateProfile();
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

class ProfileArguments {
  final Result data;

  ProfileArguments(this.data);
}
