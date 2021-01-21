
import 'dart:io';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/ChatList.dart';
import 'package:flutter_app/model/ClientListing.dart';
import 'package:flutter_app/model/CommonModel.dart';
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';
import 'package:flutter_app/model/GetTokenResponse.dart';
import 'package:flutter_app/model/JournalingListModel.dart';
import 'package:flutter_app/model/LibraryModel.dart';
import 'package:flutter_app/model/NotificationList.dart';
import 'package:flutter_app/model/OldJournalingLisrModel.dart';
import 'package:flutter_app/model/PatientAssesmentList.dart';
import 'package:flutter_app/model/PatientNotesList.dart';
import 'package:flutter_app/model/QuestionarieModel.dart';
import 'package:flutter_app/model/ReviewResponse.dart';
import 'package:flutter_app/model/SendMessageResponse.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<LibraryList> getLibraryList() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"therapist/library_list";
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
  final url = HHString.baseURL +"therapist/upcomingSessionList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  print(response.body);
  print('hhhhhhhhhhhhhhhhhhhhhhhhhh'+upcomingSessionFromJson(response.body).result.length.toString());

  return upcomingSessionFromJson(response.body);
}

Future<UpcomingSession> completedSessoins() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"therapist/completedSessionList";
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
  final url = HHString.baseURL +"therapist/journalQuestion_list";
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
  final url = HHString.baseURL +"therapist/old_journalList";
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

  final url = HHString.baseURL +"therapist/getQuestionnaire?programId="+programId;
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

  final url = HHString.baseURL +"therapist/drinkingDairy_details";
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

  final url = HHString.baseURL +"therapist/notificationList";
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

  final url = HHString.baseURL +"therapist/myClient_List";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  print(response.body);
  return myClientListFromJson(response.body);
}

// fetch notes listing
Future<PatientNotesList> getPatientNotes(id) async {
  var token = await GetStringToSP("token");

  final url = HHString.baseURL +"therapist/client_notes_list?patientId="+id;
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  return patientNotesListFromJson(response.body);
}

// fetch chat listing
Future<ChatList> getChatList(senderid) async {
  var token = await GetStringToSP("token");
print(token);
print(jsonEncode({
  "chatId": "",
  "receiverId": senderid??""
}));

  final url = HHString.baseURL +"chat/chatHistory";
  final response = await http.post(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },
      body:  jsonEncode({
      // "chatId": chatId??"",
      "chatId": "",
      "receiverId": senderid??""
      })
      );
      print(response.body);
  return chatListFromJson(response.body);
}

Future<GetTokenResponse> getTwilioToken(roomName, identity, reciverId,programName) async {
  var token = await GetStringToSP("token");
  print(token);
  print(roomName);
  print(identity);
  print("rc  : "+reciverId);
  final url = HHString.baseURL +"video/tokenGenerate?user="+identity+"&room="+roomName;
  print(url);
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      });

  print(response.body);
  return getTokenResponseFromJson(response.body);
}


Future<GetTokenResponse> createCall(sessionId, reciverId) async {
  var token = await GetStringToSP("token");
  print(token);
  print(sessionId);
  print("rc  : "+reciverId);
  final url = HHString.baseURL +"video/createCall?receiverId="+reciverId+"&room=room_"+sessionId+"&sessionId="+sessionId;
  print(url);
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      });

  print(response.body);
  return getTokenResponseFromJson(response.body);
}

Future<GetTokenResponse> callConnected(reciverId, status) async {
  print("rc  : "+reciverId);
  final url = HHString.baseURL +"video/CallConnected?receiverId="+reciverId+"&status="+status;
  print(url);
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

  print(response.body);
  return getTokenResponseFromJson(response.body);
}

Future<ReviewResponse> submitSessionReview(sessionId, comments) async {
  var token = await GetStringToSP("token");
  print(token);
  print(sessionId);
  print(comments);
  final url = HHString.baseURL +"therapist/feedback";
  print(url);
  final response = await http.post(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },
      body:  jsonEncode({
        "sessionId": sessionId,
        "feedback": comments,
      })
  );

  print(response.body);
  return reviewResponseFromJson(response.body);
}



