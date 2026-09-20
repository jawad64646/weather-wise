import 'package:weatherwise/features/search/domain/entities/weatherentity.dart';

class WeatherModel {
  WeatherModel({
    required this.time,
    required this.interval,
    required this.temperature2M,
    required this.apparentTemperature,
    required this.weatherCode,
  });

  final String time;
  final int interval;
  final double temperature2M;
  final double apparentTemperature;
  final int weatherCode;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: json["time"] ?? "",
      interval: json["interval"] ?? 0,
      temperature2M: (json["temperature_2m"] as num?)?.toDouble() ?? 0.0,
      apparentTemperature:
          (json["apparent_temperature"] as num?)?.toDouble() ?? 0.0,
      weatherCode: json["weather_code"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
    "apparent_temperature": apparentTemperature,
    "weather_code": weatherCode,
  };
}

extension WeatherSearch on WeatherModel {
  WeatherSearchEntity toEntity() {
    return WeatherSearchEntity(
      time: time,
      interval: interval,
      temperature2M: temperature2M,
      apparentTemperature: apparentTemperature,
      weatherCode: weatherCode,
    );
  }
}
