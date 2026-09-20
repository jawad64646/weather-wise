import 'package:hive_flutter/hive_flutter.dart';

abstract class StorageService {
  Future<void> init();
  Future<void> put<T>(String boxName, String key, T value);
  T? get<T>(String boxName, String key);
  List<T> getAll<T>(String boxName);
  Future<void> delete(String boxName, String key);
  Future<void> deleteAt(String boxName, int index);
  Future<void> clear(String boxName);
  bool containsKey(String boxName, String key);
  int getLength(String boxName);
}

class HiveStorageService implements StorageService {
  @override
  Future<void> init() async {
    await Hive.initFlutter();
  }

  // Safely retrieve an open box without forcing strict generic type mismatches
  Box _getBox(String boxName) {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }
    throw HiveError(
      'Box "$boxName" is not opened. Open the box before accessing it.',
    );
  }

  Future<Box> _openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }
    return await Hive.openBox(boxName);
  }

  @override
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  @override
  T? get<T>(String boxName, String key) {
    final box = _getBox(boxName);
    return box.get(key) as T?;
  }

  @override
  List<T> getAll<T>(String boxName) {
    final box = _getBox(boxName);
    return box.values.cast<T>().toList();
  }

  @override
  Future<void> delete(String boxName, String key) async {
    final box = _getBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> deleteAt(String boxName, int index) async {
    final box = _getBox(boxName);
    await box.deleteAt(index);
  }

  @override
  Future<void> clear(String boxName) async {
    final box = _getBox(boxName);
    await box.clear();
  }

  @override
  bool containsKey(String boxName, String key) {
    final box = _getBox(boxName);
    return box.containsKey(key);
  }

  @override
  int getLength(String boxName) {
    final box = _getBox(boxName);
    return box.length;
  }
}
