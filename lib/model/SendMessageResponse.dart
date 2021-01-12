// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'ChatList.dart';

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());

class SendMessageResponse {
  SendMessageResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
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

// class Result {
//   Result({
//     this.status,
//     this.id,
//     this.receiverId,
//     this.message,
//     this.userName,
//     this.senderId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   String status;
//   String id;
//   String receiverId;
//   List<Message> message;
//   String userName;
//   String senderId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     status: json["status"],
//     id: json["_id"],
//     receiverId: json["receiverId"],
//     message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
//     userName: json["userName"],
//     senderId: json["senderId"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "_id": id,
//     "receiverId": receiverId,
//     "message": List<dynamic>.from(message.map((x) => x.toJson())),
//     "userName": userName,
//     "senderId": senderId,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "__v": v,
//   };
// }

// class Message {
//   Message({
//     this.id,
//     this.message,
//     this.senderId,
//     this.createdAt,
//   });
//
//   String id;
//   String message;
//   String senderId;
//   DateTime createdAt;
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//     id: json["_id"],
//     message: json["message"],
//     senderId: json["senderId"],
//     createdAt: DateTime.parse(json["createdAt"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "message": message,
//     "senderId": senderId,
//     "createdAt": createdAt.toIso8601String(),
//   };
// }
