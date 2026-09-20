import 'package:flutter/material.dart';

extension LightDarkExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
