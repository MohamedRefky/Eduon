import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/learning_path/data/models/learning_path_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class LearningPathHeader extends StatelessWidget {
  const LearningPathHeader({super.key, required this.learningPath});
  final LearningPathModel learningPath;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.h16,
        vertical: AppSizes.h10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      learningPath.getLocalizedTitle(l10n),
                      style: TextTheme.of(context).displayLarge,
                    ),
                    Gap(AppSizes.h4),
                    Text(
                      learningPath.getLocalizedDescription(l10n),
                      style: TextTheme.of(
                        context,
                      ).labelSmall?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(AppSizes.h8),
          Row(
            children: [
              // Level
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w12,
                  vertical: AppSizes.h4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
                child: Text(
                  learningPath.getLocalizedLevel(l10n),
                  style: TextTheme.of(
                    context,
                  ).labelMedium?.copyWith(fontSize: AppSizes.sp12),
                ),
              ),
              Gap(AppSizes.w12),
              Icon(Icons.menu_book, size: AppSizes.sp16, color: Colors.grey),
              Gap(AppSizes.w4),
              Text(
                l10n.courses_count(learningPath.totalCourses),
                style: TextTheme.of(context).labelSmall,
              ),
            ],
          ),
          Gap(AppSizes.h10),
          const Divider(),
        ],
      ),
    );
  }
}
