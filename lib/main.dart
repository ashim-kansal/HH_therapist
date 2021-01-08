import 'package:flutter/material.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/navigation/router.dart' as router;
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/app_localization.dart';

import 'widgets/mywidgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyAppState();

}



class _MyAppState extends State<MyApp> {  // This widget is the root of your application.
  AppLocalizationDelegate _localeOverrideDelegate = AppLocalizationDelegate(Locale('es', 'ES'));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: router.generateRoute,
        initialRoute: Splash.RouteName,
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          _localeOverrideDelegate
        ],

        supportedLocales: [
          const Locale('en', 'US'), // English, no country code
          const Locale('fr', 'FR'), // Arabic, no country code
          const Locale('es', 'ES'), // Arabic, no country code
          // ... other locales the app supports
        ],
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
