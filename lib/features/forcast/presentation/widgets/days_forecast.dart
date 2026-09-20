import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/common/extensions/datetime_extension.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/core/utils/code_to_image.dart';
import 'package:weatherwise/core/utils/temp_to_description.dart';
import 'package:weatherwise/features/forcast/presentation/widgets/header.dart';
import 'package:weatherwise/features/home/presentation/providers/location_provider.dart';

class DaysForecast extends ConsumerWidget {
  const DaysForecast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastprovider = ref.watch(forecastProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          header("7-Day Forecast", "MIN / MAX"),
          Card(
            color: AppColors.cardLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: forecastprovider.when(
                data: (data) {
                  final daily = data.daily;
                  final itemCount = daily?.time.length ?? 0;

                  if (itemCount == 0) {
                    return const Center(
                      child: Text("No forecast data available"),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemCount > 7 ? 7 : itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return _DaysCard(
                        code: daily?.weatherCode[index] ?? 0,
                        date: daily?.time[index] ?? DateTime.now(),
                        min: daily?.temperature2MMin[index] ?? 0.0,
                        max: daily?.temperature2MMax[index] ?? 0.0,
                        parti: daily?.precipitationProbabilityMax[index] ?? 0,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: AppColors.dividerLight);
                    },
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Text(error.toString())),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DaysCard extends StatelessWidget {
  final int code;
  final DateTime date;
  final double min;
  final double max;
  final int parti;

  const _DaysCard({
    required this.code,
    required this.date,
    required this.min,
    required this.max,
    required this.parti,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                getWeatherImage(code),
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date.getWeekdayName(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    getWeatherDescription(code),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                LucideIcons.droplets,
                size: 18,
                color: getPrecipitationColor(parti),
              ),
              const SizedBox(width: 4),
              Text("$parti%"),
              const SizedBox(width: 16),
              Text(
                "${max.round()}° / ${min.round()}°",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
