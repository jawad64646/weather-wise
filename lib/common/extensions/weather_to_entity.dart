import 'package:weatherwise/features/home/data/models/weather_model.dart';
import 'package:weatherwise/features/home/domain/entities/weather_entity.dart'
    as entity;

extension WeatherToEntity on WeatherModel {
  entity.WeatherEntity toEntity() {
    return entity.WeatherEntity(
      latitude: latitude,
      longitude: longitude,
      generationTimeMs: generationTimeMs,
      utcOffsetSeconds: utcOffsetSeconds,
      timezone: timezone,
      timezoneAbbreviation: timezoneAbbreviation,
      elevation: elevation,
      currentUnits: entity.CurrentUnits(
        time: currentUnits.time,
        interval: currentUnits.interval,
        temperature2m: currentUnits.temperature2m,
        relativeHumidity2m: currentUnits.relativeHumidity2m,
        apparentTemperature: currentUnits.apparentTemperature,
        weatherCode: currentUnits.weatherCode,
        surfacePressure: currentUnits.surfacePressure,
        windSpeed10m: currentUnits.windSpeed10m,
        windDirection10m: currentUnits.windDirection10m,
        dewPoint2m: currentUnits.dewPoint2m,
        uvIndex: currentUnits.uvIndex,
        isDay: currentUnits.isDay,
      ),
      current: entity.CurrentData(
        time: current.time,
        interval: current.interval,
        temperature2m: current.temperature2m,
        relativeHumidity2m: current.relativeHumidity2m,
        apparentTemperature: current.apparentTemperature,
        weatherCode: current.weatherCode,
        surfacePressure: current.surfacePressure,
        windSpeed10m: current.windSpeed10m,
        windDirection10m: current.windDirection10m,
        dewPoint2m: current.dewPoint2m,
        uvIndex: current.uvIndex,
        isDay: current.isDay,
      ),
      hourlyUnits: entity.HourlyUnits(
        time: hourlyUnits.time,
        temperature2m: hourlyUnits.temperature2m,
        weatherCode: hourlyUnits.weatherCode,
      ),
      hourly: entity.HourlyData(
        time: hourly.time,
        temperature2m: hourly.temperature2m,
        weatherCode: hourly.weatherCode,
      ),
      dailyUnits: entity.DailyUnits(
        time: dailyUnits.time,
        temperature2mMax: dailyUnits.temperature2mMax,
        temperature2mMin: dailyUnits.temperature2mMin,
      ),
      daily: entity.DailyData(
        time: daily.time,
        temperature2mMax: daily.temperature2mMax,
        temperature2mMin: daily.temperature2mMin,
      ),
    );
  }
}
