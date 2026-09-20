import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/features/home/presentation/widgets/current_weather.dart';
import 'package:weatherwise/features/search/domain/entities/SearchEntity.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';
import 'package:weatherwise/features/search/presentation/providers/local_hive_providers.dart';
import 'package:weatherwise/features/search/presentation/providers/search_providers.dart';
import 'package:weatherwise/features/search/presentation/widgets/ToggleSavedButton.dart';

class WaetherDetailLocation extends ConsumerStatefulWidget {
  final ResultEntity clickeditem;

  const WaetherDetailLocation({super.key, required this.clickeditem});

  @override
  ConsumerState<WaetherDetailLocation> createState() =>
      _WaetherDetailLocationState();
}

class _WaetherDetailLocationState extends ConsumerState<WaetherDetailLocation> {
  @override
  void initState() {
    super.initState();

    final lat = widget.clickeditem.latitude;
    final lng = widget.clickeditem.longitude;

    if (lat != null && lng != null) {
      final locationEntity = LocationEntity(
        city:
            widget.clickeditem.name ?? widget.clickeditem.country ?? 'Unknown',
        lat: lat,
        lng: lng,
      );

      // Add to recent search history after layout build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(asyncRecentSearchesProvider.notifier)
            .addRecentSearch(locationEntity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = widget.clickeditem.latitude;
    final lng = widget.clickeditem.longitude;

    if (lat == null || lng == null) {
      return const Scaffold(
        body: Center(child: Text("Invalid location coordinates.")),
      );
    }

    final weatherAsync = ref.watch(
      getWeatherByLocationProvider((lat: lat, lng: lng)),
    );

    final locationEntity = LocationEntity(
      city: widget.clickeditem.name ?? widget.clickeditem.country ?? 'Unknown',
      lat: lat,
      lng: lng,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _header(context, locationEntity),
            const SizedBox(height: 15),
            Card(
              color: AppColors.cardLight,
              child: Center(
                child: weatherAsync.when(
                  data: (data) {
                    return Column(
                      children: [
                        weatherImage2(data.weatherCode),
                        const SizedBox(height: 12),
                        currentTemp(data.temperature2M, "C"),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: const BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                            widthFactor: 1.0,
                            child: Text("${data.apparentTemperature}°C"),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Error: $error"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, LocationEntity location) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              LucideIcons.arrow_big_left_dash,
              color: AppColors.black,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              widget.clickeditem.country ?? "Unknown",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            if (widget.clickeditem.admin1 != null) ...[
              const SizedBox(width: 4),
              Text(
                "(${widget.clickeditem.admin1})",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ToggleSavedButton(location: location),
        ),
      ],
    );
  }
}
