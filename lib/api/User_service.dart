
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/SettingModel.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAPIServices {
  Future<UserProfile> getProfile() async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"therapist/myProfile";
    
    final response = await http.get(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token??HHString.token},
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return UserProfile.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }


  // forgot password 
  Future<FeedbackResponseModel> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    final url = HHString.baseURL +"therapist/changePassword";
    var token = await GetStringToSP("token");
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token
    },
      body: jsonEncode(<String, String>{
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      })
    );
    
    var res = json.decode(response.body);

    if(response.statusCode == 200){
      if(res["responseCode"] == 200){
        return FeedbackResponseModel.fromJson(json.decode(response.body));
      }
    }else {
      throw Exception('Failed to load data!');
    }
  }

  Future<FeedbackResponseModel> updateProfile(String imagebase64) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"therapist/uploadImage";
    
    final response = await http.post(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "image": imagebase64,
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return FeedbackResponseModel.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }

  // update Profile 
  Future<UserProfile> updateProfileDetails(String fname, String lname, String phone, String address, String image) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"therapist/updateProfile";
    
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "firstName": fname,
        "lastName": lname,
        "mobileNumber": phone,
        "profilePic": image,
        "address": address
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return UserProfile.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }
}