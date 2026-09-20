import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise/features/forcast/presentation/pages/forcast.dart';
import 'package:weatherwise/features/home/presentation/pages/home.dart';

import 'package:weatherwise/features/home/presentation/providers/buttom_navigation_provider.dart';
import 'package:weatherwise/features/search/presentation/pages/search.dart';

class Base extends ConsumerWidget {
  const Base({super.key});

  static const List<Widget> _screens = [
    HomePage(),

    Search(),

    Forcast(),

    Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _screens),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(icon: Icon(LucideIcons.sun), label: 'Home'),
          NavigationDestination(
            icon: Icon(LucideIcons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.calendar),
            label: 'Forecast',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
