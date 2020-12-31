
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/StaticContentModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


Future<StaticContent> getStaticContent(type) async {

  final url = HHString.baseURL +"/api/v1/static/ViewStaticContent?Type="+type;
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },);
  print(response.body);
  return staticContentFromJson(response.body);
}