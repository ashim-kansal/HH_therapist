import 'package:flutter/material.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/navigation/router.dart' as router;

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
