import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class StudentGuideScreen extends StatelessWidget {
  const StudentGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: AppSizes.sp24),
        ),
        title: Text(l10n.student_guide),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSizes.h16),
        children: [
          _GuideCard(
            year: l10n.year_1_2,
            title: l10n.freshman_guide,
            tips: [
              _GuideTip(
                title: l10n.tip_network_title,
                description: l10n.tip_network_desc,
              ),
              _GuideTip(
                title: l10n.tip_time_title,
                description: l10n.tip_time_desc,
              ),
              _GuideTip(
                title: l10n.tip_soft_skills_title,
                description: l10n.tip_soft_skills_desc,
              ),
              _GuideTip(
                title: l10n.tip_explore_title,
                description: l10n.tip_explore_desc,
              ),
            ],
          ),
          _GuideCard(
            year: l10n.year_3_4,
            title: l10n.senior_guide,
            tips: [
              _GuideTip(
                title: l10n.tip_professional_title,
                description: l10n.tip_professional_desc,
              ),
              _GuideTip(
                title: l10n.tip_consistent_title,
                description: l10n.tip_consistent_desc,
              ),
              _GuideTip(
                title: l10n.tip_experience_title,
                description: l10n.tip_experience_desc,
              ),
              _GuideTip(
                title: l10n.tip_problems_title,
                description: l10n.tip_problems_desc,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final String year;
  final String title;
  final List<_GuideTip> tips;

  const _GuideCard({
    required this.year,
    required this.title,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.h20),
      padding: EdgeInsets.all(AppSizes.h20),
      decoration: BoxDecoration(
        color: const Color(0xFF6B7FA3),
        borderRadius: BorderRadius.circular(AppSizes.r20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            year,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppSizes.h4),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppSizes.h12),
          ...tips.map((tip) => _TipItem(tip: tip)),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final _GuideTip tip;

  const _TipItem({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontSize: AppSizes.sp16,
            ),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: tip.title,
                    style: TextStyle(
                      color: const Color(0xFF90CAF9),
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  TextSpan(
                    text: ': ${tip.description}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.sp14,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideTip {
  final String title;
  final String description;

  const _GuideTip({required this.title, required this.description});
}
