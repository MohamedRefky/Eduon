import 'package:flutter/material.dart';

class SubjectModel {
  final String titleAr;
  final String titleEn;
  final String? videoUrl;
  final bool isAcademic;

  const SubjectModel({
    required this.titleAr,
    required this.titleEn,
    this.videoUrl,
    required this.isAcademic,
  });

  String getLocalizedTitle(BuildContext context) {
    // Basic check for Arabic locale
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return isArabic ? titleAr : titleEn;
  }
}
