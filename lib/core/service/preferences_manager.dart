import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();
  factory PreferencesManager() => _instance;
  PreferencesManager._internal();
  late final SharedPreferences _preferences;
  static const String onboardingKey = 'onboarding_seen';
  static const String selectedYearKey = 'selected_year';
  static const String fullNameKey = 'full_name';
  static const String userImageKey = 'user_image';

  final ValueNotifier<int> profileUpdateNotifier = ValueNotifier(0);

  void notifyProfileUpdated() {
    profileUpdateNotifier.value++;
  }

  Future<bool> setOnboardingSeen(bool value) {
    return _preferences.setBool(onboardingKey, value);
  }

  bool getOnboardingSeen() {
    return _preferences.getBool(onboardingKey) ?? false;
  }
Future<bool> setUserImage(String uid, String path) {
  return _preferences.setString('user_image_$uid', path);
}

String? getUserImage(String uid) {
  return _preferences.getString('user_image_$uid');
}
  Future<bool> setUserFullName(String uid, String name) {
    return _preferences.setString('full_name_$uid', name);
  }

  String? getUserFullName(String uid) {
    return _preferences.getString('full_name_$uid');
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setUserSelectedYear(String uid, String year) {
    return _preferences.setString('selected_year_$uid', year);
  }

  String? getUserSelectedYear(String uid) {
    return _preferences.getString('selected_year_$uid');
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
