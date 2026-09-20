import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Write
  static Future<void> write(String key, String value) async {
    await prefs.setString(key, value);
  }

  // Read
  static String? read(String key) {
    return prefs.getString(key);
  }

  // Remove
  static Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}
