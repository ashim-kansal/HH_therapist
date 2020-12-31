
import 'package:shared_preferences/shared_preferences.dart';

void SetStringToSP (key, value) async {
 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  prefs.setString(key, value);
}

Future<String> GetStringToSP(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString(key);
  return stringValue;
}

// ignore: non_constant_identifier_names
void SetIntToSP (key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, int.parse(value));
}

Future<int> GetIntToSP(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int value = prefs.getInt(key);
  return value;
}

// ignore: non_constant_identifier_names
// void AfterLoginSetData (key, value) async {
//   SharedPreferences app_preferences = PreferanceManager.
//   prefs.setInt(key, int.parse(value));
// }