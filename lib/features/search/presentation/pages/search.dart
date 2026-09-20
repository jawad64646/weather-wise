import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/core/configs/theme/app_colors.dart';

import 'package:weatherwise/features/search/presentation/pages/waether_detail_location.dart';
import 'package:weatherwise/features/search/presentation/providers/search_providers.dart';
import 'package:weatherwise/features/search/presentation/widgets/recentsearcedlist.dart';
import 'package:weatherwise/features/search/presentation/widgets/savedlist.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsyncValue = ref.watch(searchResultsProvider(_query));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          "Search Location",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.locate_fixed,
                  color: AppColors.primaryLight,
                  size: 15,
                ),
                const SizedBox(width: 4),
                const Text("Worldwide"),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Pick Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Search weather location",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 15),
            _searchTextField(),
            const SizedBox(height: 15),

            if (_query.trim().isNotEmpty) ...[
              searchAsyncValue.when(
                data: (results) {
                  if (results.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(child: Text("No locations found.")),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Matching Locations",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${results.length} results",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: results.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final location = results[index];
                          return ListTile(
                            tileColor: AppColors.cardLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: AppColors.borderLight),
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                LucideIcons.map_pin,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(location.name ?? "no name"),
                            subtitle: Text(
                              [
                                if (location.admin1 != null) location.admin1,
                                if (location.country != null) location.country,
                              ].join(', '),
                            ),
                            trailing: const Icon(
                              LucideIcons.arrow_big_right_dash,
                              color: AppColors.primaryLight,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WaetherDetailLocation(
                                    clickeditem: location,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Text(
                      error.toString().replaceAll('Exception: ', ''),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ] else ...[
              const AsyncSavedLocationsScreen(),

              const SizedBox(height: 15),

              AsyncRecentSearchesWidget(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _query = value;
        });
      },
      decoration: InputDecoration(
        hintText: "Search city or country...",
        prefixIconColor: AppColors.primaryLight,
        prefixIcon: const Icon(LucideIcons.search),
        suffixIcon: _query.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _query = '';
                  });
                },
              )
            : null,
      ),
    );
  }
}
