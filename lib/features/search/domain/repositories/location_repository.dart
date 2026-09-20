import 'package:weatherwise/features/search/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<void> saveLocation(LocationEntity location);
  Future<void> removeSavedLocation(String cityKey);
  List<LocationEntity> getSavedLocations();
  bool isSaved(String cityKey);

  Future<void> addRecentSearch(LocationEntity location);
  List<LocationEntity> getRecentSearches();
  Future<void> clearRecentSearches();
}
