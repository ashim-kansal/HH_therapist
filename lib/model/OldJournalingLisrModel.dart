// To parse this JSON data, do
//
//     final oldJournalingList = oldJournalingListFromJson(jsonString);

import 'dart:convert';

OldJournalingList oldJournalingListFromJson(String str) => OldJournalingList.fromJson(json.decode(str));

String oldJournalingListToJson(OldJournalingList data) => json.encode(data.toJson());

class OldJournalingList {
    OldJournalingList({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;

    factory OldJournalingList.fromJson(Map<String, dynamic> json) => OldJournalingList(
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
        this.questions,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String status;
    String id;
    List<Question> questions;
    String userId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        id: json["_id"],
        questions: List<Question>.from(json["Questions"].map((x) => Question.fromJson(x))),
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Question {
    Question({
        this.answer,
        this.id,
        this.question,
    });

    String answer;
    String id;
    String question;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        answer: json["answer"],
        id: json["_id"],
        question: json["question"],
    );

    Map<String, dynamic> toJson() => {
        "answer": answer,
        "_id": id,
        "question": question,
    };
}
