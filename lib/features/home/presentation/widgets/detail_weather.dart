import 'package:flutter/material.dart';
import 'package:weatherwise/core/configs/constants/waether_card_icons.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';

List<Map<String, dynamic>> buildWeatherInfo(dynamic weatherdata) {
  return [
    {
      'title': 'Wind',
      'value': weatherdata.current.windSpeed10m,
      'unit': weatherdata.currentUnits.windSpeed10m,
      'detail':
          '${getWindDirection(weatherdata.current.windDirection10m.toDouble())} • ${getWindStrength(weatherdata.current.windSpeed10m)}',
      'icon': 'wind',
    },
    {
      'title': 'Humidity',
      'value': weatherdata.current.relativeHumidity2m,
      'unit': weatherdata.currentUnits.relativeHumidity2m,
      'detail': 'Dew point ${weatherdata.current.dewPoint2m}°',
      'icon': 'humidity',
    },
    {
      'title': 'UV Index',
      'value': weatherdata.current.uvIndex,
      'unit': weatherdata.currentUnits.uvIndex,
      'detail': getUvDescription(weatherdata.current.uvIndex),
      'icon': 'uvIndex',
    },
    {
      'title': 'Pressure',
      'value': weatherdata.current.surfacePressure,
      'unit': weatherdata.currentUnits.surfacePressure,
      'detail': getPressureDescription(weatherdata.current.surfacePressure),
      'icon': 'pressure',
    },
  ];
}

Widget cardDetailWeather(
  String name,
  String iconIndex,
  num number,
  String unit,
  String? additionalInfo,
) {
  return Card(
    color: AppColors.cardLight,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.borderLight),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMutedL,
                ),
              ),
              Icon(
                weatherCardIcons[iconIndex],
                color: name == 'UV Index'
                    ? AppColors.primary
                    : AppColors.primaryLight,
              ),
            ],
          ),
          const Spacer(),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$number ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: name == 'UV Index' ? '' : unit,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          if (additionalInfo != null) ...[
            const SizedBox(height: 4),
            Text(
              additionalInfo,
              style: TextStyle(
                color: name == 'UV Index' ? AppColors.primary : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
