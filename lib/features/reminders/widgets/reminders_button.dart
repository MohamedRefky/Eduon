import 'package:flutter/material.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/l10n/app_localizations.dart';
import 'package:eduon/features/reminders/screens/reminder_screen.dart';
import 'package:gap/gap.dart';

class RemindersButton extends StatelessWidget {
  const RemindersButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ReminderScreen()),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h14,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.r15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.h42,
              height: AppSizes.h42,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSizes.r10),
              ),
              child: Icon(
                Icons.alarm_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: AppSizes.sp22,
              ),
            ),
            Gap(AppSizes.w14),
            Expanded(
              child: Text(
                l10n.study_reminders,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Icon(
              Localizations.localeOf(context).languageCode == 'ar'
                  ? Icons.chevron_left_rounded
                  : Icons.chevron_right_rounded,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }
}
