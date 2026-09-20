import 'package:weatherwise/features/home/data/models/forcast_7days_model.dart';
import 'package:weatherwise/features/home/domain/entities/forcast_entity.dart'
    as entity;

extension ForecastModelToEntity on ForecastModel {
  entity.ForecastEntity toEntity() {
    return entity.ForecastEntity(
      latitude: latitude,
      longitude: longitude,
      generationtimeMs: generationtimeMs,
      utcOffsetSeconds: utcOffsetSeconds,
      timezone: timezone,
      timezoneAbbreviation: timezoneAbbreviation,
      elevation: elevation,
      currentUnits: entity.CurrentUnits(
        time: currentUnits!.time,
        interval: currentUnits!.interval,
        temperature2M: currentUnits!.temperature2M,
      ),
      current: current == null
          ? null
          : entity.Current(
              time: current!.time,
              interval: current!.interval,
              temperature2M: current!.temperature2M,
            ),
      dailyUnits: entity.DailyUnits(
        time: dailyUnits!.time,
        temperature2MMax: dailyUnits!.temperature2MMax,
        temperature2MMin: dailyUnits!.temperature2MMin,
        weatherCode: dailyUnits!.weatherCode,
        precipitationSum: dailyUnits!.precipitationSum,
        precipitationProbabilityMax: dailyUnits!.precipitationProbabilityMax,
      ),
      daily: entity.Daily(
        time: daily!.time,
        temperature2MMax: daily!.temperature2MMax,
        temperature2MMin: daily!.temperature2MMin,
        weatherCode: daily!.weatherCode,
        precipitationSum: daily!.precipitationSum,
        precipitationProbabilityMax: daily!.precipitationProbabilityMax,
      ),
    );
  }
}
