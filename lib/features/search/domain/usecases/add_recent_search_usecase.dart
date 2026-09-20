import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';

class AddRecentSearchUseCase {
  final LocationRepository repository;

  AddRecentSearchUseCase(this.repository);

  Future<void> call(LocationEntity location) async {
    await repository.addRecentSearch(location);
  }
}
