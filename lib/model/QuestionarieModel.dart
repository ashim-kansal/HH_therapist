// To parse this JSON data, do
//
//     final questionarieList = questionarieListFromJson(jsonString);

import 'dart:convert';

QuestionarieList questionarieListFromJson(String str) => QuestionarieList.fromJson(json.decode(str));

String questionarieListToJson(QuestionarieList data) => json.encode(data.toJson());

class QuestionarieList {
    QuestionarieList({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;

    factory QuestionarieList.fromJson(Map<String, dynamic> json) => QuestionarieList(
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
        this.programId,
        this.questions,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String status;
    String id;
    String programId;
    List<Question> questions;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        id: json["_id"],
        programId: json["programId"],
        questions: List<Question>.from(json["Questions"].map((x) => Question.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "programId": programId,
        "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Question {
    Question({
        this.id,
        this.questionText,
        this.questionType,
        this.options,
        this.questionNumber,
    });

    String id;
    String questionText;
    String questionType;
    List<Option> options;
    String questionNumber;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        questionText: json["QuestionText"],
        questionType: json["QuestionType"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        questionNumber: json["QuestionNumber"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "QuestionText": questionText,
        "QuestionType": questionType,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "QuestionNumber": questionNumber,
    };
}

class Option {
    Option({
        this.id,
        this.option,
    });

    String id;
    String option;

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["_id"],
        option: json["option"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
    };
}
