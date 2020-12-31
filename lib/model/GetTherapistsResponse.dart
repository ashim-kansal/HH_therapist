// To parse this JSON data, do
//
//     final getTherapistsResponse = getTherapistsResponseFromJson(jsonString);

import 'dart:convert';

GetTherapistsResponse getTherapistsResponseFromJson(String str) => GetTherapistsResponse.fromJson(json.decode(str));

String getTherapistsResponseToJson(GetTherapistsResponse data) => json.encode(data.toJson());

class GetTherapistsResponse {
  GetTherapistsResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
    this.paginationData,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;
  PaginationData paginationData;

  factory GetTherapistsResponse.fromJson(Map<String, dynamic> json) => GetTherapistsResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    paginationData: PaginationData.fromJson(json["paginationData"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "paginationData": paginationData.toJson(),
  };
}

class PaginationData {
  PaginationData({
    this.total,
    this.limit,
    this.page,
    this.pages,
  });

  int total;
  int limit;
  int page;
  int pages;

  factory PaginationData.fromJson(Map<String, dynamic> json) => PaginationData(
    total: json["total"],
    limit: json["limit"],
    page: json["page"],
    pages: json["pages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "page": page,
    "pages": pages,
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
    this.countryCode,
    this.mobileNumber,
    this.speciality,
    this.degree,
    this.institution,
    this.role,
    this.programId,
    this.password,
    this.mergeContact,
    this.permissions,
    this.questions,
    this.createdAt,
    this.updatedAt,
    this.v,
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
  List<dynamic> myTherapist;
  List<dynamic> myPatient;
  String id;
  String firstName;
  String lastName;
  String email;
  String countryCode;
  String mobileNumber;
  String speciality;
  String degree;
  String institution;
  String role;
  String programId;
  String password;
  String mergeContact;
  List<dynamic> permissions;
  List<dynamic> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

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
    myTherapist: List<dynamic>.from(json["myTherapist"].map((x) => x)),
    myPatient: List<dynamic>.from(json["myPatient"].map((x) => x)),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    countryCode: json["countryCode"],
    mobileNumber: json["mobileNumber"],
    speciality: json["speciality"],
    degree: json["degree"],
    institution: json["institution"],
    role: json["role"],
    programId: json["programId"],
    password: json["password"],
    mergeContact: json["mergeContact"],
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    questions: List<dynamic>.from(json["Questions"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "countryCode": countryCode,
    "mobileNumber": mobileNumber,
    "speciality": speciality,
    "degree": degree,
    "institution": institution,
    "role": role,
    "programId": programId,
    "password": password,
    "mergeContact": mergeContact,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "Questions": List<dynamic>.from(questions.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
