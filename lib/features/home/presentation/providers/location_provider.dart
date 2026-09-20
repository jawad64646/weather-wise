import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/network/dio.dart';
import 'package:weatherwise/features/home/data/datasources/location_service.dart';
import 'package:weatherwise/features/home/data/repositories/location_repo_impl.dart';
import 'package:weatherwise/features/home/domain/entities/forcast_entity.dart';
import 'package:weatherwise/features/home/domain/entities/location.dart';
import 'package:weatherwise/features/home/domain/entities/weather_entity.dart';
import 'package:weatherwise/features/home/domain/repositories/location_repo.dart';
import 'package:weatherwise/features/home/domain/usecases/getForecast.dart';
import 'package:weatherwise/features/home/domain/usecases/get_weather_usecase.dart';
import 'package:weatherwise/features/home/domain/usecases/location_usecase.dart';

final dioclient = Provider<DioClient>((ref) {
  return DioClient();
});
// data sources:
final locationDataSourceProvider = Provider<LocationDataSource>((ref) {
  return LocationDataSourceImpl();
});

//repositories:
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl(ref.watch(locationDataSourceProvider));
});

//use cases:
final getCurrentLocationProvider = Provider<GetCurrentLocation>((ref) {
  return GetCurrentLocation(ref.read(locationRepositoryProvider));
});

final getCurrentWeatherProvider = Provider<GetWeatherUsecase>((ref) {
  return GetWeatherUsecase(ref.read(locationRepositoryProvider));
});

final getforecastProvider = Provider<Getforecast>((ref) {
  return Getforecast(ref.read(locationRepositoryProvider));
});

// providers:
final locationProvider = FutureProvider<Location>((ref) async {
  final result = await ref.read(getCurrentLocationProvider).call();

  return result.fold((error) => throw Exception(error), (location) => location);
});

final weatherProvider = FutureProvider<WeatherEntity>((ref) async {
  final result = await ref.read(getCurrentWeatherProvider).call();

  return result.fold((error) => throw Exception(error), (entity) => entity);
});

final forecastProvider = FutureProvider<ForecastEntity>((ref) async {
  final result = await ref.read(getforecastProvider).call();

  return result.fold((error) => throw Exception(error), (entity) => entity);
});
