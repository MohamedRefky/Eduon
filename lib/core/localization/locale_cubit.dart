import 'package:eduon/core/service/preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const SelectedLocale(Locale('en')));

  static const String _localeKey = 'selected_locale';

  Future<void> getSavedLocale() async {
    final String? cachedLocaleCode = PreferencesManager().getString(_localeKey);
    if (cachedLocaleCode != null) {
      emit(SelectedLocale(Locale(cachedLocaleCode)));
    } else {
      emit(const SelectedLocale(Locale('en')));
    }
  }

  Future<void> changeLanguage(String localeCode) async {
    await PreferencesManager().setString(_localeKey, localeCode);
    emit(SelectedLocale(Locale(localeCode)));
  }

  void toggleLanguage() {
    if (state.locale.languageCode == 'en') {
      changeLanguage('ar');
    } else {
      changeLanguage('en');
    }
  }
}
