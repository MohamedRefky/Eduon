import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ActiveLearning extends StatelessWidget {
  const ActiveLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Active Learning', style: TextTheme.of(context).displayLarge),
            const Spacer(),
            Icon(Icons.more_horiz, size: AppSizes.sp24, color: Colors.grey),
          ],
        ),
        Gap(AppSizes.h12),

        // Course 1
        _buildCourseItem(
          context,
          title: 'Advanced Prototyping Workshop',
          subtitle: '2 hours left • Design Lab',
          progress: 0.75,
          color: const Color(0xFFF5C5A3),
          icon: Icons.design_services,
        ),
        Gap(AppSizes.h12),

        // Course 2
        _buildCourseItem(
          context,
          title: 'Human-Computer Interaction',
          subtitle: 'Due Tomorrow • Assignment 4',
          progress: 0.25,
          color: Colors.white,
          icon: Icons.people_outline,
        ),
      ],
    );
  }
}

Widget _buildCourseItem(
  BuildContext context, {
  required String title,
  required String subtitle,
  required double progress,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(AppSizes.h12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppSizes.r12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: AppSizes.h56,
          height: AppSizes.h56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: Icon(icon, color: Colors.white, size: AppSizes.sp24),
        ),
        Gap(AppSizes.w10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextTheme.of(
                  context,
                ).displayMedium?.copyWith(fontSize: AppSizes.sp13),
              ),
              Gap(AppSizes.h4),
              Text(
                subtitle,
                style: TextTheme.of(
                  context,
                ).displaySmall?.copyWith(fontSize: AppSizes.sp12),
              ),
              Gap(AppSizes.h8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  color: const Color(0xFF3B82F6),
                  minHeight: AppSizes.h6,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
