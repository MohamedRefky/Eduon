import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/models/learning_path_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LearningPathHeader extends StatelessWidget {
  const LearningPathHeader({super.key, required this.learningPath});
  final LearningPathModel learningPath;

  @override
  Widget build(BuildContext context) {
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
                      learningPath.title,
                      style: TextTheme.of(context).displayLarge,
                    ),
                    Gap(AppSizes.h4),
                    Text(
                      learningPath.description,
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
                  learningPath.level,
                  style: TextTheme.of(
                    context,
                  ).labelMedium?.copyWith(fontSize: AppSizes.sp12),
                ),
              ),
              Gap(AppSizes.w12),
              Icon(Icons.menu_book, size: AppSizes.sp16, color: Colors.grey),
              Gap(AppSizes.w4),
              Text(
                '${learningPath.totalCourses} Courses',
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
