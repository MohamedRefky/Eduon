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
    this.isSelected = false,
    required this.colorFliter,
  });

  final String text;
  final String svgPath;
  final double? svgSize;
  final Function() onTap;
  final Color svgColor;
  final bool isSelected;
  final bool colorFliter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSizes.h8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
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
                height: AppSizes.h17,
                width: AppSizes.h17,
                child: SvgPicture.asset(
                  svgPath,
                  fit: BoxFit.cover,
                  colorFilter: colorFliter
                      ? ColorFilter.mode(
                          isSelected ? Theme.of(context).colorScheme.onPrimary : svgColor,
                          BlendMode.srcIn,
                        )
                      : null,
                ),
              ),
            ),
            Gap(AppSizes.h4),
            Text(
              text,
              maxLines: 1,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: AppSizes.sp14,
                color: isSelected ? Theme.of(context).colorScheme.onPrimary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
