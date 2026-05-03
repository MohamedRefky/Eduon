import 'package:eduon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension CategoryLocalization on String {
  String translateCategory(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case 'Design':
        return l10n.design;
      case 'Tech':
        return l10n.tech;
      case 'Soft Skills':
        return l10n.soft_skills;
      case 'Video Editing':
        return l10n.video_editing;
      case 'Business':
        return l10n.business;
      case 'All':
        return l10n.all;
      default:
        return this;
    }
  }
}
