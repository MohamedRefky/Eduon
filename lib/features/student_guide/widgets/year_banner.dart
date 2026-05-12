import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'year_picker_sheet.dart';

class YearBanner extends StatelessWidget {
  const YearBanner({super.key, required this.selectedYear, required this.yearKey});

  final String selectedYear;
  final String yearKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => YearPickerSheet.show(context, selectedYear),
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h12,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.primary.withValues(alpha: 0.75),
            ],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ),
          borderRadius: BorderRadius.circular(AppSizes.r12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.school_rounded, color: Colors.white, size: AppSizes.sp20),
            Gap(AppSizes.w8),
            Expanded(
              child: Text(
                l10n.academic_year(yearKey),
                style: textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.swap_vert_rounded,
              color: Colors.white.withValues(alpha: 0.85),
              size: AppSizes.sp18,
            ),
            Gap(AppSizes.w4),
            Text(
              l10n.select,
              style: textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
