import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HelperFunction {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserUserIdKey = "USERIDKEY";
  static String sharedPreferenceStoreCreatedKey = "USERCREATESTOREKEY";
  static String TokenKey = 'token';
  static String SETTINGS = 'settings';
  static String PATIENTCOUNT = 'count';
  static String PortalUserKey = 'patient';
  static String countryCodes = 'country_codes';
  static String merchantKey = '9A12NVoRrI';
  static String merchantCode = 'M28158';
  static String apiKey = '4237719d1ab57734f0cb09b1c4db9438';
  static String apiUserId = 'iZXCKfo7';
  static String apiPassword = '5Csk8BxHZ2rAtRN4';

  // saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserStoreCreatedSharedPreference(
      bool isStoreCreated) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceStoreCreatedKey, isStoreCreated);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserIdSharedPreference(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userId);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<void> saveAuthorizationToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'token': token,
      'date': DateTime.now().toIso8601String()
    };
    print("data $data");
    await preferences.setString(TokenKey, json.encode(data));
  }

  static Future<void> savePatientCount(int count) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(PATIENTCOUNT, count);
  }

  static Future<void> savePortalUser(Map<String, dynamic> user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PortalUserKey, jsonEncode(user));
  }

  static Future<void> saveUserSettings(Map<String, dynamic> settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(SETTINGS, jsonEncode(settings));
  }


  // fetching data from sharedpreference
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<bool> getUserStoreCreateSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceStoreCreatedKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<int> getPatientCountSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getInt(PATIENTCOUNT);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getUserIdSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserUserIdKey);
  }

  static Future<String> getAuthorizationToken(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = await preferences.getString(TokenKey);
    print("data $data");
    if (data == null) return data;
    Map<String, dynamic> jsonData = json.decode(data);
    DateTime sessionDate = DateTime.parse(jsonData['date']);
    DateTime currentDate = DateTime.now();
    final difference = currentDate.difference(sessionDate).inMinutes;
    if (difference > 15) Navigator.pushNamed(context, '/session');
    saveAuthorizationToken(jsonData["token"]);
    return jsonData["token"];
  }

  static Future<Map<String, dynamic>> getPortalUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String patient = await preferences.getString(PortalUserKey);
    return jsonDecode(patient);
  }

  static Future<Map<String, dynamic>> getUserSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String settings = await preferences.getString(SETTINGS);
    return jsonDecode(settings);
  }

  //deleting data from shared preferences
  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

}