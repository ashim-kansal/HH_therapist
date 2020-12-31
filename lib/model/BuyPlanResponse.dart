// To parse this JSON data, do
//
//     final buyPlanResponse = buyPlanResponseFromJson(jsonString);

import 'dart:convert';

BuyPlanResponse buyPlanResponseFromJson(String str) => BuyPlanResponse.fromJson(json.decode(str));

String buyPlanResponseToJson(BuyPlanResponse data) => json.encode(data.toJson());

class BuyPlanResponse {
  BuyPlanResponse({
    this.responseCode,
    this.responseMessage,
    this.data,
  });

  int responseCode;
  String responseMessage;
  Data data;

  factory BuyPlanResponse.fromJson(Map<String, dynamic> json) => BuyPlanResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.paymentId,
    this.transactionId,
    this.amount,
    this.createdAt,
  });

  String paymentId;
  String transactionId;
  String amount;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentId: json["paymentId"],
    transactionId: json["transactionId"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentId": paymentId,
    "transactionId": transactionId,
    "amount": amount,
    "createdAt": createdAt.toIso8601String(),
  };
}
