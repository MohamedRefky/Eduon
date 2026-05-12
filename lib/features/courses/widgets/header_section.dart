import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppSizes.h8),
        Text(
          l10n.level_up_future,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
            letterSpacing: -1.5,
          ),
        ),
        Gap(AppSizes.h8),
        Text(
          l10n.explore_courses, 
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
