import 'package:flutter/material.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:gap/gap.dart';

class EmptyReminders extends StatelessWidget {
  const EmptyReminders({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: AppSizes.sp64,
            color: Colors.grey[400],
          ),
          Gap(AppSizes.h16),
          Text(
            l10n.no_reminders_yet,
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(color: Colors.grey[500]),
          ),
          Gap(AppSizes.h8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w32),
            child: Text(
              l10n.tap_to_schedule,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
