// To parse this JSON data, do
//
//     final libraryList = libraryListFromJson(jsonString);

import 'dart:convert';

LibraryList libraryListFromJson(String str) => LibraryList.fromJson(json.decode(str));

String libraryListToJson(LibraryList data) => json.encode(data.toJson());

class LibraryList {
    LibraryList({
        this.responseCode,
        this.responseMessage,
        this.result,
        this.paginationData,
    });

    int responseCode;
    String responseMessage;
    List<Result> result;
    PaginationData paginationData;

    factory LibraryList.fromJson(Map<String, dynamic> json) => LibraryList(
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
        this.status,
        this.id,
        this.userId,
        this.title,
        this.document,
        this.uploadBy,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String status;
    String id;
    String userId;
    String title;
    String document;
    String uploadBy;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        document: json["document"],
        uploadBy: json["uploadBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "userId": userId,
        "title": title,
        "document": document,
        "uploadBy": uploadBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
