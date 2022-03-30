import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final SharedPreferences _prefs;

  SharedPrefs(this._prefs);

  String getString(String key) {
    return _prefs.getString(key) ?? "";
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }
}
