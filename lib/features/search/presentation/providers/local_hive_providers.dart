import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/storage/hiveService.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';
import 'package:weatherwise/features/search/domain/repositories/location_repository.dart';
import 'package:weatherwise/features/search/data/repositories/location_repository_impl.dart';
import 'package:weatherwise/features/search/data/datasources/location_local_datasource.dart';
import 'package:weatherwise/features/search/domain/usecases/add_recent_search_usecase.dart';
import 'package:weatherwise/features/search/domain/usecases/clear_recent_searches_usecase.dart';
import 'package:weatherwise/features/search/domain/usecases/get_recent_searches_usecase.dart';
import 'package:weatherwise/features/search/domain/usecases/get_saved_locations_usecase.dart';
import 'package:weatherwise/features/search/domain/usecases/remove_saved_location_usecase.dart';
import 'package:weatherwise/features/search/domain/usecases/save_location_usecase.dart';

// 1. Storage Service Provider
final storageServiceProvider = Provider<StorageService>((ref) {
  return HiveStorageService();
});

// 2. Local Data Source Provider
final locationLocalDataSourceProvider = Provider<LocationLocalDataSource>((
  ref,
) {
  final storage = ref.watch(storageServiceProvider);
  return LocationLocalDataSourceImpl(storage);
});

// 3. Repository Provider
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final localDataSource = ref.watch(locationLocalDataSourceProvider);
  return LocationRepositoryImpl(localDataSource: localDataSource);
});

// 4. Use Cases Providers
final getSavedLocationsUseCaseProvider = Provider<GetSavedLocationsUseCase>((
  ref,
) {
  return GetSavedLocationsUseCase(ref.watch(locationRepositoryProvider));
});

final saveLocationUseCaseProvider = Provider<SaveLocationUseCase>((ref) {
  return SaveLocationUseCase(ref.watch(locationRepositoryProvider));
});

final removeSavedLocationUseCaseProvider = Provider<RemoveSavedLocationUseCase>(
  (ref) {
    return RemoveSavedLocationUseCase(ref.watch(locationRepositoryProvider));
  },
);

final getRecentSearchesUseCaseProvider = Provider<GetRecentSearchesUseCase>((
  ref,
) {
  return GetRecentSearchesUseCase(ref.watch(locationRepositoryProvider));
});

final addRecentSearchUseCaseProvider = Provider<AddRecentSearchUseCase>((ref) {
  return AddRecentSearchUseCase(ref.watch(locationRepositoryProvider));
});

final clearRecentSearchesUseCaseProvider = Provider<ClearRecentSearchesUseCase>(
  (ref) {
    return ClearRecentSearchesUseCase(ref.watch(locationRepositoryProvider));
  },
);

// ---------------- Saved Locations Notifier & Provider ----------------

class AsyncSavedLocationsNotifier extends AsyncNotifier<List<LocationEntity>> {
  @override
  Future<List<LocationEntity>> build() async {
    final useCase = ref.watch(getSavedLocationsUseCaseProvider);
    return await useCase();
  }

  Future<void> toggleSaveLocation(LocationEntity location) async {
    final isCurrentlySaved =
        state.value?.any((item) => item.city == location.city) ?? false;

    if (isCurrentlySaved) {
      await removeLocation(location.city);
    } else {
      await saveLocation(location);
    }
  }

  Future<void> saveLocation(LocationEntity location) async {
    final saveUseCase = ref.read(saveLocationUseCaseProvider);
    final getUseCase = ref.read(getSavedLocationsUseCaseProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await saveUseCase(location);
      return await getUseCase();
    });
  }

  Future<void> removeLocation(String cityKey) async {
    final removeUseCase = ref.read(removeSavedLocationUseCaseProvider);
    final getUseCase = ref.read(getSavedLocationsUseCaseProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await removeUseCase(cityKey);
      return await getUseCase();
    });
  }
}

final asyncSavedLocationsProvider =
    AsyncNotifierProvider<AsyncSavedLocationsNotifier, List<LocationEntity>>(
      AsyncSavedLocationsNotifier.new,
    );

// ---------------- Recent Searches Notifier & Provider ----------------

class AsyncRecentSearchesNotifier extends AsyncNotifier<List<LocationEntity>> {
  @override
  Future<List<LocationEntity>> build() async {
    final useCase = ref.watch(getRecentSearchesUseCaseProvider);
    return await useCase();
  }

  Future<void> addRecentSearch(LocationEntity location) async {
    final addUseCase = ref.read(addRecentSearchUseCaseProvider);
    final getUseCase = ref.read(getRecentSearchesUseCaseProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await addUseCase(location);
      return await getUseCase();
    });
  }

  Future<void> clearRecentSearches() async {
    final clearUseCase = ref.read(clearRecentSearchesUseCaseProvider);
    final getUseCase = ref.read(getRecentSearchesUseCaseProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await clearUseCase();
      return await getUseCase();
    });
  }
}

final asyncRecentSearchesProvider =
    AsyncNotifierProvider<AsyncRecentSearchesNotifier, List<LocationEntity>>(
      AsyncRecentSearchesNotifier.new,
    );
