// To parse this JSON data, do
//
//     final getProgramsResponse = getProgramsResponseFromJson(jsonString);

import 'dart:convert';

GetProgramsResponse getProgramsResponseFromJson(String str) => GetProgramsResponse.fromJson(json.decode(str));

String getProgramsResponseToJson(GetProgramsResponse data) => json.encode(data.toJson());

class GetProgramsResponse {
  GetProgramsResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;

  factory GetProgramsResponse.fromJson(Map<String, dynamic> json) => GetProgramsResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.programType,
    this.status,
    this.id,
    this.title,
    this.amount,
    this.therapistSession,
    this.physicianSession,
    this.caseManagerSession,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String programType;
  String status;
  String id;
  String title;
  String amount;
  int therapistSession;
  int physicianSession;
  int caseManagerSession;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    programType: json["programType"],
    status: json["status"],
    id: json["_id"],
    title: json["title"],
    amount: json["amount"],
    therapistSession: json["therapist_session"],
    physicianSession: json["physician_session"],
    caseManagerSession: json["caseManager_session"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "programType": programType,
    "status": status,
    "_id": id,
    "title": title,
    "amount": amount,
    "therapist_session": therapistSession,
    "physician_session": physicianSession,
    "caseManager_session": caseManagerSession,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
