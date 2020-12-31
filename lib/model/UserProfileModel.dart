// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    UserProfile({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    Result result;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        result: json.containsKey("result")? Result.fromJson(json["result"]) : Result.fromJson({}),
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.userType,
        this.appLanguage,
        this.deviceToken,
        this.profilePic,
        this.otpTime,
        this.verifyOtp,
        this.notificationStatus,
        this.programSubscribed,
        this.status,
        this.myTherapist,
        this.myPatient,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
        this.mobileNumber,
        this.address,
        this.password,
        this.otp,
        this.mergeContact,
        this.permissions,
        this.questions,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.programSubscription,
    });

    String userType;
    String appLanguage;
    String deviceToken;
    String profilePic;
    int otpTime;
    bool verifyOtp;
    bool notificationStatus;
    bool programSubscribed;
    String status;
    List<String> myTherapist;
    List<dynamic> myPatient;
    String id;
    String firstName;
    String lastName;
    String email;
    String countryCode;
    String mobileNumber;
    String address;
    String password;
    String otp;
    String mergeContact;
    List<dynamic> permissions;
    List<dynamic> questions;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String programSubscription;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        userType: json["userType"]?? "",
        appLanguage: json["appLanguage"]?? "",
        deviceToken: json["deviceToken"]?? "",
        profilePic: json["profilePic"]?? "",
        otpTime: json["otpTime"]?? 1,
        verifyOtp: json["verifyOtp"]?? false,
        notificationStatus: json["notificationStatus"]?? false,
        programSubscribed: json["programSubscribed"]?? false,
        status: json["status"]?? "",
        myTherapist: json["myTherapist"] != null ?List<String>.from(json["myTherapist"].map((x) => x)): "",
        myPatient: json["myPatient"]!= null ?List<dynamic>.from(json["myPatient"].map((x) => x)) : "",
        id: json["_id"]?? "",
        firstName: json["firstName"]?? "",
        lastName: json["lastName"]?? "",
        email: json["email"]?? "",
        countryCode: json["countryCode"]?? "",
        mobileNumber: json["mobileNumber"]?? "",
        address: json["address"]?? "",
        password: json["password"]?? "",
        otp: json["otp"]?? "",
        mergeContact: json["mergeContact"]?? "",
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
        questions: List<dynamic>.from(json["Questions"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"]?? 1,
        programSubscription: json["programSubscription"]?? "",
    );

    Map<String, dynamic> toJson() => {
        "userType": userType,
        "appLanguage": appLanguage,
        "deviceToken": deviceToken,
        "profilePic": profilePic,
        "otpTime": otpTime,
        "verifyOtp": verifyOtp,
        "notificationStatus": notificationStatus,
        "programSubscribed": programSubscribed,
        "status": status,
        "myTherapist": List<dynamic>.from(myTherapist.map((x) => x)),
        "myPatient": List<dynamic>.from(myPatient.map((x) => x)),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "countryCode": countryCode,
        "mobileNumber": mobileNumber,
        "address": address,
        "password": password,
        "otp": otp,
        "mergeContact": mergeContact,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "Questions": List<dynamic>.from(questions.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "programSubscription": programSubscription,
    };
}
