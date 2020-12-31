// To parse this JSON data, do
//
//     final submitAssessmentResponse = submitAssessmentResponseFromJson(jsonString);

import 'dart:convert';

SubmitAssessmentResponse submitAssessmentResponseFromJson(String str) => SubmitAssessmentResponse.fromJson(json.decode(str));

String submitAssessmentResponseToJson(SubmitAssessmentResponse data) => json.encode(data.toJson());

class SubmitAssessmentResponse {
  SubmitAssessmentResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory SubmitAssessmentResponse.fromJson(Map<String, dynamic> json) => SubmitAssessmentResponse(
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
    this.programId,
    this.title,
    this.questions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalMarks,
    this.correctMarks,
    this.patientId,
    this.formId,
  });

  String status;
  String id;
  String programId;
  String title;
  List<Question> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int totalMarks;
  int correctMarks;
  String patientId;
  String formId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    id: json["_id"],
    programId: json["programId"],
    title: json["title"],
    questions: List<Question>.from(json["Questions"].map((x) => Question.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    totalMarks: json["totalMarks"],
    correctMarks: json["correctMarks"],
    patientId: json["patientId"],
    formId: json["formId"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "programId": programId,
    "title": title,
    "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "totalMarks": totalMarks,
    "correctMarks": correctMarks,
    "patientId": patientId,
    "formId": formId,
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
    answer: json["Answer"],
  );

  Map<String, dynamic> toJson() => {
    "marks": marks,
    "_id": id,
    "QuestionNumber": questionNumber,
    "QuestionType": questionType,
    "QuestionText": questionText,
    "Answer": answer,
  };
}
