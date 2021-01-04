import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  static const String RouteName = '/profile';

  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<ProfilePage> {


  UserAPIServices userAPIServices = new UserAPIServices();

  File _image;
  final picker = ImagePicker();

  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  String profilepic = "";

  Result userData;

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    
    userAPIServices.getProfile().then((value) => {
      print(value.responseMessage),
      if(value.responseCode == 200){
        setState(() {
          userData = value.result;
          name = value.result.firstName+" "+value.result.lastName;
          email = value.result.email;
          phone = value.result.mobileNumber;
          address = value.result.address;
          profilepic = value.result.profilePic;
        })
      }
    });
  }

  Future imagePicker () async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
        // final bytes = _image.readAsBytesSync();
        // String base64 = base64Encode(bytes);

        // print(base64);
        
        SettingAPIService settingAPIService = new SettingAPIService();
        settingAPIService.uploadImageFile(file:_image).then((value) => {
          print(value),
          // if(value == 200){
          setState(() {
            if(value['result'] != null && value['result']['profilePic'] != null)
              profilepic = value['result']['profilePic'];

          })
          // }
        });
      } else {
        print('No image selected.');
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
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child:  Column(
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
                                            backgroundImage: profilepic != "" ? AssetImage("assets/images/userimage.png") : NetworkImage(profilepic),
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
                                        size: 18,
                                        textweight: FontWeight.w500,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child:HHTextView(
                                        title: name,
                                        size: 14,
                                        color: HH_Colors.grey_585858,
                                        textweight: FontWeight.w400,
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
                                        size: 18,
                                        textweight: FontWeight.w500,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child:HHTextView(
                                        title: email,
                                        size: 14,
                                        color: HH_Colors.grey_585858,
                                        textweight: FontWeight.w400,
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
                                        size: 18,
                                        textweight: FontWeight.w500,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      alignment: Alignment.topLeft,
                                      child:HHTextView(
                                        title: phone,
                                        size: 14,
                                        color: HH_Colors.grey_585858,
                                        textweight: FontWeight.w400,
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
                                        size: 18,
                                        textweight: FontWeight.w500,
                                        color: Color(0xff777CEA)
                                      ),
                                    ),
                                   Container(
                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                     alignment: Alignment.topLeft,
                                     child:  HHTextView(
                                      title: address,
                                      size: 16,
                                      color: HH_Colors.grey_585858,
                                      textweight: FontWeight.w400,
                                    ),
                                   )
                                  ],)
                                ),
                              ],)
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 30, 5, 5),
                                child: HHButton(
                                  isEnable: true,
                                  title: "Edit",
                                  type: 4,
                                  onClick: () {
                                    Navigator.pushNamed(context, EditProfilePage.RouteName,
                                     arguments: ProfileArguments(userData)
                                     );
                                  },
                                ),
                              ),
                            )

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

  getProfileDetails(){

  }
}
