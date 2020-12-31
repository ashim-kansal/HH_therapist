// To parse this JSON data, do
//
//     final cancelPlanResponse = cancelPlanResponseFromJson(jsonString);

import 'dart:convert';

CancelPlanResponse cancelPlanResponseFromJson(String str) => CancelPlanResponse.fromJson(json.decode(str));

String cancelPlanResponseToJson(CancelPlanResponse data) => json.encode(data.toJson());

class CancelPlanResponse {
  CancelPlanResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory CancelPlanResponse.fromJson(Map<String, dynamic> json) => CancelPlanResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.userType,
    this.appLanguage,
    this.deviceToken,
    this.profilePic,
    this.otpTime,
    this.verifyOtp,
    this.notificationStatus,
    this.programSubscribed,
    this.status,
    this.myTherapist,
    this.myPatient,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.countryCode,
    this.address,
    this.password,
    this.otp,
    this.mergeContact,
    this.permissions,
    this.questions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.programSubscription,
  });

  String userType;
  String appLanguage;
  String deviceToken;
  String profilePic;
  int otpTime;
  bool verifyOtp;
  bool notificationStatus;
  bool programSubscribed;
  String status;
  List<String> myTherapist;
  List<dynamic> myPatient;
  String id;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String countryCode;
  String address;
  String password;
  String otp;
  String mergeContact;
  List<dynamic> permissions;
  List<dynamic> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String programSubscription;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userType: json["userType"],
    appLanguage: json["appLanguage"],
    deviceToken: json["deviceToken"],
    profilePic: json["profilePic"],
    otpTime: json["otpTime"],
    verifyOtp: json["verifyOtp"],
    notificationStatus: json["notificationStatus"],
    programSubscribed: json["programSubscribed"],
    status: json["status"],
    myTherapist: List<String>.from(json["myTherapist"].map((x) => x)),
    myPatient: List<dynamic>.from(json["myPatient"].map((x) => x)),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    countryCode: json["countryCode"],
    address: json["address"],
    password: json["password"],
    otp: json["otp"],
    mergeContact: json["mergeContact"],
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    questions: List<dynamic>.from(json["Questions"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    programSubscription: json["programSubscription"],
  );

  Map<String, dynamic> toJson() => {
    "userType": userType,
    "appLanguage": appLanguage,
    "deviceToken": deviceToken,
    "profilePic": profilePic,
    "otpTime": otpTime,
    "verifyOtp": verifyOtp,
    "notificationStatus": notificationStatus,
    "programSubscribed": programSubscribed,
    "status": status,
    "myTherapist": List<dynamic>.from(myTherapist.map((x) => x)),
    "myPatient": List<dynamic>.from(myPatient.map((x) => x)),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "countryCode": countryCode,
    "address": address,
    "password": password,
    "otp": otp,
    "mergeContact": mergeContact,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "Questions": List<dynamic>.from(questions.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "programSubscription": programSubscription,
  };
}
