// To parse this JSON data, do
//
//     final getBookingResponse = getBookingResponseFromJson(jsonString);

import 'dart:convert';

GetBookingResponse getBookingResponseFromJson(String str) => GetBookingResponse.fromJson(json.decode(str));

String getBookingResponseToJson(GetBookingResponse data) => json.encode(data.toJson());

class GetBookingResponse {
  GetBookingResponse({
    this.responseCode,
    this.responseMessage,
  });

  int responseCode;
  String responseMessage;

  factory GetBookingResponse.fromJson(Map<String, dynamic> json) => GetBookingResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
  };
}
