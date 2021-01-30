import 'package:flutter/material.dart';
import 'package:flutter_app/services/navigation_service.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/navigation/router.dart' as router;
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

import 'widgets/mywidgets.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyAppState();

}



class _MyAppState extends State<MyApp> {  // This widget is the root of your application.
  AppLocalizationDelegate _localeOverrideDelegate = AppLocalizationDelegate(Locale('en', ''));
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return MaterialApp(
        title: 'HH Therapist',
        navigatorKey: NavigationService.instance.navigationKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: Splash.RouteName,
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          _localeOverrideDelegate
        ],

        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('fr', ''), // Arabic, no country code
          const Locale('es', ''), // Arabic, no country code
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
