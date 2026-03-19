import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  // Call once in main() before runApp
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── String ────────────────────────────────
  static String? getString(String key) => _prefs.getString(key);
  static Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  // ─── Bool ──────────────────────────────────
  static bool? getBool(String key) => _prefs.getBool(key);
  static Future<void> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  // ─── Int ───────────────────────────────────
  static int? getInt(String key) => _prefs.getInt(key);
  static Future<void> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  // ─── Remove & Clear ────────────────────────
  static Future<void> remove(String key) => _prefs.remove(key);
  static Future<void> clear() => _prefs.clear();

  // ─── Auth helpers ──────────────────────────
  static String? getToken() => _prefs.getString(StorageKeys.token);
  static Future<void> saveToken(String token) =>
      _prefs.setString(StorageKeys.token, token);
  static Future<void> removeToken() => _prefs.remove(StorageKeys.token);
}

class StorageKeys {
  static const String token = 'token';
}
