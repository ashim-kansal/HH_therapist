import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/model/SubmitAssessmentResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;

String url = HHString.baseURL+"/api/v1/user";

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



Future<SubmitAssessmentResponse> submitAssessments(result) async {
  var token = await GetStringToSP("token");
  print(json.encode(result));

  final response = await http.post(url+"/submit_AssessmentForm",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      },
    body:json.encode(result)
  );
  print(response.body);
  return submitAssessmentResponseFromJson(response.body);

}
