import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CoursesCountHeader extends StatelessWidget {
  final int count;
  final String selectedCategory;
  final VoidCallback onClear;

  const CoursesCountHeader({
    super.key,
    required this.count,
    required this.selectedCategory,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.h16,
        vertical: AppSizes.h8,
      ),
      child: Row(
        children: [
          Text(
            '$count Courses',
            style: TextTheme.of(context).displaySmall?.copyWith(
              fontSize: AppSizes.sp14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (selectedCategory != 'All')
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.h8,
                  vertical: AppSizes.h4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF587DBD).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedCategory,
                      style: TextTheme.of(context).displaySmall?.copyWith(
                        color: Color(0xFF587DBD),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: AppSizes.w4),
                    Icon(Icons.close, size: AppSizes.sp16, color: Colors.black),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
