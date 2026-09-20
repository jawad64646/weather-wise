import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

String getWeatherImage(int id) {
  if (id == 0) {
    return 'assets/images/01d.png';
  }
  if (id == 1) {
    return 'assets/images/6.png';
  }
  if (id == 2) {
    return 'assets/images/03d.png';
  }
  if (id == 3) {
    return 'assets/images/04d.png';
  }
  if (id == 45) {
    return 'assets/images/04d.png';
  }
  if (id == 48) {
    return 'assets/images/04d.png';
  }
  if (id == 53) {
    return 'assets/images/39.png';
  }
  if (id > 50 && id < 60) {
    return 'assets/images/09d.png';
  }
  if (id > 60 && id < 70) {
    return 'assets/images/7.png';
  }
  if (id >= 70 && id < 80) {
    return 'assets/images/04d';
  }
  if (id >= 80 && id < 85) {
    return 'assets/images/7.png';
  }
  if (id > 85) {
    return 'assets/images/13d.png';
  }

  return 'assets/images/01d.png';
}

IconData getWeatherIcon(int id) {
  switch (id) {
    case 0:
      return LucideIcons.sun;
    case 1:
      return LucideIcons.sun_medium;
    case 2:
      return LucideIcons.cloud_sun;
    case 3:
      return LucideIcons.cloud;
    case 45:
    case 48:
      return LucideIcons.cloud_fog;
    case 53:
      return LucideIcons.cloud_drizzle;
  }

  if (id > 50 && id < 60) {
    return LucideIcons.cloud_drizzle;
  }
  if (id > 60 && id < 70) {
    return LucideIcons.cloud_rain;
  }
  if (id >= 70 && id < 80) {
    return LucideIcons.snowflake;
  }
  if (id >= 80 && id < 85) {
    return LucideIcons.cloud_rain_wind;
  }
  if (id > 85) {
    return LucideIcons.cloud_snow;
  }

  return LucideIcons.sun;
}

IconData getWeatherIcon2(int id, {bool isDay = true}) {
  switch (id) {
    case 0:
      return isDay ? LucideIcons.sun : LucideIcons.moon;
    case 1:
      return isDay ? LucideIcons.sun_medium : LucideIcons.moon_star;
    case 2:
      return isDay ? LucideIcons.cloud_sun : LucideIcons.cloud_moon;
    case 3:
      return LucideIcons.cloud;
    case 45:
    case 48:
      return LucideIcons.cloud_fog;
  }

  if (id >= 51 && id <= 57) {
    return LucideIcons.cloud_drizzle;
  }
  if (id >= 61 && id <= 67) {
    return isDay ? LucideIcons.cloud_rain : LucideIcons.cloud_moon_rain;
  }
  if (id >= 70 && id < 80) {
    return LucideIcons.snowflake;
  }
  if (id >= 80 && id < 85) {
    return LucideIcons.cloud_rain_wind;
  }
  if (id >= 85) {
    return LucideIcons.cloud_snow;
  }

  return isDay ? LucideIcons.sun : LucideIcons.moon;
}

String getWeatherImage2(int id, {bool isDay = true}) {
  if (!isDay) {
    if (id == 0 || id == 1) return 'assets/images/01n.png';
  }

  switch (id) {
    case 0:
    case 1:
      return 'assets/images/01d.png';
    case 2:
      return 'assets/images/03d.png';
    case 3:
    case 45:
    case 48:
      return 'assets/images/04d.png';
    case 53:
      return 'assets/images/39.png';
    default:
      if (id > 50 && id < 60) return 'assets/images/09d.png';
      if (id > 60 && id < 70) return 'assets/images/7.png';
      if (id >= 70 && id < 80) return 'assets/images/04d.png';
      if (id >= 80 && id < 85) return 'assets/images/7.png';
      if (id > 85) return 'assets/images/13d.png';
      return 'assets/images/01d.png';
  }
}

String getImageForTemp(double avgTemp) {
  if (avgTemp >= 20.0) {
    return 'assets/images/01d.png'; // Clear / Sunny
  } else if (avgTemp >= 12.0) {
    return 'assets/images/03d.png'; // Mild / Partly Cloudy
  } else if (avgTemp >= 2.0) {
    return 'assets/images/04d.png'; // Cool / Overcast
  } else {
    return 'assets/images/13d.png'; // Freezing / Snow
  }
}
/*

0: Clear sky
1: Mainly clear
2: Partly cloudy
3: Overcast
45: Fog
48: Depositing rime fog
51: Light drizzle
52: Moderate drizzle
53: Heavy drizzle
55: Freezing drizzle
56: Light freezing drizzle
57: Heavy freezing drizzle
61: Slight rain
63: Moderate rain
65: Heavy rain
66: Light freezing rain
67: Heavy freezing rain
71: Slight snowfall
73: Moderate snowfall
75: Heavy snowfall
77: Ice pellets
80: Light rain showers
81: Moderate rain showers
82: Violent rain showers
85: Light snow showers
86: Moderate snow showers
87: Violent snow showers

*/
