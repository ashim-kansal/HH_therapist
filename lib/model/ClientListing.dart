// To parse this JSON data, do
//
//     final myClientList = myClientListFromJson(jsonString);

import 'dart:convert';

MyClientList myClientListFromJson(String str) => MyClientList.fromJson(json.decode(str));

String myClientListToJson(MyClientList data) => json.encode(data.toJson());

class MyClientList {
    MyClientList({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    Result result;

    factory MyClientList.fromJson(Map<String, dynamic> json) => MyClientList(
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
        this.myPatient,
    });

    List<MyPatient> myPatient;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        myPatient: List<MyPatient>.from(json["myPatient"].map((x) => MyPatient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "myPatient": List<dynamic>.from(myPatient.map((x) => x.toJson())),
    };
}

class MyPatient {
    MyPatient({
        this.profilePic,
        this.id,
        this.firstName,
        this.lastName,
    });

    String profilePic;
    String id;
    String firstName;
    String lastName;

    factory MyPatient.fromJson(Map<String, dynamic> json) => MyPatient(
        profilePic: json["profilePic"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
    );

    Map<String, dynamic> toJson() => {
        "profilePic": profilePic,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
    };
}
