import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherwise/common/providers/theme_provider.dart';
import 'package:weatherwise/core/configs/theme/app_theme.dart';
import 'package:weatherwise/core/navigation/navigation.dart';
import 'package:weatherwise/core/storage/hiveService.dart';
import 'package:weatherwise/core/storage/shared_storage.dart';
import 'package:weatherwise/features/home/presentation/pages/base.dart';
import 'package:weatherwise/features/home/presentation/pages/home.dart';
import 'package:weatherwise/features/search/data/datasources/location_local_datasource.dart';
import 'package:weatherwise/features/search/presentation/pages/search.dart';
import 'package:weatherwise/features/search/presentation/providers/local_hive_providers.dart';

// Global provider to make SharedPreferences accessible synchronously anywhere
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize this in main()');
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  // 1. Initialize Hive Storage Service
  final storageService = HiveStorageService();
  await storageService.init();

  // 2. Open required Hive Boxes
  await Hive.openBox(LocationLocalDataSourceImpl.savedBoxName);
  await Hive.openBox(LocationLocalDataSourceImpl.recentBoxName);

  runApp(
    ProviderScope(
      overrides: [
        // Override the placeholder provider with the real instance
        sharedPreferencesProvider.overrideWithValue(Prefs.prefs),
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: const WeatherWise(),
    ),
  );
}

class WeatherWise extends ConsumerWidget {
  const WeatherWise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: currentTheme,
      initialRoute: '/',
      navigatorKey: NavigationService.navigatorKey,
      routes: {
        '/': (context) => const Base(),

        '/home': (context) => const HomePage(),
        '/Search': (context) => Search(),
      },
    );
  }
}
