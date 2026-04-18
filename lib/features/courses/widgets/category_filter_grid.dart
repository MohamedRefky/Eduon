import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/courses/widgets/custom_container.dart';
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
    return SizedBox(
      height: AppSizes.h35,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.h4),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => Gap(AppSizes.h8),
        itemBuilder: (context, index) {
          return _buildCategoryItem(
            _categories[index]['name']!,
            _categories[index]['svg']!,
            _categories[index]['color']!,
            _categories[index]['colorFilter']!,
          );
        },
      ),
    );
  }

  static const List<Map<String, dynamic>> _categories = [
    {
      'name': 'All',
      'svg': 'assets/svg/all_courses.svg',
      'color': Colors.black,
      'colorFilter': true,
    },
    {
      'name': 'Design',
      'svg': 'assets/svg/design.svg',
      'color': Color(0xFF702AE1),
      'colorFilter': true,
    },
    {
      'name': 'Tech',
      'svg': 'assets/svg/tech.svg',
      'color': Color(0xFF00675C),
      'colorFilter': true,
    },

    {
      'name': 'Soft Skills',
      'svg': 'assets/svg/soft_skills.svg',
      'color': Color(0xFF346178),
      'colorFilter': true,
    },
    {
      'name': 'Video Editing',
      'svg': 'assets/svg/video_editing.svg',
      'color': Color(0xFFA0A0A0),
      'colorFilter': false,
    },

    {
      'name': 'Business',
      'svg': 'assets/svg/business.svg',
      'color': Color(0xFF00647B),
      'colorFilter': true,
    },
  ];
  Widget _buildCategoryItem(
    String name,
    String svgPath,
    Color svgColor,
    bool colorFilter,
  ) {
    final isSelected = selectedCategory == name;
    return AnimatedScale(
      scale: isSelected ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: CustomContainer(
        svgColor: svgColor,
        text: name,
        svgPath: svgPath,
        onTap: () => onCategoryTap(name),
        isSelected: isSelected,
        colorFliter: colorFilter,
      ),
    );
  }
}
