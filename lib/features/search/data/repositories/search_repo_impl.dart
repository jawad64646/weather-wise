import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/common/extensions/Search_to_entity.dart';

import 'package:weatherwise/features/search/data/datasources/search_data_source.dart';
import 'package:weatherwise/features/search/data/models/waethermodel.dart';

import 'package:weatherwise/features/search/domain/entities/SearchEntity.dart';
import 'package:weatherwise/features/search/domain/entities/weatherentity.dart';
import 'package:weatherwise/features/search/domain/repositories/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource dataSource;

  SearchRepoImpl(this.dataSource);

  @override
  Future<Either<String, List<ResultEntity>>> getSearchedResult(
    String query,
  ) async {
    final result = await dataSource.getSearchedResult(query);

    return result.map(
      (models) => models.map((model) => model.toEntity()).toList(),
    );
  }

  @override
  Future<Either<String, WeatherSearchEntity>> getweatherbylocation(
    double latitude,
    double longitude,
  ) async {
    final result = await dataSource.getweatherbylocation(latitude, longitude);

    return result.fold((l) => left(l), (r) => right(r.toEntity()));
  }
}
