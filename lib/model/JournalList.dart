// To parse this JSON data, do
//
//     final journalList = journalListFromJson(jsonString);

import 'dart:convert';

JournalList journalListFromJson(String str) => JournalList.fromJson(json.decode(str));

String journalListToJson(JournalList data) => json.encode(data.toJson());

class JournalList {
    JournalList({
        this.responseCode,
        this.responseMessage,
        this.result,
        this.paginationData,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;
    PaginationData paginationData;

    factory JournalList.fromJson(Map<String, dynamic> json) => JournalList(
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
