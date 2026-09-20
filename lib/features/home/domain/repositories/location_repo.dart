import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/features/home/domain/entities/forcast_entity.dart';

import 'package:weatherwise/features/home/domain/entities/location.dart';
import 'package:weatherwise/features/home/domain/entities/weather_entity.dart';

abstract class LocationRepository {
  Future<Either<String, Location>> getCurrentLocation();
  Future<Either<String, WeatherEntity>> getCurrentWeather();
  Future<Either<String, ForecastEntity>> getForcast7Days();
}
