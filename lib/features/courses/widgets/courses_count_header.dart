import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/utils/category_helper.dart';
import 'package:flutter/material.dart';
import 'package:eduon/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final categoryDisplay = selectedCategory.translateCategory(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.h16,
        vertical: AppSizes.h8,
      ),
      child: Row(
        children: [
          Text(
            l10n.courses_count(count),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      categoryDisplay,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: const Color(0xFF587DBD),
                        fontWeight: FontWeight.w800,
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
