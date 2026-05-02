import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/courses/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    
    final List<Map<String, dynamic>> categories = [
      {
        'key': 'All',
        'name': l10n.all,
        'svg': 'assets/svg/all_courses.svg',
        'color': Colors.black,
        'colorFilter': true,
      },
      {
        'key': 'Design',
        'name': l10n.design,
        'svg': 'assets/svg/design.svg',
        'color': const Color(0xFF702AE1),
        'colorFilter': true,
      },
      {
        'key': 'Tech',
        'name': l10n.tech,
        'svg': 'assets/svg/tech.svg',
        'color': const Color(0xFF00675C),
        'colorFilter': true,
      },
      {
        'key': 'Soft Skills',
        'name': l10n.soft_skills,
        'svg': 'assets/svg/soft_skills.svg',
        'color': const Color(0xFF346178),
        'colorFilter': true,
      },
      {
        'key': 'Video Editing',
        'name': l10n.video_editing,
        'svg': 'assets/svg/video_editing.svg',
        'color': const Color(0xFFA0A0A0),
        'colorFilter': false,
      },
      {
        'key': 'Business',
        'name': l10n.business,
        'svg': 'assets/svg/business.svg',
        'color': const Color(0xFF00647B),
        'colorFilter': true,
      },
    ];

    return SizedBox(
      height: AppSizes.h35,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.h4),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => Gap(AppSizes.h8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryItem(
            category['key']!,
            category['name']!,
            category['svg']!,
            category['color']!,
            category['colorFilter']!,
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(
    String key,
    String displayName,
    String svgPath,
    Color svgColor,
    bool colorFilter,
  ) {
    final isSelected = selectedCategory == key;
    return AnimatedScale(
      scale: isSelected ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: CustomContainer(
        svgColor: svgColor,
        text: displayName,
        svgPath: svgPath,
        onTap: () => onCategoryTap(key),
        isSelected: isSelected,
        colorFliter: colorFilter,
      ),
    );
  }
}
