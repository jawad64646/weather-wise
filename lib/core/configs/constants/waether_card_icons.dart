import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

const weatherCardIcons = <String, IconData>{
  'wind': LucideIcons.wind,
  'humidity': LucideIcons.droplets,
  'uvIndex': LucideIcons.sun,
  'pressure': LucideIcons.gauge,
};

String getWindStrength(double speed) {
  if (speed < 5) {
    return 'Calm';
  } else if (speed < 12) {
    return 'Light';
  } else if (speed < 20) {
    return 'Gentle';
  } else if (speed < 29) {
    return 'Moderate';
  } else if (speed < 39) {
    return 'Fresh';
  } else if (speed < 50) {
    return 'Strong';
  } else {
    return 'Very Strong';
  }
}

String getUvDescription(double uv) {
  if (uv < 3) return 'Low';
  if (uv < 6) return 'Moderate';
  if (uv < 8) return 'High';
  if (uv < 11) return 'Very High';
  return 'Extreme';
}

String getWindDirection(double degrees) {
  const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];

  return directions[((degrees + 22.5) / 45).floor() % 8];
}

String getPressureDescription(double pressure) {
  if (pressure < 1000) {
    return 'Low';
  } else if (pressure < 1020) {
    return 'Normal';
  } else {
    return 'High';
  }
}
