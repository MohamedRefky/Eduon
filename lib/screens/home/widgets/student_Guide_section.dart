import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/student_guide/student_guide_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudentGuideSection extends StatelessWidget {
  const StudentGuideSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.h16),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.h16,
        vertical: AppSizes.h8,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF475569),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Student Guide', style: TextTheme.of(context).labelLarge),
          Gap(AppSizes.h4),
          Text(
            'Start your journey and learn what to do in your academic year.',
            style: TextTheme.of(context).labelMedium,
          ),
          Gap(AppSizes.h10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StudentGuideScreen()),
              );
            },
            child: Container(
              width: AppSizes.w130,
              height: AppSizes.h28,
              decoration: BoxDecoration(
                color: Color(0xffE2E8F0),
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              child: Center(
                child: Text(
                  'View Guide',
                  style: TextTheme.of(context).labelSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
