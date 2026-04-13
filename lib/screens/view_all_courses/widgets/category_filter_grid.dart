import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/screens/view_all_courses/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryFilterGrid extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryTap;

  const CategoryFilterGrid({
    super.key,
    required this.selectedCategory,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryItem(
              'Business',
              'assets/svg/business.svg',
              const Color(0xFFa8d7e8),
            ),
            _buildCategoryItem(
              'Design',
              'assets/svg/design.svg',
              const Color(0xFFadbbcc),
            ),
          ],
        ),
        Gap(AppSizes.h12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryItem(
              'Tech',
              'assets/svg/tech.svg',
              const Color(0xFFacc4cb),
            ),
            _buildCategoryItem(
              'Soft Skills',
              'assets/svg/soft_skills.svg',
              const Color(0xFF7ab8de),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String name, String svgPath, Color color) {
    final isSelected = selectedCategory == name;
    return AnimatedScale(
      scale: isSelected ? 1.06 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: CustomContainer(
        text: name,
        svgPath: svgPath,
        containerColor: isSelected ? color : color.withValues(alpha: 0.5),
        onTap: () => onCategoryTap(name),
      ),
    );
  }
}