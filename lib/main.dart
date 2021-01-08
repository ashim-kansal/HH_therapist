import 'package:flutter/material.dart';
import 'package:flutter_app/AppLocalizations.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/navigation/router.dart' as router;
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'widgets/mywidgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: router.generateRoute,
        initialRoute: Splash.RouteName,
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          AppLocalizations.delegate,
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('fr', ''), // Arabic, no country code
          const Locale('es', ''), // Arabic, no country code
          // ... other locales the app supports
        ],
        localeResolutionCallback: (locale, supportedLocales){
          for(var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode){
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => UndefinedView(
              name: settings.name,
            )),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xffff8a73),
          accentColor : Color(0xff777CEA),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}
