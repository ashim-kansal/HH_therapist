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
  List<Result> result;

  factory SubmitAssessmentResponse.fromJson(Map<String, dynamic> json) => SubmitAssessmentResponse(
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    this.answer,
    this.id,
    this.option,
  });

  String answer;
  String id;
  String option;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    answer: json["Answer"],
    id: json["_id"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "Answer": answer,
    "_id": id,
    "option": option,
  };
}
