import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/network/dio.dart';
import 'package:weatherwise/features/search/data/datasources/search_data_source.dart';
import 'package:weatherwise/features/search/data/repositories/search_repo_impl.dart';
import 'package:weatherwise/features/search/domain/entities/SearchEntity.dart';
import 'package:weatherwise/features/search/domain/entities/weatherentity.dart';
import 'package:weatherwise/features/search/domain/repositories/search_repo.dart';
import 'package:weatherwise/features/search/domain/usecases/getweathersearcheddata_usecase.dart';

import 'package:weatherwise/features/search/domain/usecases/searchResult_usecase.dart';

// 1. Core / Network Provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

// 2. Data Source Provider
final searchDataSourceProvider = Provider<SearchDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SearchDataSourceImpl(dioClient: dioClient);
});

// 3. Repository Provider
final searchRepoProvider = Provider<SearchRepo>((ref) {
  final dataSource = ref.watch(searchDataSourceProvider);
  return SearchRepoImpl(dataSource);
});

// 4. Use Case Provider
final getSearchedResultUseCaseProvider = Provider<GetSearchedResultUseCase>((
  ref,
) {
  final repo = ref.watch(searchRepoProvider);
  return GetSearchedResultUseCase(repo);
});

final getweathersearcheddataProvider = Provider<GetweathersearcheddataUsecase>((
  ref,
) {
  final repo = ref.watch(searchRepoProvider);
  return GetweathersearcheddataUsecase(repo);
});

//Future providers
final searchResultsProvider = FutureProvider.family<List<ResultEntity>, String>(
  (ref, query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final useCase = ref.watch(getSearchedResultUseCaseProvider);
    final result = await useCase(query);

    return result.fold(
      (errorMessage) => throw Exception(errorMessage),
      (results) => results,
    );
  },
);

// Custom parameter class or record for coordinates
typedef LocationParams = ({double lat, double lng});

final getWeatherByLocationProvider =
    FutureProvider.family<WeatherSearchEntity, LocationParams>((
      ref,
      params,
    ) async {
      final useCase = ref.watch(getweathersearcheddataProvider);
      final result = await useCase(params.lat, params.lng);

      return result.fold(
        (errorMessage) => throw Exception(errorMessage),
        (weatherEntity) => weatherEntity,
      );
    });
