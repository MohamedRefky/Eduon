import 'package:shared_preferences/shared_preferences.dart';

class PrefrancesManeger {
  static final PrefrancesManeger _instance = PrefrancesManeger._internal();
  static const String onboardingKey = 'onboarding_seen';
  factory PrefrancesManeger() => _instance;
  static const String selectedYearKey = 'selected_year';
  static const String fullNameKey = 'full_name';
  PrefrancesManeger._internal();
  late final SharedPreferences _preferences;

  Future<bool> setOnboardingSeen(bool value) {
    return _preferences.setBool(onboardingKey, value);
  }

  bool getOnboardingSeen() {
    return _preferences.getBool(onboardingKey) ?? false;
  }

  Future<bool> setFullName(String name) {
    return _preferences.setString(fullNameKey, name);
  }

  String? getFullName() {
    return _preferences.getString(fullNameKey);
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setSelectedYear(String year) {
    return _preferences.setString(selectedYearKey, year);
  }

  String? getSelectedYear() {
    return _preferences.getString(selectedYearKey);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }
}
