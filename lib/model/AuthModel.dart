import 'package:flutter_app/common/SharedPreferences.dart';

class LoginResponseModel {
  final String token;
  final String deviceToken;
  final String appLanguage;
  final bool notificationStatus;
  final bool programSubscribed;
  final String id;
  final String responseMsg;
  final int responseCode;

  LoginResponseModel({this.token, this.deviceToken, this.appLanguage, this.notificationStatus, this.programSubscribed, this.id, this.responseMsg, this.responseCode});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    print(json["responseMessage"]);
    if(json.containsKey("result")){
      SetStringToSP("uToken", json["result"]["token"]?? "");
      SetStringToSP("userId", json["result"]["_id"]?? "");
    }
    
    return LoginResponseModel(
      token: json.containsKey("result") ? json["result"]["token"]?? "" : "",
      deviceToken: json.containsKey("result") ? json["result"]["deviceToken"]?? "" : "",
      appLanguage: json.containsKey("result") ? json["result"]["appLanguage"]?? "" : "",
      notificationStatus: json.containsKey("result") ? json["result"]["notificationStatus"]?? false : false,
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}

class ForgotPasswordModel {
  final String userid;
  final String responseMsg;
  final int responseCode;

  ForgotPasswordModel({this.userid, this.responseCode, this.responseMsg});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json){

    if(json.containsKey("result")){
      SetStringToSP("userId", json["result"]);
    }
    return ForgotPasswordModel(
      userid: json.containsKey("result")? json["result"]?? "" : "",
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404);
  }
}


class SignupResponseModel {
  final String response;
  final String token;
  final String userID;
  final String appLang;
  var notificationStatus;
  var programSubscribed;
  final String responseMsg;
  final int responseCode;
  final String deviceToken;

  SignupResponseModel({this.response, this.responseCode, this.responseMsg, this.token, this.userID, this.notificationStatus, this.appLang, this.programSubscribed, this.deviceToken});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    print("msgggg");
    print(json["responseMessage"]);
    if(json.containsKey("result")){
      SetStringToSP("uToken", json["result"]["token"]?? "");
      SetStringToSP("userId", json["result"]["_id"]?? "");
    }
    return SignupResponseModel(
      token: json.containsKey("result")? json["result"]["token"]?? "" : "",
      userID: json.containsKey("result")? json["result"]["_id"]?? "" : "",
      appLang: json.containsKey("result")? json["result"]["appLanguage"]?? "" : "",
      deviceToken: json.containsKey("result")? json["result"]["deviceToken"]?? "" : "",
      notificationStatus: json.containsKey("result")? json["result"]["notificationStatus"] : false,
      programSubscribed: json.containsKey("result")? json["result"]["programSubscribed"] : false,
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