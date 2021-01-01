// To parse this JSON data, do
//
//     final staticContent = staticContentFromJson(jsonString);

import 'dart:convert';

class StaticContentModel {
  final Object result;
  final String responseMsg;
  final int responseCode;

  StaticContentModel({this.result, this.responseCode, this.responseMsg});

  factory StaticContentModel.fromJson(Map<String, dynamic> json){
    return StaticContentModel(
      result: json["result"]?? "",
      responseMsg: json["responseMessage"]?? "Some error occured. Please try again.",
      responseCode: json["responseCode"]?? 404);
  }
}

StaticContent staticContentFromJson(String str) => StaticContent.fromJson(json.decode(str));

String staticContentToJson(StaticContent data) => json.encode(data.toJson());

class StaticContent {
    StaticContent({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    Result result;

    factory StaticContent.fromJson(Map<String, dynamic> json) => StaticContent(
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
        this.type,
        this.status,
        this.id,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String type;
    String status;
    String id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json["Type"],
        status: json["status"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "Type": type,
        "status": status,
        "_id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
