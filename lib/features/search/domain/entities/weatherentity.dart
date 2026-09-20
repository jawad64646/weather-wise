class WeatherSearchEntity {
  WeatherSearchEntity({
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
}
