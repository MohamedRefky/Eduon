import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

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

    return Container(
      padding: EdgeInsets.all(AppSizes.w16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: AppSizes.h8),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF64748B),
                    fontSize: AppSizes.sp15,
                  ),
                ),
                SizedBox(height: AppSizes.h16),
                GestureDetector(
                  onTap: onSelect,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w24,
                      vertical: AppSizes.h8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(AppSizes.r20),
                    ),
                    child: Text(
                      "Select",
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: AppSizes.sp16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.w12),
     
          Container(
            width: AppSizes.w90,
            height: AppSizes.w90,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(AppSizes.r20),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: AppSizes.w40,
                height: AppSizes.w40,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}