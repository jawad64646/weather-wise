import 'package:flutter/material.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/core/utils/code_to_image.dart';

Widget weatherImage(int code, bool isday) {
  return Image.asset(
    getWeatherImage2(code, isDay: isday),
    height: 200,
    width: 200,
    fit: BoxFit.contain,
  );
}

Widget weatherImage2(int code) {
  return Image.asset(
    getWeatherImage(code),
    height: 200,
    width: 200,
    fit: BoxFit.contain,
  );
}

Widget currentTemp(double temp, String unit) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        temp.toStringAsFixed(0),
        style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          unit,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryLight,
          ),
        ),
      ),
    ],
  );
}

Widget getWeatherStatus(String status) {
  return Text(
    status,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  );
}

Widget getWeatherInformation(double min, double max, double feelLike) {
  return Text(
    'High $max° • Low $min° • Feels like $feelLike°',
    style: const TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textMutedL,
    ),
  );
}
