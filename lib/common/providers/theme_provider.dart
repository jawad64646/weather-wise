import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherwise/main.dart';

const _themeKey = 'user_theme_string';

class ThemeNotifier extends Notifier<ThemeMode> {
  // Access the pre-loaded SharedPreferences instance via ref
  late final SharedPreferences _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final savedTheme = _prefs.getString(_themeKey);

    switch (savedTheme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  void toggleTheme() {
    final nextMode = (state == ThemeMode.light)
        ? ThemeMode.dark
        : ThemeMode.light;
    state = nextMode;

    _prefs.setString(_themeKey, nextMode.name);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
