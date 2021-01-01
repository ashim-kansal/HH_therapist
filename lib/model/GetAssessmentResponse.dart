// To parse this JSON data, do
//
//     final getAssessmentResponse = getAssessmentResponseFromJson(jsonString);

import 'dart:convert';

GetAssessmentResponse getAssessmentResponseFromJson(String str) => GetAssessmentResponse.fromJson(json.decode(str));

String getAssessmentResponseToJson(GetAssessmentResponse data) => json.encode(data.toJson());

class GetAssessmentResponse {
  GetAssessmentResponse({
    this.responseCode,
    this.responseMessage,
    this.results,
    this.totalpage,
    this.total,
  });

  int responseCode;
  String responseMessage;
  List<Result> results;
  int totalpage;
  int total;

  factory GetAssessmentResponse.fromJson(Map<String, dynamic> json) => GetAssessmentResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalpage: json["totalpage"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "totalpage": totalpage,
    "total": total,
  };
}

class Result {
  Result({
    this.formId,
    this.userSubmit,
    this.status,
    this.programId,
    this.title,
    this.questions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSubmit,
  });

  String formId;
  List<dynamic> userSubmit;
  String status;
  String programId;
  String title;
  List<Question> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isSubmit;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    formId: json["_id"],
    userSubmit: List<dynamic>.from(json["userSubmit"].map((x) => x)),
    status: json["status"],
    programId: json["programId"],
    title: json["title"],
    questions: List<Question>.from(json["Questions"].map((x) => Question.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isSubmit: json["isSubmit"],
  );

  Map<String, dynamic> toJson() => {
    // "_id": id,
    "formId": formId,
    "userSubmit": List<dynamic>.from(userSubmit.map((x) => x)),
    "status": status,
    "programId": programId,
    "title": title,
    "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "isSubmit": isSubmit,
  };
}

class Question {
  Question({
    this.marks,
    this.id,
    this.questionNumber,
    this.questionType,
    this.questionText,
    this.answer,
  });

  int marks;
  String id;
  int questionNumber;
  String questionType;
  String questionText;
  String answer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    marks: json["marks"],
    id: json["_id"],
    questionNumber: json["QuestionNumber"],
    questionType: json["QuestionType"],
    questionText: json["QuestionText"],
    answer: json["Answer"] == null ? null : json["Answer"],
  );

  Map<String, dynamic> toJson() => {
    "marks": marks,
    "_id": id,
    "QuestionNumber": questionNumber,
    "QuestionType": questionType,
    "QuestionText": questionText,
    "Answer": answer == null ? null : answer,
  };
}
