class ResultEntity {
  ResultEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    required this.admin1Id,
    required this.timezone,
    required this.population,
    required this.countryId,
    required this.country,
    required this.admin1,
    required this.admin2Id,
    required this.admin3Id,
    required this.admin2,
    required this.admin3,
  });

  final int? id;
  final String? name;
  final double? latitude;
  final double? longitude;
  final int? elevation;
  final String? featureCode;
  final String? countryCode;
  final int? admin1Id;
  final String? timezone;
  final int? population;
  final int? countryId;
  final String? country;
  final String? admin1;
  final int? admin2Id;
  final int? admin3Id;
  final String? admin2;
  final String? admin3;
}

// https://api.open-meteo.com/v1/forecast?latitude=35.6895&longitude=139.69171&current=temperature_2m,weather_code
