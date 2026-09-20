import 'package:fpdart/fpdart.dart';

import 'package:weatherwise/features/search/domain/entities/SearchEntity.dart';
import 'package:weatherwise/features/search/domain/entities/weatherentity.dart';

abstract class SearchRepo {
  Future<Either<String, List<ResultEntity>>> getSearchedResult(String query);
  Future<Either<String, WeatherSearchEntity>> getweatherbylocation(
    double latitude,
    double longitude,
  );
}
