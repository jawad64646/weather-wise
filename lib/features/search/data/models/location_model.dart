import 'package:weatherwise/features/search/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required super.city, required super.lat, required super.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['city'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'lat': lat, 'lng': lng};
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(city: entity.city, lat: entity.lat, lng: entity.lng);
  }
}
