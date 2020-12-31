// To parse this JSON data, do
//
//     final myPlanResponse = myPlanResponseFromJson(jsonString);

import 'dart:convert';

MyPlanResponse myPlanResponseFromJson(String str) => MyPlanResponse.fromJson(json.decode(str));

String myPlanResponseToJson(MyPlanResponse data) => json.encode(data.toJson());

class MyPlanResponse {
  MyPlanResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory MyPlanResponse.fromJson(Map<String, dynamic> json) => MyPlanResponse(
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
    this.id,
    this.programSubscription,
  });

  String id;
  ProgramSubscription programSubscription;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    programSubscription: ProgramSubscription.fromJson(json["programSubscription"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "programSubscription": programSubscription.toJson(),
  };
}

class ProgramSubscription {
  ProgramSubscription({
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

  factory ProgramSubscription.fromJson(Map<String, dynamic> json) => ProgramSubscription(
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
