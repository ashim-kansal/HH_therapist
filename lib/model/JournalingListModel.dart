// To parse this JSON data, do
//
//     final journalingList = journalingListFromJson(jsonString);

import 'dart:convert';

JournalingList journalingListFromJson(String str) => JournalingList.fromJson(json.decode(str));

String journalingListToJson(JournalingList data) => json.encode(data.toJson());

class JournalingList {
    JournalingList({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;

    factory JournalingList.fromJson(Map<String, dynamic> json) => JournalingList(
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
        this.status,
        this.id,
        this.question,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String status;
    String id;
    String question;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        id: json["_id"],
        question: json["question"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "question": question,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
