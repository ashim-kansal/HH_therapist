// To parse this JSON data, do
//
//     final countryList = countryListFromJson(jsonString);

import 'dart:convert';

CountryList countryListFromJson(String str) => CountryList.fromJson(json.decode(str));

String countryListToJson(CountryList data) => json.encode(data.toJson());

class CountryList {
    CountryList({
        this.responseMessage,
        this.result,
    });

    String responseMessage;
    List<Result> result;

    factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        responseMessage: json["responseMessage"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseMessage": responseMessage,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.name,
        this.code,
        this.phoneCode,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String name;
    String code;
    String phoneCode;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        name: json["name"],
        code: json["code"],
        phoneCode: json["phone_code"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "code": code,
        "phone_code": phoneCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
