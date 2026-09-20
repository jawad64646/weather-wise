class WeatherModel {
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

  const WeatherModel({
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

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      generationTimeMs: (json['generationtime_ms'] as num).toDouble(),
      utcOffsetSeconds: json['utc_offset_seconds'] as int,
      timezone: json['timezone'] as String,
      timezoneAbbreviation: json['timezone_abbreviation'] as String,
      elevation: (json['elevation'] as num).toDouble(),
      currentUnits: CurrentUnits.fromJson(
        json['current_units'] as Map<String, dynamic>,
      ),
      current: CurrentData.fromJson(json['current'] as Map<String, dynamic>),
      hourlyUnits: HourlyUnits.fromJson(
        json['hourly_units'] as Map<String, dynamic>,
      ),
      hourly: HourlyData.fromJson(json['hourly'] as Map<String, dynamic>),
      dailyUnits: DailyUnits.fromJson(
        json['daily_units'] as Map<String, dynamic>,
      ),
      daily: DailyData.fromJson(json['daily'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationTimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'current_units': currentUnits.toJson(),
      'current': current.toJson(),
      'hourly_units': hourlyUnits.toJson(),
      'hourly': hourly.toJson(),
      'daily_units': dailyUnits.toJson(),
      'daily': daily.toJson(),
    };
  }
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

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'] as String,
      interval: json['interval'] as String,
      temperature2m: json['temperature_2m'] as String,
      relativeHumidity2m: json['relative_humidity_2m'] as String,
      apparentTemperature: json['apparent_temperature'] as String,
      weatherCode: json['weather_code'] as String,
      surfacePressure: json['surface_pressure'] as String,
      windSpeed10m: json['wind_speed_10m'] as String,
      windDirection10m: json['wind_direction_10m'] as String,
      dewPoint2m: json['dew_point_2m'] as String,
      uvIndex: json['uv_index'] as String,
      isDay: json['is_day'] as String? ?? '', // Parse safely if provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'interval': interval,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'apparent_temperature': apparentTemperature,
      'weather_code': weatherCode,
      'surface_pressure': surfacePressure,
      'wind_speed_10m': windSpeed10m,
      'wind_direction_10m': windDirection10m,
      'dew_point_2m': dewPoint2m,
      'uv_index': uvIndex,
      'is_day': isDay,
    };
  }
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

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(
      time: json['time'] as String,
      interval: json['interval'] as int,
      temperature2m: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity2m: json['relative_humidity_2m'] as int,
      apparentTemperature: (json['apparent_temperature'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
      surfacePressure: (json['surface_pressure'] as num).toDouble(),
      windSpeed10m: (json['wind_speed_10m'] as num).toDouble(),
      windDirection10m: json['wind_direction_10m'] as int,
      dewPoint2m: (json['dew_point_2m'] as num).toDouble(),
      uvIndex: (json['uv_index'] as num).toDouble(),
      isDay: json['is_day'] == 1, // Converts 1 to true and 0 to false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'interval': interval,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'apparent_temperature': apparentTemperature,
      'weather_code': weatherCode,
      'surface_pressure': surfacePressure,
      'wind_speed_10m': windSpeed10m,
      'wind_direction_10m': windDirection10m,
      'dew_point_2m': dewPoint2m,
      'uv_index': uvIndex,
      'is_day': isDay ? 1 : 0, // Serializes back to 1/0
    };
  }
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

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'] as String,
      temperature2m: json['temperature_2m'] as String,
      weatherCode: json['weather_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'weather_code': weatherCode,
    };
  }
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

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: List<String>.from(json['time'] as List),
      temperature2m: (json['temperature_2m'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
      weatherCode: List<int>.from(json['weather_code'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'weather_code': weatherCode,
    };
  }
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

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'] as String,
      temperature2mMax: json['temperature_2m_max'] as String,
      temperature2mMin: json['temperature_2m_min'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
    };
  }
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

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: List<String>.from(json['time'] as List),
      temperature2mMax: (json['temperature_2m_max'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
      temperature2mMin: (json['temperature_2m_min'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
    };
  }
}
