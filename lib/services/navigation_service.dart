import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static NavigationService instance = NavigationService();

  // NavigationService(){
  //   navigationKey = GlobalKey<NavigatorState>();
  // }
  // final GlobalKey<NavigatorState> navigatorKey =
  //     new GlobalKey<NavigatorState>();
  Future<dynamic> navigateToReplacement(String routeName) {
    return navigationKey.currentState.pushReplacementNamed(routeName);
  }
  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState.pushNamed(routeName);
  }
  Future<dynamic> navigateToRoute(MaterialPageRoute routeName) {
     print("objectRoute $routeName");
    return navigationKey.currentState.push<Object>(routeName);
  }

  gobacak(){
    return navigationKey.currentState.pop();
  }
}