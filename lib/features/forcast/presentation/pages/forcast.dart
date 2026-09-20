import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/common/extensions/datetime_extension.dart';
import 'package:weatherwise/common/helpers/weather_helpers.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/core/utils/code_to_image.dart';
import 'package:weatherwise/core/utils/temp_to_description.dart';
import 'package:weatherwise/features/forcast/presentation/providers/temp_convert_provider.dart';
import 'package:weatherwise/features/forcast/presentation/widgets/days_forecast.dart';
import 'package:weatherwise/features/forcast/presentation/widgets/text_button.dart';
import 'package:weatherwise/features/home/presentation/providers/location_provider.dart';

class Forcast extends ConsumerWidget {
  const Forcast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    final weather = ref.watch(weatherProvider);
    final currentUnit = ref.watch(tempCtoFprovider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: const Text(
          "Forecast",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        actions: [
          // Location Card
          Card(
            color: AppColors.cardLight,
            margin: const EdgeInsets.only(right: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    LucideIcons.map_pin,
                    color: AppColors.primaryLight,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  location.when(
                    loading: () => const Text(
                      'Getting location...',
                      style: TextStyle(fontSize: 12),
                    ),
                    error: (e, __) => const Text(
                      'Location unavailable',
                      style: TextStyle(fontSize: 12),
                    ),
                    data: (loc) => Text(
                      '${loc.city}, ${loc.country}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Unit Selection Card
          Card(
            color: AppColors.darkgray,
            margin: const EdgeInsets.only(right: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              height: 32,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UnitButton(
                    label: "°C",
                    isSelected: currentUnit == TemperatureUnit.C,
                    onPressed: () {
                      ref.read(tempCtoFprovider.notifier).state =
                          TemperatureUnit.C;
                    },
                  ),
                  UnitButton(
                    label: "°F",
                    isSelected: currentUnit == TemperatureUnit.F,
                    onPressed: () {
                      ref.read(tempCtoFprovider.notifier).state =
                          TemperatureUnit.F;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              header("Today's Summary", DateTime.now().toMonthDayString()),
              weather.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text(error.toString())),
                data: (weatherData) {
                  final dayaverage = computeSingleDayAverages(
                    weatherData,
                    DateTime.now(),
                  );

                  final List<Map<String, dynamic>> buildSummaryData = [
                    {
                      'title': "Morning",
                      'icon': getImageForTemp(dayaverage?.morningAvg ?? 0.0),
                      'temp': dayaverage?.morningAvg ?? 0.0,
                      'status': getTemperatureStatus(
                        dayaverage?.morningAvg ?? 0.0,
                      ),
                    },
                    {
                      'title': "AFTERNOON",
                      'icon': getImageForTemp(dayaverage?.afternoonAvg ?? 0.0),
                      'temp': dayaverage?.afternoonAvg ?? 0.0,
                      'status': getTemperatureStatus(
                        dayaverage?.afternoonAvg ?? 0.0,
                      ),
                    },
                    {
                      'title': "EVENING",
                      'icon': getImageForTemp(dayaverage?.eveningAvg ?? 0.0),
                      'temp': dayaverage?.eveningAvg ?? 0.0,
                      'status': getTemperatureStatus(
                        dayaverage?.eveningAvg ?? 0.0,
                      ),
                    },
                  ];

                  return SizedBox(
                    height: 160,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      itemCount: buildSummaryData.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12.0),
                      itemBuilder: (context, index) {
                        return _cardSummary(
                          buildSummaryData[index],
                          currentUnit,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              DaysForecast(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(String title, String tailingText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(
            tailingText,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _cardSummary(Map<String, dynamic> item, TemperatureUnit unit) {
    final double rawTemp = item['temp'] as double;
    final double displayTemp = unit == TemperatureUnit.F
        ? (rawTemp * 9 / 5) + 32
        : rawTemp;
    final String unitLabel = unit == TemperatureUnit.F ? '°F' : '°C';

    return SizedBox(
      height: 160,
      width: 120,
      child: Card(
        color: AppColors.cardLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(item['title'], style: const TextStyle(fontWeight: .w500)),
              const SizedBox(height: 8),
              Image.asset(
                item['icon'],
                height: 40,
                width: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.wb_sunny),
              ),
              const SizedBox(height: 8),
              Text('${displayTemp.toStringAsFixed(1)}$unitLabel'),
              const SizedBox(height: 8),
              Text('${item['status']}'),
            ],
          ),
        ),
      ),
    );
  }
}
