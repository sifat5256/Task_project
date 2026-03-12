import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  String? read(String key) {
    return _prefs.getString(key);
  }

  Future<bool> write(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<bool> delete(String key) {
    return _prefs.remove(key);
  }

  Future<bool> clear() {
    return _prefs.clear();
  }

  bool hasKey(String key) {
    return _prefs.containsKey(key);
  }
}
