import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/common/extensions/forcast_to_entity.dart';
import 'package:weatherwise/common/extensions/weather_to_entity.dart';

import 'package:weatherwise/features/home/data/datasources/location_service.dart';
import 'package:weatherwise/features/home/domain/entities/forcast_entity.dart';
import 'package:weatherwise/features/home/domain/entities/location.dart';
import 'package:weatherwise/features/home/domain/entities/weather_entity.dart';
import 'package:weatherwise/features/home/domain/repositories/location_repo.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Either<String, Location>> getCurrentLocation() async {
    try {
      final positionResult = await dataSource.getCurrentLocation();

      return await positionResult.fold(
        (error) async {
          return Left(error);
        },
        (position) async {
          final placemark = await dataSource.getPlacemark(
            position.latitude,
            position.longitude,
          );

          final city =
              placemark.locality ??
              placemark.subAdministrativeArea ??
              placemark.administrativeArea ??
              'Unknown';

          final country = placemark.country ?? 'Unknown';

          return Right(
            Location(
              latitude: position.latitude,
              longitude: position.longitude,
              city: city,
              country: country,
            ),
          );
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, WeatherEntity>> getCurrentWeather() async {
    final result = await dataSource.getCurrentWeather();

    return result.fold((l) => left(l), (r) => right(r.toEntity()));
  }

  @override
  Future<Either<String, ForecastEntity>> getForcast7Days() async {
    // TODO: implement getForcast7Days
    final result = await dataSource.getForcast7Days();

    return result.fold((l) => left(l), (r) => right(r.toEntity()));
  }
}
