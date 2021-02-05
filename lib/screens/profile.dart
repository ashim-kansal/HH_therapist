import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/api/User_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
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

  String name;
  String email;
  String phone;
  String address;
  String profilepic;

  Result userData;

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
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
    return MyWidget(
      title: AppLocalizations.of(context).Profile, 
      child: SingleChildScrollView(
      child: Column(children: [
              Material(
                child: ClipPath(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    color: Colors.white,
                    child: SingleChildScrollView(
                        child:FutureBuilder<UserProfile>(
                            future: userAPIServices.getProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Center(child: Text(AppLocalizations.of(context).error),);
                                }

                                if(snapshot.data == null){
                                  return Center(child: Text(AppLocalizations.of(context).no_record_found),);
                                }

                                // setState(() {
                                //   widget.therapists = snapshot.data.result;
                                // });

                                return  Column(
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
                                                  backgroundImage: NetworkImage(snapshot.data.result.profilePic) ,
                                                  radius: 46,
                                                ),
                                              )
                                          ),

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
                                                      title: AppLocalizations.of(context).name,
                                                      size: 18,
                                                      textweight: FontWeight.w500,
                                                      color: Color(0xff777CEA)
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  child:HHTextView(
                                                    title: snapshot.data.result.firstName+ " "+snapshot.data.result.lastName,
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
                                                      title: AppLocalizations.of(context).email,
                                                      size: 18,
                                                      textweight: FontWeight.w500,
                                                      color: Color(0xff777CEA)
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  child:HHTextView(
                                                    title: snapshot.data.result.email,
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
                                                      title: AppLocalizations.of(context).phone_number,
                                                      size: 18,
                                                      textweight: FontWeight.w500,
                                                      color: Color(0xff777CEA)
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  alignment: Alignment.topLeft,
                                                  child:HHTextView(
                                                    title: snapshot.data.result.mobileNumber,
                                                    size: 14,
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
                                        padding: EdgeInsets.fromLTRB(5, 50, 5, 15),
                                        child: HHButton(
                                          isEnable: true,
                                          title: AppLocalizations.of(context).edit,
                                          type: 4,
                                          onClick: () {
                                            Navigator.push( context, MaterialPageRoute( builder: (context) => EditProfilePage(data: snapshot.data.result)), )
                                                .then((value){
                                              // setState(() {
                                              setState(() {

                                              });
                                              // });
                                            });


                                            // Navigator.pushNamed(context, EditProfilePage.RouteName, arguments: ProfileArguments(userData)).whenComplete(getprofile());
                                          },
                                        ),
                                      ),
                                    )

                                  ],
                                );
                              } else
                                return Container(
                                  child: Center(child: CircularProgressIndicator(),),
                                );
                            })
                  ),
                  ),
                ),
                // elevation: 8.0,
                // shadowColor: Colors.black38,
                // borderRadius: BorderRadius.circular(8.0),
                // borderOnForeground: true,
              ),
            ],
          ),
          // backgroundColor: Colors.white,
      )
    );
    
  }
    
  //   Scaffold(
  //       appBar: AppBar(
  //         title: Text(AppLocalizations.of(context).Profile, style: TextStyle(color: Colors.white)),
  //         centerTitle: true,
  //         iconTheme: IconThemeData(
  //           color: Colors.white, //change your color here
  //         ),
  //         backgroundColor: Theme.of(context).accentColor,
  //         elevation: 0,

  //       ),

  //       body: Material(
  //         color: Theme.of(context).accentColor,
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //             padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(30.0),
  //                   topLeft: Radius.circular(30.0),
  //                 ),
  //                 color: Colors.white),
  //             child: Column(
  //               children: [
  //                 Material(
  //                   child: ClipPath(
  //                     child: Container(
  //                       padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
  //                       color: Colors.white,
  //                       child: SingleChildScrollView(
  //                           child:FutureBuilder<UserProfile>(
  //                               future: userAPIServices.getProfile(),
  //                               builder: (context, snapshot) {
  //                                 if (snapshot.connectionState == ConnectionState.done) {
  //                                   if (snapshot.hasError) {
  //                                     return Center(child: Text(AppLocalizations.of(context).error),);
  //                                   }

  //                                   if(snapshot.data == null){
  //                                     return Center(child: Text(AppLocalizations.of(context).no_record_found),);
  //                                   }

  //                                   // setState(() {
  //                                   //   widget.therapists = snapshot.data.result;
  //                                   // });

  //                                   return  Column(
  //                                     mainAxisSize: MainAxisSize.min,
  //                                     children: <Widget>[

  //                                       Padding(
  //                                         padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
  //                                         child: Stack(
  //                                           children: <Widget>[
  //                                             Container(
  //                                                 decoration: new BoxDecoration(color: Colors.white),
  //                                                 alignment: Alignment.center,
  //                                                 child: CircleAvatar(
  //                                                   radius: 55,
  //                                                   backgroundColor: HH_Colors.color_F2EEEE,
  //                                                   child: CircleAvatar(
  //                                                     backgroundImage: NetworkImage(snapshot.data.result.profilePic) ,
  //                                                     radius: 46,
  //                                                   ),
  //                                                 )
  //                                             ),

  //                                           ],
  //                                         ),
  //                                       ),

  //                                       Flexible(

  //                                           child: Column(children: [
  //                                             Container(
  //                                                 alignment: Alignment.topLeft,
  //                                                 margin: const EdgeInsets.all(15.0),
  //                                                 padding: const EdgeInsets.all(3.0),
  //                                                 decoration: BoxDecoration(
  //                                                     border: Border(bottom: BorderSide(
  //                                                         color: HH_Colors.borderGrey,
  //                                                         width: 0.5
  //                                                     ))
  //                                                 ),
  //                                                 child: Column(children: [
  //                                                   Container(
  //                                                     alignment: Alignment.topLeft,
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
  //                                                     child: HHTextView(
  //                                                         title: AppLocalizations.of(context).name,
  //                                                         size: 18,
  //                                                         textweight: FontWeight.w500,
  //                                                         color: Color(0xff777CEA)
  //                                                     ),
  //                                                   ),
  //                                                   Container(
  //                                                     alignment: Alignment.topLeft,
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
  //                                                     child:HHTextView(
  //                                                       title: snapshot.data.result.firstName+ " "+snapshot.data.result.lastName,
  //                                                       size: 14,
  //                                                       color: HH_Colors.grey_585858,
  //                                                       textweight: FontWeight.w400,
  //                                                     ),
  //                                                   )
  //                                                 ],)
  //                                             ),
  //                                             Container(
  //                                                 alignment: Alignment.topLeft,
  //                                                 margin: const EdgeInsets.all(10.0),
  //                                                 padding: const EdgeInsets.all(3.0),
  //                                                 decoration: BoxDecoration(
  //                                                     border: Border(bottom: BorderSide(
  //                                                         color: HH_Colors.borderGrey,
  //                                                         width: 0.5
  //                                                     ))
  //                                                 ),
  //                                                 child: Column(children: [
  //                                                   Container(
  //                                                     alignment: Alignment.topLeft,
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
  //                                                     child: HHTextView(
  //                                                         title: AppLocalizations.of(context).email,
  //                                                         size: 18,
  //                                                         textweight: FontWeight.w500,
  //                                                         color: Color(0xff777CEA)
  //                                                     ),
  //                                                   ),
  //                                                   Container(
  //                                                     alignment: Alignment.topLeft,
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
  //                                                     child:HHTextView(
  //                                                       title: snapshot.data.result.email,
  //                                                       size: 14,
  //                                                       color: HH_Colors.grey_585858,
  //                                                       textweight: FontWeight.w400,
  //                                                     ),
  //                                                   )
  //                                                 ],)
  //                                             ),
  //                                             Container(
  //                                                 alignment: Alignment.topLeft,
  //                                                 margin: const EdgeInsets.all(10.0),
  //                                                 padding: const EdgeInsets.all(3.0),
  //                                                 decoration: BoxDecoration(
  //                                                     border: Border(bottom: BorderSide(
  //                                                         color: HH_Colors.borderGrey,
  //                                                         width: 0.5
  //                                                     ))
  //                                                 ),
  //                                                 child: Column(children: [
  //                                                   Container(
  //                                                     alignment: Alignment.topLeft,
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
  //                                                     child: HHTextView(
  //                                                         title: AppLocalizations.of(context).phone_number,
  //                                                         size: 18,
  //                                                         textweight: FontWeight.w500,
  //                                                         color: Color(0xff777CEA)
  //                                                     ),
  //                                                   ),
  //                                                   Container(
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
  //                                                     alignment: Alignment.topLeft,
  //                                                     child:HHTextView(
  //                                                       title: snapshot.data.result.mobileNumber,
  //                                                       size: 14,
  //                                                       color: HH_Colors.grey_585858,
  //                                                       textweight: FontWeight.w400,
  //                                                     ),
  //                                                   )
  //                                                 ],)
  //                                             ),
  //                                             Container(
  //                                                 alignment: Alignment.topLeft,
  //                                                 margin: const EdgeInsets.all(10.0),
  //                                                 padding: const EdgeInsets.all(3.0),
  //                                                 decoration: BoxDecoration(
  //                                                     border: Border(bottom: BorderSide(
  //                                                         color: HH_Colors.borderGrey,
  //                                                         width: 0.5
  //                                                     ))
  //                                                 ),
  //                                                 child: Column(children: [
  //                                                   Container(
  //                                                     alignment: Alignment.topLeft,
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
  //                                                     child: HHTextView(
  //                                                         title: AppLocalizations.of(context).address,
  //                                                         size: 18,
  //                                                         textweight: FontWeight.w500,
  //                                                         color: Color(0xff777CEA)
  //                                                     ),
  //                                                   ),
  //                                                   Container(
  //                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
  //                                                     alignment: Alignment.topLeft,
  //                                                     child:  HHTextView(
  //                                                       title: snapshot.data.result.address,
  //                                                       size: 16,
  //                                                       color: HH_Colors.grey_585858,
  //                                                       textweight: FontWeight.w400,
  //                                                     ),
  //                                                   )
  //                                                 ],)
  //                                             ),
  //                                           ],)
  //                                       ),
  //                                       Align(
  //                                         alignment: Alignment.bottomCenter,
  //                                         child: Padding(
  //                                           padding: EdgeInsets.fromLTRB(5, 50, 5, 15),
  //                                           child: HHButton(
  //                                             isEnable: true,
  //                                             title: AppLocalizations.of(context).edit,
  //                                             type: 4,
  //                                             onClick: () {
  //                                               Navigator.push( context, MaterialPageRoute( builder: (context) => EditProfilePage(data: snapshot.data.result)), )
  //                                                   .then((value){
  //                                                 // setState(() {
  //                                                 setState(() {

  //                                                 });
  //                                                 // });
  //                                               });


  //                                               // Navigator.pushNamed(context, EditProfilePage.RouteName, arguments: ProfileArguments(userData)).whenComplete(getprofile());
  //                                             },
  //                                           ),
  //                                         ),
  //                                       )

  //                                     ],
  //                                   );
  //                                 } else
  //                                   return Container(
  //                                     child: Center(child: CircularProgressIndicator(),),
  //                                   );
  //                               })
  //                     ),
  //                     ),
  //                   ),
  //                   // elevation: 8.0,
  //                   // shadowColor: Colors.black38,
  //                   // borderRadius: BorderRadius.circular(8.0),
  //                   // borderOnForeground: true,
  //                 ),
  //               ],
  //             )),
  //         // backgroundColor: Colors.white,
  //         // This trailing comma makes auto-formatting nicer for build methods.
  //       ));
  // }

  getProfileDetails(){

  }
}
