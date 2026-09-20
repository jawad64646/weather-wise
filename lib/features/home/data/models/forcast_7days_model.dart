class ForecastModel {
  ForecastModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.dailyUnits,
    required this.daily,
  });

  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final int? elevation;
  final CurrentUnits? currentUnits;
  final Current? current;
  final DailyUnits? dailyUnits;
  final Daily? daily;

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      latitude: json["latitude"],
      longitude: json["longitude"],
      generationtimeMs: json["generationtime_ms"],
      utcOffsetSeconds: json["utc_offset_seconds"],
      timezone: json["timezone"],
      timezoneAbbreviation: json["timezone_abbreviation"],
      elevation: json["elevation"],
      currentUnits: json["current_units"] == null
          ? null
          : CurrentUnits.fromJson(json["current_units"]),
      current: json["current"] == null
          ? null
          : Current.fromJson(json["current"]),
      dailyUnits: json["daily_units"] == null
          ? null
          : DailyUnits.fromJson(json["daily_units"]),
      daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "current_units": currentUnits?.toJson(),
    "current": current?.toJson(),
    "daily_units": dailyUnits?.toJson(),
    "daily": daily?.toJson(),
  };
}

class Current {
  Current({
    required this.time,
    required this.interval,
    required this.temperature2M,
  });

  final String? time;
  final int? interval;
  final double? temperature2M;

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      time: json["time"],
      interval: json["interval"],
      temperature2M: json["temperature_2m"],
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
  };
}

class CurrentUnits {
  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2M,
  });

  final String? time;
  final String? interval;
  final String? temperature2M;

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json["time"],
      interval: json["interval"],
      temperature2M: json["temperature_2m"],
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
  };
}

class Daily {
  Daily({
    required this.time,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.weatherCode,
    required this.precipitationSum,
    required this.precipitationProbabilityMax,
  });

  final List<DateTime> time;
  final List<double> temperature2MMax;
  final List<double> temperature2MMin;
  final List<int> weatherCode;
  final List<double> precipitationSum;
  final List<int> precipitationProbabilityMax;

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: json["time"] == null
          ? []
          : List<DateTime>.from(
              json["time"]!.map((x) => DateTime.tryParse(x ?? "")),
            ),
      temperature2MMax: json["temperature_2m_max"] == null
          ? []
          : List<double>.from(json["temperature_2m_max"]!.map((x) => x)),
      temperature2MMin: json["temperature_2m_min"] == null
          ? []
          : List<double>.from(json["temperature_2m_min"]!.map((x) => x)),
      weatherCode: json["weather_code"] == null
          ? []
          : List<int>.from(json["weather_code"]!.map((x) => x)),
      precipitationSum: json["precipitation_sum"] == null
          ? []
          : List<double>.from(json["precipitation_sum"]!.map((x) => x)),
      precipitationProbabilityMax: json["precipitation_probability_max"] == null
          ? []
          : List<int>.from(
              json["precipitation_probability_max"]!.map((x) => x),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time
        .map(
          (x) =>
              "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}",
        )
        .toList(),
    "temperature_2m_max": temperature2MMax.map((x) => x).toList(),
    "temperature_2m_min": temperature2MMin.map((x) => x).toList(),
    "weather_code": weatherCode.map((x) => x).toList(),
    "precipitation_sum": precipitationSum.map((x) => x).toList(),
    "precipitation_probability_max": precipitationProbabilityMax
        .map((x) => x)
        .toList(),
  };
}

class DailyUnits {
  DailyUnits({
    required this.time,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.weatherCode,
    required this.precipitationSum,
    required this.precipitationProbabilityMax,
  });

  final String? time;
  final String? temperature2MMax;
  final String? temperature2MMin;
  final String? weatherCode;
  final String? precipitationSum;
  final String? precipitationProbabilityMax;

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json["time"],
      temperature2MMax: json["temperature_2m_max"],
      temperature2MMin: json["temperature_2m_min"],
      weatherCode: json["weather_code"],
      precipitationSum: json["precipitation_sum"],
      precipitationProbabilityMax: json["precipitation_probability_max"],
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time,
    "temperature_2m_max": temperature2MMax,
    "temperature_2m_min": temperature2MMin,
    "weather_code": weatherCode,
    "precipitation_sum": precipitationSum,
    "precipitation_probability_max": precipitationProbabilityMax,
  };
}
