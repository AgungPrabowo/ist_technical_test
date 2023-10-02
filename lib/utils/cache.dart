import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static Future<bool> setString(String key, String value) async {
    var pref = await SharedPreferences.getInstance();
    var success = await pref.setString(key, value);
    return success;
  }

  static Future<String> getString(String key) async {
    final pref = await SharedPreferences.getInstance();
    final val = pref.getString(key);
    return val ?? "";
  }

  static Future<bool> removeCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
