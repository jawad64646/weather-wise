import 'package:weatherwise/features/search/data/models/searchModelResult.dart';
import 'package:weatherwise/features/search/domain/entities/SearchEntity.dart';

extension SearchModelToEntity on SearchResult {
  ResultEntity toEntity() {
    return ResultEntity(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      elevation: elevation,
      featureCode: featureCode,
      countryCode: countryCode,
      admin1Id: admin1Id,
      timezone: timezone,
      population: population,
      countryId: countryId,
      country: country,
      admin1: admin1,
      admin2Id: admin2Id,
      admin3Id: admin3Id,
      admin2: admin2,
      admin3: admin3,
    );
  }
}
