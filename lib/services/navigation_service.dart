import 'package:flutter/material.dart';

class NavigationService{

  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  //para las rutas
  static navigateTo( String routeName){
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static replaceTo( String routeName){
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}