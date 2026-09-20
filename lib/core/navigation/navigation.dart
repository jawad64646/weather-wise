import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Future<dynamic> replaceWith(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static void goBack() {
    navigatorKey.currentState!.pop();
  }

  static Future<dynamic> clearAndNavigate(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }
}
