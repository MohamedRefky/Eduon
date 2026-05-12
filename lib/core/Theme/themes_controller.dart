import 'package:eduon/core/service/preferences_manager.dart';
import 'package:flutter/material.dart';

class ThemesController {
  static const _themeKey = 'selected_theme_mode';

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  /// Call once in main() after PreferencesManager().init()
  static void init() {
    final saved = PreferencesManager().getString(_themeKey);
    themeNotifier.value =
        saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme() {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      PreferencesManager().setString(_themeKey, 'light');
    } else {
      themeNotifier.value = ThemeMode.dark;
      PreferencesManager().setString(_themeKey, 'dark');
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
