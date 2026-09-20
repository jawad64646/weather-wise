import 'package:flutter_riverpod/legacy.dart';

// Keeps track of the active tab index (starts at 0)
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
