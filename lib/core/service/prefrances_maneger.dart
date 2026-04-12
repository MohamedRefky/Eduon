import 'package:shared_preferences/shared_preferences.dart';

class PrefrancesManeger {
  static final PrefrancesManeger _instance = PrefrancesManeger._internal();

  factory PrefrancesManeger() => _instance;

  PrefrancesManeger._internal();
  late final SharedPreferences _preferences;
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  remove(String key) async {
    return await _preferences.remove(key);
  }

  setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }
}