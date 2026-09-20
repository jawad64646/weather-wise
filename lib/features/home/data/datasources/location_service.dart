import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherwise/core/network/dio.dart';
import 'package:weatherwise/features/home/data/models/forcast_7days_model.dart';
import 'package:weatherwise/features/home/data/models/weather_model.dart';

abstract class LocationDataSource {
  Future<Either<String, Position>> getCurrentLocation();
  Future<Either<String, WeatherModel>> getCurrentWeather();
  Future<Placemark> getPlacemark(double latitude, double longitude);
  Future<Either<String, ForecastModel>> getForcast7Days();
}

class LocationDataSourceImpl implements LocationDataSource {
  final DioClient dioClient;

  LocationDataSourceImpl({DioClient? dioClient})
    : dioClient = dioClient ?? DioClient();

  @override
  Future<Either<String, Position>> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return left('Location services are disabled.');
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        return left('Location permission was denied.');
      }

      if (permission == LocationPermission.deniedForever) {
        return left('Location permission is permanently denied.');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return right(position);
    } catch (e) {
      return left('Unable to get current location: $e');
    }
  }

  @override
  Future<Placemark> getPlacemark(double lat, double lon) async {
    try {
      final response = await dioClient.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {'lat': lat, 'lon': lon, 'format': 'json'},
        options: Options(
          headers: {
            'User-Agent': 'WeatherWiseApp/1.0 (contact@yourdomain.com)',
          },
        ),
      );

      final address = response.data['address'] as Map<String, dynamic>?;

      if (address == null) return Placemark(locality: 'Unknown Location');

      return Placemark(
        name: address['road'] ?? address['suburb'],
        locality:
            address['city'] ??
            address['town'] ??
            address['village'] ??
            address['county'],
        administrativeArea: address['state'],
        country: address['country'],
        postalCode: address['postcode'],
      );
    } catch (e) {
      return Placemark(locality: 'Unknown Location');
    }
  }

  @override
  Future<Either<String, WeatherModel>> getCurrentWeather() async {
    final locationResult = await getCurrentLocation();

    return locationResult.fold((failure) => left(failure), (position) async {
      try {
        final response = await dioClient.get(
          'https://api.open-meteo.com/v1/forecast',
          queryParameters: {
            'latitude': position.latitude,
            'longitude': position.longitude,
            'current': 'temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,dew_point_2m,uv_index',
            'hourly': 'temperature_2m,weather_code',
            'daily': 'temperature_2m_max,temperature_2m_min',
            'timezone': 'auto',
          },
        );

        final data = WeatherModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        return right(data);
      } catch (e) {
        return left('Failed to fetch weather data: $e');
      }
    });
  }

  @override
  Future<Either<String, ForecastModel>> getForcast7Days() async {
    final locationResult = await getCurrentLocation();
    // https: //api.open-meteo.com/v1/forecast?latitude=33.8938&longitude=35.5018&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min,weather_code,precipitation_sum,precipitation_probability_max&timezone=auto
    return locationResult.fold((failure) => left(failure), (position) async {
      try {
        final response = await dioClient.get(
          'https://api.open-meteo.com/v1/forecast',
          queryParameters: {
            'latitude': position.latitude,
            'longitude': position.longitude,
            'current': 'temperature_2m',

            'daily': 'temperature_2m_max,temperature_2m_min,weather_code,precipitation_sum,precipitation_probability_max',
            'timezone': 'auto',
          },
        );

        final data = ForecastModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        return right(data);
      } catch (e) {
        return left('Failed to fetch weather data: $e');
      }
    });
  }
}
