import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/features/home/domain/entities/forcast_entity.dart';

import '../repositories/location_repo.dart';

class Getforecast {
  final LocationRepository repository;

  Getforecast(this.repository);

  Future<Either<String, ForecastEntity>> call() {
    return repository.getForcast7Days();
  }
}
