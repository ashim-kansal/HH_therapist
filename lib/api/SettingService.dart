
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/SettingModel.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingAPIService {
  Future<FeedbackResponseModel> submitFeedback(String feedback) async {

    var token = await GetStringToSP("token");
    var userId = await GetStringToSP("userId");
    final url = HHString.baseURL +"/api/v1/therapist/feedback";
    
    final response = await http.post(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "feedback": feedback,
        "sessionId": userId,
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return FeedbackResponseModel.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }


  // forgot password 
  Future<FeedbackResponseModel> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    final url = HHString.baseURL +"/api/v1/therapist/changePassword";
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

  // chnage notification status 

  Future<UserProfile> updateNotificationStatus(bool value) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/setNotification";
    
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token??HHString.token},
      body: jsonEncode(<String, bool>{
        "notificationStatus": value,
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return UserProfile.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }

  // Change Language

  Future<UserProfile> changeLanguage(String value) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/setNotification";
    
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "appLanguage": value,
      })
    );
  
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return UserProfile.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }


  Future<FeedbackResponseModel> updateProfile(String imagebase64) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/uploadImage";
    
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

}