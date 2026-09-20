import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';

class GetSavedLocationsUseCase {
  final LocationRepository repository;

  GetSavedLocationsUseCase(this.repository);

  List<LocationEntity> call() {
    return repository.getSavedLocations();
  }
}
