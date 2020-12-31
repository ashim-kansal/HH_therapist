// To parse this JSON data, do
//
//     final upcomingSession = upcomingSessionFromJson(jsonString);

import 'dart:convert';

UpcomingSession upcomingSessionFromJson(String str) => UpcomingSession.fromJson(json.decode(str));

String upcomingSessionToJson(UpcomingSession data) => json.encode(data.toJson());

class UpcomingSession {
    UpcomingSession({
        this.responseCode,
        this.responseMessage,
        this.result,
        this.paginationData,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;
    PaginationData paginationData;

    factory UpcomingSession.fromJson(Map<String, dynamic> json) => UpcomingSession(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        paginationData: PaginationData.fromJson(json["paginationData"]),
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "paginationData": paginationData.toJson(),
    };
}

class PaginationData {
    PaginationData({
        this.total,
        this.limit,
        this.page,
        this.pages,
    });

    int total;
    int limit;
    int page;
    int pages;

    factory PaginationData.fromJson(Map<String, dynamic> json) => PaginationData(
        total: json["total"],
        limit: json["limit"],
        page: json["page"],
        pages: json["pages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "page": page,
        "pages": pages,
    };
}

class Result {
    Result({
        this.date,
        this.prescription,
        this.resultLibrary,
        this.sessionStatus,
        this.id,
        this.patientId,
        this.therapistId,
        this.startTime,
        this.endTime,
        this.programName,
        this.slotId,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    DateTime date;
    List<dynamic> prescription;
    List<dynamic> resultLibrary;
    String sessionStatus;
    String id;
    String patientId;
    TherapistId therapistId;
    String startTime;
    String endTime;
    String programName;
    String slotId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        date: DateTime.parse(json["date"]),
        prescription: List<dynamic>.from(json["prescription"].map((x) => x)),
        resultLibrary: List<dynamic>.from(json["library"].map((x) => x)),
        sessionStatus: json["session_Status"],
        id: json["_id"],
        patientId: json["patientId"],
        therapistId: TherapistId.fromJson(json["therapistId"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        programName: json["programName"],
        slotId: json["slotId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "prescription": List<dynamic>.from(prescription.map((x) => x)),
        "library": List<dynamic>.from(resultLibrary.map((x) => x)),
        "session_Status": sessionStatus,
        "_id": id,
        "patientId": patientId,
        "therapistId": therapistId.toJson(),
        "startTime": startTime,
        "endTime": endTime,
        "programName": programName,
        "slotId": slotId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class TherapistId {
    TherapistId({
        this.id,
        this.firstName,
        this.lastName,
    });

    String id;
    String firstName;
    String lastName;

    factory TherapistId.fromJson(Map<String, dynamic> json) => TherapistId(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
    };
}
