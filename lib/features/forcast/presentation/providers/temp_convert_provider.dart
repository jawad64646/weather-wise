import 'package:flutter_riverpod/legacy.dart';

enum TemperatureUnit { C, F }

final tempCtoFprovider = StateProvider<TemperatureUnit>((ref) {
  return TemperatureUnit.C;
});
