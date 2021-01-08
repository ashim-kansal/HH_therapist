import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/l10n/messages_all.dart';

class AppLocalizations {

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  String get heyWorld => Intl.message('Hey World');
  String get abc => Intl.message('abc');
  String get hh => Intl.message('Heal@Home Programs');

}



class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{

  final Locale overriddenLocale;
  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

}