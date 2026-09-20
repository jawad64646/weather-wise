import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/common/extensions/datetime_extension.dart';

import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/core/navigation/navigation.dart';

import 'package:weatherwise/core/utils/temp_to_description.dart';
import 'package:weatherwise/features/home/presentation/widgets/card_hour.dart';
import 'package:weatherwise/features/home/presentation/widgets/current_weather.dart';
import 'package:weatherwise/features/home/presentation/widgets/detail_weather.dart';

import '../providers/location_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final ScrollController _scrollController;
  static const double _itemWidth = 80.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;
    final targetOffset = index * (_itemWidth + 8.0); // Including item spacing

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider);
    final weather = ref.watch(weatherProvider);

    // Automatically scroll to the current hour when weather data updates
    ref.listen(weatherProvider, (previous, next) {
      next.whenData((weatherData) {
        final currentHourIndex = weatherData.hourly.time.indexWhere((time) {
          final parsedDate = DateTime.parse(time);
          return parsedDate.hour == DateTime.now().hour;
        });

        if (currentHourIndex != -1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToIndex(currentHourIndex);
          });
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardLight,
        titleSpacing: 0,
        leading: const Icon(LucideIcons.map_pin, color: AppColors.primaryLight),
        title: location.when(
          loading: () => const Text('Getting location...'),
          error: (e, __) => const Text('Location unavailable'),
          data: (loc) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${loc.city}, ${loc.country}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateTime.now().formatDateTime(),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMutedL,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(locationProvider);
              ref.invalidate(weatherProvider);
            },
            icon: const Icon(
              LucideIcons.refresh_cw,
              color: AppColors.textMutedL,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.bell, color: AppColors.textMutedL),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: weather.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (weatherData) {
          final weatherInfo = buildWeatherInfo(weatherData);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      weatherImage(
                        weatherData.current.weatherCode,
                        weatherData.current.isDay,
                      ),
                      const SizedBox(height: 10),
                      currentTemp(
                        weatherData.current.temperature2m,
                        weatherData.currentUnits.temperature2m,
                      ),
                      const SizedBox(height: 5),
                      getWeatherStatus(
                        getWeatherDescription(weatherData.current.weatherCode),
                      ),
                      const SizedBox(height: 5),
                      getWeatherInformation(
                        weatherData.daily.temperature2mMin[0],
                        weatherData.daily.temperature2mMax[0],
                        weatherData.current.apparentTemperature,
                      ),
                      const SizedBox(height: 15),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.5,
                            ),
                        itemCount: weatherInfo.length,
                        itemBuilder: (context, index) {
                          final item = weatherInfo[index];
                          return cardDetailWeather(
                            item['title'],
                            item['icon'],
                            item['value'],
                            item['unit'],
                            item['detail'],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hourly Forecast",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Next 24 hours",
                              style: TextStyle(
                                color: AppColors.textMutedL,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: weatherData.hourly.time.length > 24
                              ? 24
                              : weatherData.hourly.time.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final timeString = weatherData.hourly.time[index];
                            final parsedDate = DateTime.parse(timeString);
                            final isNow =
                                parsedDate.hour == DateTime.now().hour;

                            return SizedBox(
                              width: _itemWidth,
                              child: cardHour(
                                '${parsedDate.hour}:00',
                                weatherData.hourly.weatherCode[index],
                                weatherData.hourly.temperature2m[index],
                                isNow,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      NavigationService.navigateTo("/Search");
                    },
                    child: const Text("View 7-Day Forecast"),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
