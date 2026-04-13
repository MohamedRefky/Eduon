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
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (selectedCategory != 'All')
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedCategory,
                      style: const TextStyle(
                        color: Color(0xFF6C63FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.close,
                      size: 14,
                      color: Color(0xFF6C63FF),
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