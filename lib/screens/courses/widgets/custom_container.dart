import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.text,
    required this.svgPath,
    required this.onTap,
    this.svgSize,
    required this.svgColor,
    this.isSelected = false, // ✅ أضيف ده
  });

  final String text;
  final String svgPath;
  final double? svgSize;
  final Function() onTap;
  final Color svgColor;
  final bool isSelected; // ✅ أضيف ده

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSizes.h8),
        decoration: BoxDecoration(
          // ✅ لو selected يبقى بلون الـ svg، لو لأ يبقى أبيض
          color: isSelected ? svgColor : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              child: SizedBox(
                height: AppSizes.h16,
                width: AppSizes.h16,
                child: SvgPicture.asset(
                  svgPath,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    // ✅ لو selected الأيقونة تبقى بيضاء
                    isSelected ? Colors.white : svgColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Gap(AppSizes.h4),
            Text(
              text,
              maxLines: 1,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: AppSizes.sp14,
                // ✅ لو selected النص يبقى أبيض
                color: isSelected ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
