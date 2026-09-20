class ForecastEntity {
  ForecastEntity({
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
}
