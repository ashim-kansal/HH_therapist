// To parse this JSON data, do
//
//     final patientNotesList = patientNotesListFromJson(jsonString);

import 'dart:convert';

PatientNotesList patientNotesListFromJson(String str) => PatientNotesList.fromJson(json.decode(str));

String patientNotesListToJson(PatientNotesList data) => json.encode(data.toJson());

class PatientNotesList {
    PatientNotesList({
        this.responseCode,
        this.responseMessage,
        this.result,
        this.paginationData,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;
    PaginationData paginationData;

    factory PatientNotesList.fromJson(Map<String, dynamic> json) => PatientNotesList(
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
        this.status,
        this.id,
        this.patientId,
        this.therapistId,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    DateTime date;
    String status;
    String id;
    String patientId;
    String therapistId;
    String note;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        date: DateTime.parse(json["date"]),
        status: json["status"],
        id: json["_id"],
        patientId: json["patientId"],
        therapistId: json["therapistId"],
        note: json["note"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "status": status,
        "_id": id,
        "patientId": patientId,
        "therapistId": therapistId,
        "note": note,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
