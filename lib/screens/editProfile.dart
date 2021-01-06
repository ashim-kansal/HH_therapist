import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:image_picker/image_picker.dart';
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


  File _image;
  final picker = ImagePicker();

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

    userAPIServices.updateProfileDetails(fname.text, lname.text, number.text, address.text, profileImage).then((value) => {
      showToast(value.responseMessage),
      if(value.responseCode == 200){
        Navigator.pop(context),
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
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: MyWidget(
      title: 'Edit Profile',
        child: Container(
            height: MediaQuery.of(context).size.height,

            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: SingleChildScrollView(child:  Column(
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
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                      decoration: new BoxDecoration(color: Colors.white),
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        radius: 55,
                                        backgroundColor: HH_Colors.color_F2EEEE,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(profileImage),
                                          // AssetImage("assets/images/userimage.png"),
                                          radius: 46,
                                        ),
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 155),
                                    child: Container(
                                      width: 35,
                                      height:35,
                                      decoration: BoxDecoration(
                                          boxShadow: [//background color of box
                                            BoxShadow(
                                              color: HH_Colors.color_F2EEEE,
                                              blurRadius: 65.0, // soften the shadow
                                              spreadRadius: 1.0, //extend the shadow
                                              offset: Offset(
                                                15.0, // Move to right 10  horizontally
                                                15.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: 20,
                                        ), onPressed: () {
                                        imagePicker();
                                      },
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                // Padding(
                                //   padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                //   child: HHEditText(
                                //     hint: "Address",
                                //     obscureText: false,
                                //     controller: address,
                                //     error: widget.error,
                                //     errorText:
                                //     'Please enter a address',
                                //   ),
                                // ),


                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 50, 5, 15),
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
                    // elevation: 8.0,
                    // shadowColor: Colors.black38,
                    // borderRadius: BorderRadius.circular(8.0),
                    // borderOnForeground: true,
                  ),
                ],
              ),)),
          // backgroundColor: Colors.white,
          // This trailing comma makes auto-formatting nicer for build methods.
        )
      );
  }
  Future<bool> _onBackPressed() {
    Navigator.pop(context);
    // Navigator.pushNamed(context, ProfilePage.RouteName);
  }

  Future imagePicker () async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        // print(pickedFile.path);
        _image = File(pickedFile.path);
        // final bytes = _image.readAsBytesSync();
        // String base64 = base64Encode(bytes);
        //
        // print(base64);

        SettingAPIService settingAPIService = new SettingAPIService();
        settingAPIService.uploadImageFile(file:_image).then((value) => {
          print(value),
          // if(value == 200){
          setState(() {
            if(value['result'] != null && value['result']['image'] != null)
              profileImage = value['result']['image'];

          })
          // }
        });
      } else {
        print('No image selected.');
      }
    });
  }

}

class ProfileArguments {
  final Result data;

  ProfileArguments(this.data);
}
