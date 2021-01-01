import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/BuyPlanResponse.dart';
import 'package:flutter_app/model/CancelPlanResponse.dart';
import 'package:flutter_app/model/GetProgramsResponse.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/MyPlanResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  String url = HHString.baseURL+"/api/v1/user";

  Future<GetProgramsResponse> getAllPrograms() async {
    var token = await GetStringToSP("token");

    final response = await http.get(url+"/programList",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'token' : token
        });
    print(response.body);
    return getProgramsResponseFromJson(response.body);

  }

  Future<MyPlanResponse> getMyPrograms() async {
    var token = await GetStringToSP("token");

    final response = await http.get(url+"/myProgram",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'token' : token
        });
    print(response.body);
    return myPlanResponseFromJson(response.body);

  }

  Future<CancelPlanResponse> cancelPrograms() async {
    var token = await GetStringToSP("token");
    final response = await http.get(url+"/cancelProgram",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'token' : token
        });
    print(response.body);
    return cancelPlanResponseFromJson(response.body);

  }

  Future<BuyPlanResponse> buyPlan(String planId, String amount) async {
    var token = await GetStringToSP("token");

    final response = await http.post(url+"/payment",
        body: jsonEncode(<String,String>{
          "programId":planId,
          "cardNumber":"4242424242424242",
          "expMonth":"02",
          "expYear":"2021",
          "cvc":"123",
          "amount":amount,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'token' : token
        });
    print(response.body);
    return buyPlanResponseFromJson(response.body);

  }

