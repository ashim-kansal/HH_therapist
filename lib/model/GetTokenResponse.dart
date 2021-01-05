// To parse this JSON data, do
//
//     final getTokenResponse = getTokenResponseFromJson(jsonString);

import 'dart:convert';

GetTokenResponse getTokenResponseFromJson(String str) => GetTokenResponse.fromJson(json.decode(str));

String getTokenResponseToJson(GetTokenResponse data) => json.encode(data.toJson());

class GetTokenResponse {
  GetTokenResponse({
    this.responseCode,
    this.responseMessage,
    this.jwt,
  });

  String responseCode;
  String responseMessage;
  String jwt;

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) => GetTokenResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    jwt: json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "jwt": jwt,
  };
}
