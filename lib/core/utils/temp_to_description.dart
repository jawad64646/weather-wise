import 'package:flutter/material.dart';

String getWeatherDescription(int code) {
  switch (code) {
    case 0:
      return 'Clear sky';
    case 1:
      return 'Mainly clear';
    case 2:
      return 'Partly cloudy';
    case 3:
      return 'Overcast';
    case 45:
      return 'Fog';
    case 48:
      return 'Depositing rime fog';
    case 51:
      return 'Light drizzle';
    case 52:
      return 'Moderate drizzle';
    case 53:
      return 'Heavy drizzle';
    case 55:
      return 'Freezing drizzle';
    case 56:
      return 'Light freezing drizzle';
    case 57:
      return 'Heavy freezing drizzle';
    case 61:
      return 'Slight rain';
    case 63:
      return 'Moderate rain';
    case 65:
      return 'Heavy rain';
    case 66:
      return 'Light freezing rain';
    case 67:
      return 'Heavy freezing rain';
    case 71:
      return 'Slight snowfall';
    case 73:
      return 'Moderate snowfall';
    case 75:
      return 'Heavy snowfall';
    case 77:
      return 'Ice pellets';
    case 80:
      return 'Light rain showers';
    case 81:
      return 'Moderate rain showers';
    case 82:
      return 'Violent rain showers';
    case 85:
      return 'Light snow showers';
    case 86:
      return 'Moderate snow showers';
    case 87:
      return 'Violent snow showers';
    default:
      return 'Unknown weather';
  }
}

String getTemperatureStatus(double temperature) {
  if (temperature < 0) {
    return 'Freezing';
  } else if (temperature >= 0 && temperature <= 15) {
    return 'Cold';
  } else if (temperature > 15 && temperature <= 25) {
    return 'Normal';
  } else if (temperature > 25 && temperature <= 35) {
    return 'Warm';
  } else {
    return 'Hot';
  }
}

Color getPrecipitationColor(int percentage) {
  if (percentage < 20) {
    return Colors.green; // Low / Minimal chance
  } else if (percentage < 50) {
    return Colors.amber; // Moderate chance
  } else if (percentage < 80) {
    return Colors.orange; // High chance
  } else {
    return Colors.red; // Very high / Severe chance
  }
}
