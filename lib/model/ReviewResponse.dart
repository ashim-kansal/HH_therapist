// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) => ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  ReviewResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
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
    this.status,
    this.id,
    this.sessionId,
    this.givenBy,
    this.givenTo,
    this.feedback,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String status;
  String id;
  String sessionId;
  String givenBy;
  String givenTo;
  String feedback;
  String rating;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    id: json["_id"],
    sessionId: json["sessionId"],
    givenBy: json["givenBy"],
    givenTo: json["givenTo"],
    feedback: json["feedback"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "sessionId": sessionId,
    "givenBy": givenBy,
    "givenTo": givenTo,
    "feedback": feedback,
    "rating": rating,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
