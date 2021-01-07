import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations{

  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizations();


  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedString;

  Future<bool> load() async{
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key){
    return _localizedString[key];
  }
}

class _AppLocalizations extends LocalizationsDelegate<AppLocalizations>{

  const _AppLocalizations();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = new AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;

}