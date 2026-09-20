import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';
import 'package:weatherwise/features/search/presentation/providers/local_hive_providers.dart';

class AsyncRecentSearchesWidget extends ConsumerWidget {
  const AsyncRecentSearchesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearchesAsync = ref.watch(asyncRecentSearchesProvider);

    return recentSearchesAsync.when(
      data: (locations) {
        if (locations.isEmpty) {
          return SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(asyncRecentSearchesProvider.notifier)
                        .clearRecentSearches();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: locations.map((location) {
                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // Action when tapping a recent search chip
                  },
                  child: Chip(
                    backgroundColor: AppColors.cardLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                    avatar: const Icon(
                      Icons.history,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    label: Text(location.city),
                  ),
                );
              }).toList(),
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
