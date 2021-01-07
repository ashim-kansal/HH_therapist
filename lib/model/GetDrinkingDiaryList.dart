// To parse this JSON data, do
//
//     final getDrinkingDiaryList = getDrinkingDiaryListFromJson(jsonString);

import 'dart:convert';

GetDrinkingDiaryList getDrinkingDiaryListFromJson(String str) => GetDrinkingDiaryList.fromJson(json.decode(str));

String getDrinkingDiaryListToJson(GetDrinkingDiaryList data) => json.encode(data.toJson());

class GetDrinkingDiaryList {
  GetDrinkingDiaryList({
    this.responseCode,
    this.responseMessage,
    this.result,
    this.paginationData,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;
  PaginationData paginationData;

  factory GetDrinkingDiaryList.fromJson(Map<String, dynamic> json) => GetDrinkingDiaryList(
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
    this.achivedGoal,
    this.date,
    this.id,
    this.userId,
    this.setGoal,
    this.isSelected,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int achivedGoal;
  DateTime date;
  String id;
  String userId;
  bool isSelected = false;
  int setGoal;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    achivedGoal: json["achivedGoal"],
    date: DateTime.parse(json["date"]),
    id: json["_id"],
    userId: json["userId"],
    setGoal: json["setGoal"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "achivedGoal": achivedGoal,
    "date": date.toIso8601String(),
    "_id": id,
    "userId": userId,
    "setGoal": setGoal,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
