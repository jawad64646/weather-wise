import 'package:fpdart/fpdart.dart';

import '../entities/location.dart';
import '../repositories/location_repo.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<Either<String, Location>> call() {
    return repository.getCurrentLocation();
  }
}
