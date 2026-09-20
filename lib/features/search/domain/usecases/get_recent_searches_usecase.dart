import 'package:weatherwise/features/search/domain/entities/location_entity.dart';
import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';

class GetRecentSearchesUseCase {
  final LocationRepository repository;

  GetRecentSearchesUseCase(this.repository);

  List<LocationEntity> call() {
    return repository.getRecentSearches();
  }
}
