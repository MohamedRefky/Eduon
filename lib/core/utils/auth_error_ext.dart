import 'package:flutter/material.dart';
import 'package:eduon/l10n/app_localizations.dart';

extension AuthErrorTranslator on String {
  String translateAuthError(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    switch (this) {
      case "user_not_found_signup":
        return l10n.user_not_found_signup;
      case "wrong_password":
        return l10n.wrong_password;
      case "invalid_credential":
        return l10n.invalid_credential;
      case "email_already_registered":
        return l10n.email_already_registered;
      case "password_at_least_6":
        return l10n.password_at_least_6;
      case "too_many_requests":
        return l10n.too_many_requests;
      case "network_error":
        return l10n.network_error;
      case "auth_failed":
        return l10n.auth_failed;
      case "registration_failed":
        return l10n.registration_failed;
      case "something_went_wrong":
        return l10n.something_went_wrong;
      default:
        return this; // ارجع النص الأصلي لو مش موجود في القائمة
    }
  }
}
