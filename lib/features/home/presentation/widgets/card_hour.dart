import 'package:flutter/material.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/core/utils/code_to_image.dart';

Widget cardHour(String date, int imageCode, double temp, bool isNow) {
  return Card(
    color: AppColors.cardLight,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: isNow ? AppColors.primaryLight : AppColors.borderLight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            isNow ? "Now" : date,
            style: TextStyle(
              color: isNow ? AppColors.primaryLight : AppColors.textMutedL,
              fontSize: 12,
              fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Icon(
            size: 25,
            getWeatherIcon2(imageCode),
            color: AppColors.primaryLight,
          ),
          Text(
            "${temp.toStringAsFixed(0)}°",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
