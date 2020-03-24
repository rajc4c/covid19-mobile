import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _politicalFilterList= "political_filter_list";
  static final String reportFormList = "report_form_list";



  static Future<String> prepareFilterMessage(List values) async {
    String message = "";

    int index = 0;
    values = values.where((value) {
      return value.name != null;
    }).toList();

    values.forEach((value) {
      index = index + 1;
      message += "${value.name}";
      if (values.length != index) {
        message += ", ";
      }
    });

    return Future.value(message);
  }

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
