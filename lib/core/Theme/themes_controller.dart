import 'package:flutter/material.dart';

class ThemesController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  static void init() {
    bool result = true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme() {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
    } else {
      themeNotifier.value = ThemeMode.dark;
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
