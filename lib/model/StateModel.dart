// To parse this JSON data, do
//
//     final stateList = stateListFromJson(jsonString);

import 'dart:convert';

StateList stateListFromJson(String str) => StateList.fromJson(json.decode(str));

String stateListToJson(StateList data) => json.encode(data.toJson());

class StateList {
    StateList({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
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
        this.states,
        this.id,
        this.country,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<String> states;
    String id;
    String country;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        states: List<String>.from(json["states"].map((x) => x)),
        id: json["_id"],
        country: json["country"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x)),
        "_id": id,
        "country": country,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
