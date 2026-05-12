import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();
  factory PreferencesManager() => _instance;
  PreferencesManager._internal();
  late final SharedPreferences _preferences;
  static const String onboardingKey = 'onboarding_seen';
  static const String activeLearningKey = 'active_learning_courses';

  final ValueNotifier<int> profileUpdateNotifier = ValueNotifier(0);

  void notifyProfileUpdated() {
    profileUpdateNotifier.value++;
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Active Learning Methods
  List<Map<String, dynamic>> getActiveLearning() {
    final String? data = _preferences.getString(activeLearningKey);
    if (data == null) return [];
    try {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addToActiveLearning(Map<String, dynamic> course) async {
    final List<Map<String, dynamic>> courses = getActiveLearning();
    final String? playlistId = course['playlistId'];
    
    // منع التكرار
    courses.removeWhere((c) => c['playlistId'] == playlistId);
    courses.insert(0, course);
    
    await _preferences.setString(activeLearningKey, jsonEncode(courses));
  }

  Future<void> removeFromActiveLearning(String playlistId) async {
    final List<Map<String, dynamic>> courses = getActiveLearning();
    courses.removeWhere((c) => c['playlistId'] == playlistId);
    await _preferences.setString(activeLearningKey, jsonEncode(courses));
  }

  Future<void> updateCourseProgress(String playlistId, double progress, int watched, int total) async {
    final List<Map<String, dynamic>> courses = getActiveLearning();
    final index = courses.indexWhere((c) => c['playlistId'] == playlistId);
    
    if (index != -1) {
      courses[index]['progress'] = progress;
      courses[index]['watchedVideos'] = watched;
      courses[index]['totalVideos'] = total;
      await _preferences.setString(activeLearningKey, jsonEncode(courses));
    }
  }

  /// Existing Methods
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
