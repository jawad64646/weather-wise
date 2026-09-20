import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';

class RemoveSavedLocationUseCase {
  final LocationRepository repository;

  RemoveSavedLocationUseCase(this.repository);

  Future<void> call(String cityKey) async {
    await repository.removeSavedLocation(cityKey);
  }
}
