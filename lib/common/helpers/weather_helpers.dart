import 'package:weatherwise/features/home/domain/entities/weather_entity.dart';

/// Helper to compute average of a list of doubles
double? calculateAverage(List<double> values) {
  if (values.isEmpty) return null;
  final sum = values.reduce((a, b) => a + b);
  return double.parse((sum / values.length).toStringAsFixed(2));
}

/// Computes averages for Morning, Afternoon, and Evening for a single specific day.
DayAverages? computeSingleDayAverages(WeatherEntity data, DateTime targetDate) {
  // Format the target date to YYYY-MM-DD
  final String targetDateStr = targetDate.toIso8601String().split('T').first;

  final List<double> morningTemps = [];
  final List<double> afternoonTemps = [];
  final List<double> eveningTemps = [];

  bool foundData = false;

  for (int i = 0; i < data.current.time.length; i++) {
    DateTime datetime = DateTime.parse(data.hourly.time[i]);
    final currentDateStr = datetime.toIso8601String().split('T').first;

    // Only process data if it matches the target date
    if (currentDateStr == targetDateStr) {
      foundData = true;
      final hour = datetime.hour;
      final temp = data.hourly.temperature2m[i];

      if (hour >= 6 && hour < 12) {
        morningTemps.add(temp);
      } else if (hour >= 12 && hour < 18) {
        afternoonTemps.add(temp);
      } else if (hour >= 18 && hour < 24) {
        eveningTemps.add(temp);
      }
    }
  }

  // Return null if the requested date isn't in the JSON data
  if (!foundData) return null;

  return DayAverages(
    date: targetDateStr,
    morningAvg: calculateAverage(morningTemps),
    afternoonAvg: calculateAverage(afternoonTemps),
    eveningAvg: calculateAverage(eveningTemps),
  );
}

class DayAverages {
  final String date;
  final double? morningAvg; // 06:00 - 11:59
  final double? afternoonAvg; // 12:00 - 17:59
  final double? eveningAvg; // 18:00 - 23:59

  DayAverages({
    required this.date,
    this.morningAvg,
    this.afternoonAvg,
    this.eveningAvg,
  });
}
