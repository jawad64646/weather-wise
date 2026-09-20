import 'package:fpdart/fpdart.dart';

import 'package:weatherwise/features/search/domain/entities/weatherentity.dart';
import 'package:weatherwise/features/search/domain/repositories/search_repo.dart';

class GetweathersearcheddataUsecase {
  final SearchRepo searchRepo;

  GetweathersearcheddataUsecase(this.searchRepo);

  Future<Either<String, WeatherSearchEntity>> call(
    double lat,
    double long,
  ) async {
    return await searchRepo.getweatherbylocation(lat, long);
  }
}
