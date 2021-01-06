import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/model/SubmitAssessmentResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;

String url = HHString.baseURL+"therapist";

Future<GetAssessmentResponse> getAllAssessments() async {

  var token = await GetStringToSP("token");
  final response = await http.get(url+"/get_Assessment_List",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      });
  print(response.body);
  return getAssessmentResponseFromJson(response.body);

}

Future<SubmitAssessmentResponse> getAssessments(clientId) async {
  var token = await GetStringToSP("token");
  print(url);

  final response = await http.get(url+"/viewPatient_questionnaire?userId="+clientId,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      }
  );
  print(clientId);
  print(response.body);
  return submitAssessmentResponseFromJson(response.body);

}
