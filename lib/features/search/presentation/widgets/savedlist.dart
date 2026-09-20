import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/features/search/presentation/providers/local_hive_providers.dart';

class AsyncSavedLocationsScreen extends ConsumerWidget {
  const AsyncSavedLocationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedLocationsAsync = ref.watch(asyncSavedLocationsProvider);

    return savedLocationsAsync.when(
      data: (locations) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bookmark_add),
                      SizedBox(width: 8),
                      Text(
                        "Saved Locations",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${locations.length} saved',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Empty state or List view
            if (locations.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: Text('No saved locations yet.')),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: locations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return ListTile(
                    tileColor: AppColors.cardLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppColors.primaryLight, width: 2),
                    ),
                    title: Text(location.city),
                    subtitle: Text(
                      'Lat: ${location.lat}, Lng: ${location.lng}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(asyncSavedLocationsProvider.notifier)
                            .removeLocation(location.city);
                      },
                    ),
                  );
                },
              ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: Text('Error: $error')),
      ),
    );
  }
}
