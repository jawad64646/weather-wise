import 'package:weatherwise/core/storage/hiveService.dart';

abstract class LocationLocalDataSource {
  Future<void> saveLocation(Map<String, dynamic> locationData);
  Future<void> removeSavedLocation(String cityKey);
  List<Map<String, dynamic>> getSavedLocations();
  bool isSaved(String cityKey);

  Future<void> addRecentSearch(Map<String, dynamic> locationData);
  List<Map<String, dynamic>> getRecentSearches();
  Future<void> clearRecentSearches();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final StorageService _storage;

  static const String savedBoxName = 'saved_locations';
  static const String recentBoxName = 'recent_searches';
  static const int maxRecentSearches = 10;

  LocationLocalDataSourceImpl(this._storage);

  // ---------------- Saved Locations Operations ----------------

  @override
  Future<void> saveLocation(Map<String, dynamic> locationData) async {
    final key = locationData['city'] as String;
    await _storage.put<Map>(savedBoxName, key, locationData);
  }

  @override
  Future<void> removeSavedLocation(String cityKey) async {
    await _storage.delete(savedBoxName, cityKey);
  }

  @override
  List<Map<String, dynamic>> getSavedLocations() {
    final rawData = _storage.getAll<Map>(savedBoxName);
    return rawData.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  @override
  bool isSaved(String cityKey) {
    return _storage.containsKey(savedBoxName, cityKey);
  }

  // ---------------- Recent Searches Operations ----------------

  @override
  Future<void> addRecentSearch(Map<String, dynamic> locationData) async {
    final key = locationData['city'] as String;

    if (_storage.containsKey(recentBoxName, key)) {
      await _storage.delete(recentBoxName, key);
    }

    await _storage.put<Map>(recentBoxName, key, locationData);

    if (_storage.getLength(recentBoxName) > maxRecentSearches) {
      await _storage.deleteAt(recentBoxName, 0);
    }
  }

  @override
  List<Map<String, dynamic>> getRecentSearches() {
    final rawData = _storage.getAll<Map>(recentBoxName);
    return rawData
        .map((item) => Map<String, dynamic>.from(item))
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<void> clearRecentSearches() async {
    await _storage.clear(recentBoxName);
  }
}
