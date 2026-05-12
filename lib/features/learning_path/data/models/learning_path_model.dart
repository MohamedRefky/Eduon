import 'package:eduon/l10n/app_localizations.dart';

class LearningPathModel {
  final String title;
  final String description;
  final String image;
  final String level;
  final List<String> playlistIds;

  LearningPathModel({
    required this.title,
    required this.description,
    required this.image,
    required this.level,
    required this.playlistIds,
  });

  int get totalCourses => playlistIds.length;

  String getLocalizedTitle(AppLocalizations l10n) {
    return switch (title) {
      'Web Development' => l10n.web_dev_title,
      'C++ Programming' => l10n.cpp_title,
      'UI/UX Design' => l10n.ui_ux_title,
      'Business Skills' => l10n.business_title,
      'Soft Skills' => l10n.soft_skills_path_title,
      _ => title,
    };
  }

  String getLocalizedDescription(AppLocalizations l10n) {
    return switch (description) {
      'HTML, CSS, JavaScript' => l10n.web_dev_desc,
      'Learn C++ and solve programming problems' => l10n.cpp_desc,
      'Learn UI/UX design from scratch' => l10n.ui_ux_desc,
      'Learn business and marketing skills' => l10n.business_desc,
      'Improve your personal and communication skills' =>
        l10n.soft_skills_path_desc,
      _ => description,
    };
  }

  String getLocalizedLevel(AppLocalizations l10n) {
    return switch (level) {
      'Beginner' => l10n.beginner,
      'Intermediate' => l10n.intermediate,
      _ => level,
    };
  }
}