import 'package:flutter_app/common/SharedPreferences.dart';


class FeedbackResponseModel {
  // final String userid;
  final String responseMsg;
  final int responseCode;

  FeedbackResponseModel({
    // this.userid, 
    this.responseCode, this.responseMsg});

  factory FeedbackResponseModel.fromJson(Map<String, dynamic> json){
    return FeedbackResponseModel(
      // userid: json["result"]?? "",
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404);
  }
}

class SignupModel {
  final String response;

  final String responseMsg;
  final int responseCode;


  SignupModel({this.response, this.responseCode, this.responseMsg});

  factory SignupModel.fromJson(Map<String, dynamic> json){
    return SignupModel(
      response: json["result"]?? "",
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404);
  }
}

class CountryResponse {
  final String response;

  final String responseMsg;
  final int responseCode;


  CountryResponse({this.response, this.responseCode, this.responseMsg});

  factory CountryResponse.fromJson(Map<String, dynamic> json){
    return CountryResponse(
      response: json["result"]?? "",
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404);
  }
}