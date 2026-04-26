import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomYearContainer extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomYearContainer({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.all(AppSizes.w16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppSizes.r20),
          border: isSelected
              ? Border.all(color: const Color(0xFF3B82F6), width: 2)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(
                      fontSize: AppSizes.sp22,
                      color: textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(
                      color: textTheme.bodySmall?.color,
                      fontSize: AppSizes.sp15,
                    ),
                  ),
                  SizedBox(height: AppSizes.h16),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w24,
                      vertical: AppSizes.h8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.r20),
                    ),
                    child: Text(
                      "Select",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: AppSizes.sp16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(AppSizes.w12),
            Image.asset(iconPath, width: AppSizes.w90, height: AppSizes.w90),
          ],
        ),
      ),
    );
  }
}
