import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/reminders/cubit/reminder_cubit.dart';
import 'package:eduon/features/reminders/data/models/study_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'edit_reminder_sheet.dart';

class ReminderCard extends StatelessWidget {
  final StudyReminder reminder;
  const ReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey(reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: AppSizes.w20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(AppSizes.r16),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 28),
      ),
      onDismissed: (_) => context.read<ReminderCubit>().deleteReminder(reminder),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h14,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.r16),
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
              width: AppSizes.h48,
              height: AppSizes.h48,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              child: Icon(
                Icons.alarm_rounded,
                color: scheme.primary,
                size: AppSizes.sp24,
              ),
            ),
            Gap(AppSizes.w14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.label.isEmpty ? 'Study Session' : reminder.label,
                    style: Theme.of(context).textTheme.displayMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(AppSizes.h4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: AppSizes.sp14,
                        color: Colors.grey[500],
                      ),
                      Gap(AppSizes.w4),
                      Text(
                        reminder.timeLabel,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Gap(AppSizes.w8),
                      Icon(
                        Icons.calendar_today_rounded,
                        size: AppSizes.sp14,
                        color: Colors.grey[500],
                      ),
                      Gap(AppSizes.w4),
                      Expanded(
                        child: Text(
                          reminder.daysLabel,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Switch(
              value: reminder.isActive,
              activeThumbColor: scheme.primary,
              onChanged: (_) =>
                  context.read<ReminderCubit>().toggleReminder(reminder),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded, color: Colors.grey[500]),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  _showEditSheet(context, reminder);
                } else if (value == 'delete') {
                  _showDeleteDialog(context, reminder);
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded,
                          color: scheme.primary, size: AppSizes.sp18),
                      Gap(AppSizes.w8),
                      const Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded,
                          color: Colors.red, size: AppSizes.sp18),
                      Gap(AppSizes.w8),
                      const Text('Delete',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditSheet(BuildContext ctx, StudyReminder reminder) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: ctx.read<ReminderCubit>(),
        child: EditReminderSheet(reminder: reminder),
      ),
    );
  }

  void _showDeleteDialog(BuildContext ctx, StudyReminder reminder) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r16),
        ),
        title: const Text('Delete Reminder'),
        content: Text(
          'Are you sure you want to delete "${reminder.label.isEmpty ? 'Study Session' : reminder.label}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              ctx.read<ReminderCubit>().deleteReminder(reminder);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
