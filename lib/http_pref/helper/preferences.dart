import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {


  static Future<bool> save(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  static Future<String> getByUrl(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(url) ?? '';
  }

  static Future<bool> saveLastSavedTime(String key, int value) async {
    key = "${key}_last_saved_time";
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(key, value);
  }

  static Future<int> getLastSavedTime(String key) async {
    key = "${key}_last_saved_time";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> clear(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, "");
  }
}
