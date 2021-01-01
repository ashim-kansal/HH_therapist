import 'dart:convert';

import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/UserModel.dart';

class ProfileResponseModel{


  int responseCode;
  String responseMessage;
  UserModel result;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  ProfileResponseModel({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  ProfileResponseModel copyWith({
    int responseCode,
    String responseMessage,
    UserModel result,
  }) {
    return new ProfileResponseModel(
      responseCode: responseCode ?? this.responseCode,
      responseMessage: responseMessage ?? this.responseMessage,
      result: result ?? this.result,
    );
  }

  @override
  String toString() {
    return 'ProfileResponseModel{responseCode: $responseCode, responseMessage: $responseMessage, result: $result}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileResponseModel &&
          runtimeType == other.runtimeType &&
          responseCode == other.responseCode &&
          responseMessage == other.responseMessage &&
          result == other.result);

  @override
  int get hashCode =>
      responseCode.hashCode ^ responseMessage.hashCode ^ result.hashCode;

  factory ProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return new ProfileResponseModel(
      responseCode: map['responseCode'] as int,
      responseMessage: map['responseMessage'] as String,
      result: map['result'] as UserModel,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'responseCode': this.responseCode,
      'responseMessage': this.responseMessage,
      'result': this.result,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
