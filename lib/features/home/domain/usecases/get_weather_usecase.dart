import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/features/home/domain/entities/weather_entity.dart';

import '../repositories/location_repo.dart';

class GetWeatherUsecase {
  final LocationRepository repository;

  GetWeatherUsecase(this.repository);

  Future<Either<String, WeatherEntity>> call() {
    return repository.getCurrentWeather();
  }
}
