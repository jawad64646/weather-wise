import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';
import 'package:weatherwise/features/search/data/datasources/location_local_datasource.dart';
import 'package:weatherwise/features/search/data/models/location_model.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveLocation(LocationEntity location) async {
    final model = LocationModel.fromEntity(location);
    await localDataSource.saveLocation(model.toJson());
  }

  @override
  Future<void> removeSavedLocation(String cityKey) async {
    await localDataSource.removeSavedLocation(cityKey);
  }

  @override
  List<LocationEntity> getSavedLocations() {
    final listMap = localDataSource.getSavedLocations();
    return listMap.map((map) => LocationModel.fromJson(map)).toList();
  }

  @override
  bool isSaved(String cityKey) {
    return localDataSource.isSaved(cityKey);
  }

  @override
  Future<void> addRecentSearch(LocationEntity location) async {
    final model = LocationModel.fromEntity(location);
    await localDataSource.addRecentSearch(model.toJson());
  }

  @override
  List<LocationEntity> getRecentSearches() {
    final listMap = localDataSource.getRecentSearches();
    return listMap.map((map) => LocationModel.fromJson(map)).toList();
  }

  @override
  Future<void> clearRecentSearches() async {
    await localDataSource.clearRecentSearches();
  }
}
