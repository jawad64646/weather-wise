import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/features/search/domain/entities/location_entity.dart';
import 'package:weatherwise/features/search/presentation/providers/local_hive_providers.dart';

class ToggleSavedButton extends ConsumerWidget {
  final LocationEntity location;

  const ToggleSavedButton({super.key, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch saved locations list
    final savedLocationsAsync = ref.watch(asyncSavedLocationsProvider);

    // Check if location is currently saved
    final isSaved = savedLocationsAsync.maybeWhen(
      data: (locations) => locations.any((item) => item.city == location.city),
      orElse: () => false,
    );

    return IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved ? Colors.blue : null,
      ),
      onPressed: () {
        ref
            .read(asyncSavedLocationsProvider.notifier)
            .toggleSaveLocation(location);
      },
    );
  }
}
