import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:weatherwise/core/configs/constants/app_urls.dart';
import 'package:weatherwise/core/network/dio.dart';
import 'package:weatherwise/features/search/data/models/waethermodel.dart'; // Adjust import path
import 'package:weatherwise/features/search/data/models/searchModelResult.dart';

abstract class SearchDataSource {
  Future<Either<String, List<SearchResult>>> getSearchedResult(String query);
  Future<Either<String, WeatherModel>> getweatherbylocation(
    double latitude,
    double longitude,
  );
}

class SearchDataSourceImpl implements SearchDataSource {
  final DioClient dioClient;

  SearchDataSourceImpl({DioClient? dioClient})
    : dioClient = dioClient ?? DioClient();

  @override
  Future<Either<String, List<SearchResult>>> getSearchedResult(
    String query,
  ) async {
    final cleanQuery = query.trim();

    if (cleanQuery.isEmpty) {
      return const Left("Enter Country or city");
    }

    try {
      final response = await dioClient.get(
        AppUrls.searchURLBase,
        queryParameters: {
          'name': cleanQuery,
          'count': 4,
          'language': 'en',
          'format': 'json',
        },
      );

      final List<dynamic>? rawResults = response.data['results'];

      if (rawResults == null || rawResults.isEmpty) {
        return const Right([]);
      }

      final results = rawResults
          .map((json) => SearchResult.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(results);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['reason'] ?? e.message ?? "Network error occurred";
      return Left(errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, WeatherModel>> getweatherbylocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await dioClient.get(
        AppUrls.weatherURLbase,
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current': 'temperature_2m,apparent_temperature,weather_code',
        },
      );

      final currentData = response.data['current'];

      if (currentData == null) {
        return const Left("Weather data is unavailable");
      }

      final currentWeather = WeatherModel.fromJson(
        currentData as Map<String, dynamic>,
      );

      return Right(currentWeather);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['reason'] ?? e.message ?? "Network error occurred";
      return Left(errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }
}
