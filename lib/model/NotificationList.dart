// To parse this JSON data, do
//
//     final libraryList = notificationListFromJson(jsonString);

import 'dart:convert';

NotificationListing notificationListFromJson(String str) => NotificationListing.fromJson(json.decode(str));

String notificationListToJson(NotificationListing data) => json.encode(data.toJson());

class NotificationListing {
    NotificationListing({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;

    factory NotificationListing.fromJson(Map<String, dynamic> json) => NotificationListing(
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
        this.userId,
        this.title,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

   String status;
    String id;
    String userId;
    String title;
    String body;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
         status: json["status"],
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
         "status": status,
        "_id": id,
        "userId": userId,
        "title": title,
        "body": body,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
