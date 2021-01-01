// To parse this JSON data, do
//
//     final getBookingSlotsResponse = getBookingSlotsResponseFromJson(jsonString);

import 'dart:convert';

GetBookingSlotsResponse getBookingSlotsResponseFromJson(String str) => GetBookingSlotsResponse.fromJson(json.decode(str));

String getBookingSlotsResponseToJson(GetBookingSlotsResponse data) => json.encode(data.toJson());

class GetBookingSlotsResponse {
  GetBookingSlotsResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;

  factory GetBookingSlotsResponse.fromJson(Map<String, dynamic> json) => GetBookingSlotsResponse(
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
    this.weekDays,
    this.id,
    this.scheduleDate,
    this.schedule,
    this.therapistId,
    this.isSelected,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  List<WeekDay> weekDays;
  String id;
  DateTime scheduleDate;
  List<Schedule> schedule;
  TherapistId therapistId;
  int v;
  bool isSelected;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    weekDays: List<WeekDay>.from(json["weekDays"].map((x) => weekDayValues.map[x])),
    id: json["_id"],
    scheduleDate: DateTime.parse(json["scheduleDate"]),
    schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
    therapistId: therapistIdValues.map[json["therapistId"]],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    isSelected: false,
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "weekDays": List<dynamic>.from(weekDays.map((x) => weekDayValues.reverse[x])),
    "_id": id,
    "scheduleDate": scheduleDate.toIso8601String(),
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
    "therapistId": therapistIdValues.reverse[therapistId],
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Schedule {
  Schedule({
    this.status,
    this.id,
    this.startTime,
    this.endTime,
  });

  Status status;
  String id;
  String startTime;
  String endTime;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    status: statusValues.map[json["status"]],
    id: json["_id"],
    startTime: json["startTime"],
    endTime:json["endTime"],
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "_id": id,
    "startTime": startTime,
    "endTime": endTime,
  };
}





enum Status { AVAILABLE }

final statusValues = EnumValues({
  "AVAILABLE": Status.AVAILABLE
});

enum TherapistId { THE_5_FE19_CDABC79_D4_C1783_B0714 }

final therapistIdValues = EnumValues({
  "5fe19cdabc79d4c1783b0714": TherapistId.THE_5_FE19_CDABC79_D4_C1783_B0714
});

enum WeekDay { MONDAY, WEDNESDAY, FRIDAY }

final weekDayValues = EnumValues({
  "Friday": WeekDay.FRIDAY,
  "Monday": WeekDay.MONDAY,
  "Wednesday": WeekDay.WEDNESDAY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
