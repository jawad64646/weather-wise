import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';

class SaveLocationUseCase {
  final LocationRepository repository;

  SaveLocationUseCase(this.repository);

  Future<void> call(LocationEntity location) async {
    await repository.saveLocation(location);
  }
}
