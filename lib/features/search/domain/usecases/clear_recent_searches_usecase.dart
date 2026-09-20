import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';

class ClearRecentSearchesUseCase {
  final LocationRepository repository;

  ClearRecentSearchesUseCase(this.repository);

  Future<void> call() async {
    await repository.clearRecentSearches();
  }
}
