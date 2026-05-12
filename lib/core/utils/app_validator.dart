import 'package:eduon/l10n/app_localizations.dart';

class AppValidator {
  // ================= EMAIL =================
  static String? email(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.please_enter_email;
    }

    final email = value.trim();

    if (!email.contains('@')) {
      return l10n.email_must_contain_at;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return l10n.enter_valid_email;
    }

    return null;
  }

  // ================= PASSWORD =================
  static String? password(String? value, AppLocalizations l10n) {
    final v = value;

    if (v == null || v.trim().isEmpty) {
      return l10n.please_enter_password;
    }

    if (v.contains(' ')) {
      return l10n.password_no_spaces;
    }

    if (v.trim().length < 6) {
      return l10n.password_at_least_6;
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(v)) {
      return l10n.weak_password;
    }

    return null;
  }

  // ================= FULL NAME =================
  static String? fullName(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.please_enter_full_name;
    }

    final name = value.trim();

    if (name.length < 3) {
      return l10n.name_too_short;
    }

    if (!RegExp(r"^[a-zA-Z\u0600-\u06FF\s]+$").hasMatch(name)) {
      return l10n.name_letters_only;
    }

    if (name.split(' ').where((e) => e.isNotEmpty).length < 2) {
      return l10n.enter_first_last_name;
    }

    return null;
  }
}
