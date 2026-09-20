class WeatherEntity {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnits currentUnits;
  final CurrentData current;
  final HourlyUnits hourlyUnits;
  final HourlyData hourly;
  final DailyUnits dailyUnits;
  final DailyData daily;

  const WeatherEntity({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });
}

class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String apparentTemperature;
  final String weatherCode;
  final String surfacePressure;
  final String windSpeed10m;
  final String windDirection10m;
  final String dewPoint2m;
  final String uvIndex;
  final String isDay; // Added isDay unit field

  const CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.weatherCode,
    required this.surfacePressure,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.dewPoint2m,
    required this.uvIndex,
    required this.isDay,
  });
}

class CurrentData {
  final String time;
  final int interval;
  final double temperature2m;
  final int relativeHumidity2m;
  final double apparentTemperature;
  final int weatherCode;
  final double surfacePressure;
  final double windSpeed10m;
  final int windDirection10m;
  final double dewPoint2m;
  final double uvIndex;
  final bool isDay; // Converts integer 1/0 to bool

  const CurrentData({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.weatherCode,
    required this.surfacePressure,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.dewPoint2m,
    required this.uvIndex,
    required this.isDay,
  });
}

class HourlyUnits {
  final String time;
  final String temperature2m;
  final String weatherCode;

  const HourlyUnits({
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
  });
}

class HourlyData {
  final List<String> time;
  final List<double> temperature2m;
  final List<int> weatherCode;

  const HourlyData({
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
  });
}

class DailyUnits {
  final String time;
  final String temperature2mMax;
  final String temperature2mMin;

  const DailyUnits({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
  });
}

class DailyData {
  final List<String> time;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;

  const DailyData({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
  });
}
