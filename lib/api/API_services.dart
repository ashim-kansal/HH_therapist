
import 'dart:io';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/ClientListing.dart';
import 'package:flutter_app/model/CommonModel.dart';
import 'package:flutter_app/model/JournalingListModel.dart';
import 'package:flutter_app/model/LibraryModel.dart';
import 'package:flutter_app/model/NotificationList.dart';
import 'package:flutter_app/model/OldJournalingLisrModel.dart';
import 'package:flutter_app/model/QuestionarieModel.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<LibraryList> getLibraryList() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/therapist/library_list";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },);
  print(response.body);
  return libraryListFromJson(response.body);
}

Future<UpcomingSession> upcomingSessions() async {
  var token = await GetStringToSP("token");
  print(token);
  final url = HHString.baseURL +"/api/v1/therapist/upcomingSessionList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  print(response.body);
  return upcomingSessionFromJson(response.body);
}

Future<UpcomingSession> completedSessoins() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/therapist/completedSessionList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  print(response.body);
  return upcomingSessionFromJson(response.body);
}

Future<JournalingList> getJournalingList() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/therapist/journalQuestion_list";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  return journalingListFromJson(response.body);
}

// fetch old journal 
Future<OldJournalingList> getOldJournalingList() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/therapist/old_journalList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token?? HHString.token
      },);
  return oldJournalingListFromJson(response.body);
}

// fetch old journal 
Future<QuestionarieList> getQuestionaire(programId) async {
  var token = await GetStringToSP("token");

  var pid = "5fd9d4e69a512f3059c0f272";
  final url = HHString.baseURL +"/api/v1/therapist/getQuestionnaire?programId="+pid;
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token?? HHString.token
      },);
  return questionarieListFromJson(response.body);
}
// fetch drinkingDairy_details
Future<QuestionarieList> getdrinkingDairyDetails() async {
  var token = await GetStringToSP("token");

  final url = HHString.baseURL +"/api/v1/therapist/drinkingDairy_details";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },);
  return questionarieListFromJson(response.body);
}


// fetch drinkingDairy_details
Future<NotificationListing> getNotificationList() async {
  var token = await GetStringToSP("token");

  final url = HHString.baseURL +"/api/v1/therapist/notificationList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  return notificationListFromJson(response.body);
}


// fetch drinkingDairy_details
Future<MyClientList> getMyClientList() async {
  var token = await GetStringToSP("token");

  final url = HHString.baseURL +"/api/v1/therapist/myClient_List";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  return myClientListFromJson(response.body);
}

class InAppAPIServices {
  // submit journal
  Future<CommonResponse> submitJournal(params) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/fill_journal";
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token?? HHString.token
        },
        body:  jsonEncode({
          "Questions": params})
      );
    if(response.statusCode == 200){
      return CommonResponse.fromJson(json.decode(response.body));
    }else {
        throw Exception('Failed to load data!');
      }
  }

  //cancel session 
  Future<CommonResponse> cancelSession(sessionID) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/cancelSession";
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token?? HHString.token
        },
        body:  jsonEncode({
          "sessionId": sessionID})
      );
    if(response.statusCode == 200){
      return CommonResponse.fromJson(json.decode(response.body));
    }else {
        throw Exception('Failed to load data!');
      }
  }

  //get notification list
   Future<CommonResponse> deleteNotification(String id) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/deleteNotification?notificationId="+id;
    final response = await http.delete(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token?? HHString.token
        }
      );
    print(response.body);
    if(response.statusCode == 200){
      return CommonResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception("Failed to delete notification");
    }
  }

  //submit query 
  Future<CommonResponse> submitQuery(String msg) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/therapist/query";
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token?? HHString.token
        },
        body: jsonEncode({
          "query": msg})
      );
    if(response.statusCode == 200){
      return CommonResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception("Failed to delete notification");
    }
  }
}