class InAppAPIServices {
  // submit journal
  Future<CommonResponse> submitJournal(params) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"therapist/fill_journal";
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
    final url = HHString.baseURL +"therapist/cancelSession";
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
    final url = HHString.baseURL +"therapist/deleteNotification?notificationId="+id;
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
    final url = HHString.baseURL +"therapist/query";
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

  Future<CommonResponse> addNote(String note, String patientId) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"therapist/addNotes";
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token?? HHString.token
        },
        body: jsonEncode({
          "patientId": patientId,
          "note": note})
      );
    if(response.statusCode == 200){
      return CommonResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception("Failed to add note");
    }
  }

  // fetch patient assesments list
  Future<PatientAssesmentList> getPatientAssesments(patientId) async {
    var token = await GetStringToSP("token");

    final url = HHString.baseURL +"therapist/patient_assessmentList?patientId="+patientId;
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token??HHString.token
        },);
    if(response.statusCode == 200){
      return patientAssesmentListFromJson(response.body);
    }else {
      throw Exception("Failed to add note");
    }
    
  }

  Future<GetDrinkingDiaryList> getDrinkingDiaryList(patientId) async {
    var token = await GetStringToSP("token");

    final url = HHString.baseURL +"therapist/drinkingDairy_details?userId="+patientId;
    final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token??HHString.token
        },);
    return getDrinkingDiaryListFromJson(response.body);
  }

   // fetch patient journal list
  Future<PatientAssesmentList> getPatientJournal(patientId) async {
    var token = await GetStringToSP("token");

    final url = HHString.baseURL +"therapist/patient_journals_List?patientId="+patientId;
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token??HHString.token
        },);
    if(response.statusCode == 200){
      return patientAssesmentListFromJson(response.body);
    }else {
      throw Exception("Failed to add note");
    }
    
  }

  Future<SendMessageResponse> sendMessage(receiverId, msg) async {
    var token = await GetStringToSP("token");
    print('sssss'+  receiverId);
    final url = HHString.baseURL +"chat/chatAPI";
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token??HHString.token
        },
        body: jsonEncode({
          "receiverId": receiverId,
          "message": msg
        }));

      print(response.body);

      return sendMessageResponseFromJson(response.body);
  }

  // add presription / handout
  Future<CommonResponse> addPrescription(String sessionId, File prescription, File library,String note) async {
   
    var token = await GetStringToSP("token");

    final url = HHString.baseURL +"therapist/addPrescription_handout";
    
    // print(
    //   jsonEncode({
    //      "sessionId": sessionId,
    //       "prescription": prescription??"",
    //       "library": library??"",
    //       "note": note??""
    //     })
    // );
    var request = http.MultipartRequest(
      'POST', Uri.parse(url),
    );
    Map<String,String> headers={
      "token": token??HHString.token,
      "session_id": sessionId,
      "Content-type": "multipart/form-data"
    };

    if(prescription != null){
      request.files.add(
        http.MultipartFile(
          'prescription',
          prescription.readAsBytes().asStream(),
          prescription.lengthSync(),
          filename: prescription.path.split("/").last,
        ),
      );
    }
    
    if(library != null){
      request.files.add(
        http.MultipartFile(
          'library',
          library.readAsBytes().asStream(),
          library.lengthSync(),
          filename: library.path.split("/").last,
        ),
      );
    }
    
    request.fields["note"] = note??"";
    request.headers.addAll(headers);
    print("request-1: "+request.toString());
    var res = await request.send();
    print(res);
    var response = await http.Response.fromStream(res);
    Map<String, dynamic> data = json.decode(response.body);
    print(response.body);

    // final response = await http.post(url,
    //     headers: {
    //       "Content-Type": "application/json",
    //       "token": token??HHString.token,
    //       "sessionId": sessionId},
        
    //     body: jsonEncode({
    //       "prescription": prescription??"",
    //       "library": library??"",
    //       "note": note??""
    //     }));

    //   print(response.body);

    if(response.statusCode == 200){
      return CommonResponse.fromJson(jsonDecode(response.body));
    }else {
      throw Exception("Failed to add note");
    }
  }
}



