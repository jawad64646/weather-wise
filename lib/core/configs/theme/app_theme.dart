import 'package:flutter/material.dart';

import 'package:weatherwise/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    fontFamily: 'Inter_24pt',
    brightness: .light, // always for light mode
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontWeight: .w500,
        color: AppColors.textMutedL,
      ), //color
      filled: true,
      fillColor: AppColors.cardLight,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.borderLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.white, // reliable
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.bottomNavLight,
      indicatorColor: AppColors.primaryLight.withValues(alpha: 0.15),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryLight,
          );
        }

        return const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textMutedL,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryLight);
        }

        return const IconThemeData(color: AppColors.textMutedL);
      }),
    ),
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    brightness: .dark, // always for dark mode
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontWeight: .w500,
        color: AppColors.textMutedD,
      ), // color
      filled: true,
      fillColor: AppColors.cardDark,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.borderDark, width: 2),
      ),
    ),
    fontFamily: 'Inter_24pt',
    scaffoldBackgroundColor: AppColors.darkbackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.textPrimaryL, // reliable
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.bottomNavDark,
      indicatorColor: AppColors.primaryDark.withValues(alpha: 0.15),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryDark,
          );
        }

        return const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textMutedD,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryDark);
        }

        return const IconThemeData(color: AppColors.textMutedD);
      }),
    ),
  );
}
