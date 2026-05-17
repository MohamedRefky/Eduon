import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import '../data/source/subject_data.dart';
import 'subject_card.dart';
import 'year_banner.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key, required this.selectedYear});

  final String selectedYear;

  String _yearKey(String y) {
    if (y.contains('First') || y.contains('1')) return 'year1';
    if (y.contains('Second') || y.contains('2')) return 'year2';
    if (y.contains('Third') || y.contains('3')) return 'year3';
    if (y.contains('Fourth') || y.contains('4')) return 'year4';
    return 'none';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final subjects = yearSubjectsData[selectedYear] ?? [];

    List<dynamic> sorted(bool academic) {
      final withVideo = subjects
          .where((s) => s.isAcademic == academic && s.videoUrl != null)
          .toList();
      final noVideo = subjects
          .where((s) => s.isAcademic == academic && s.videoUrl == null)
          .toList();
      return [...withVideo, ...noVideo];
    }

    final academic = sorted(true);
    final nonAcademic = sorted(false);

    return ListView(
      padding: EdgeInsetsDirectional.all(AppSizes.h16),
      children: [
        YearBanner(selectedYear: selectedYear, yearKey: _yearKey(selectedYear)),
        Gap(AppSizes.h20),
        if (academic.isNotEmpty) ...[
          Text(
            l10n.academic_subjects,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.sp16,
            ),
          ),
          Gap(AppSizes.h12),
          ...academic.map((s) => SubjectCard(subject: s)),
          Gap(AppSizes.h24),
        ],
        if (nonAcademic.isNotEmpty) ...[
          Text(
            l10n.non_academic_subjects,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.sp16,
            ),
          ),
          Gap(AppSizes.h12),
          ...nonAcademic.map((s) => SubjectCard(subject: s)),
          Gap(AppSizes.h16),
        ],
      ],
    );
  }
}
