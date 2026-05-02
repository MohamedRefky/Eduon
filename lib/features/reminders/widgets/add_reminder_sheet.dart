import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';
import 'package:eduon/features/reminders/cubit/reminder_cubit.dart';
import 'package:eduon/features/reminders/data/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class AddReminderSheet extends StatefulWidget {
  const AddReminderSheet({super.key});

  static void show(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: parentContext.read<ReminderCubit>(),
        child: const AddReminderSheet(),
      ),
    );
  }

  @override
  State<AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<AddReminderSheet> {
  final _labelController = TextEditingController();
  TimeOfDay _time = TimeOfDay.now();
  final Set<int> _selectedDays = {1}; // default: Monday

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final dayNames = [
      l10n.mon,
      l10n.tue,
      l10n.wed,
      l10n.thu,
      l10n.fri,
      l10n.sat,
      l10n.sun
    ];

    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: EdgeInsets.fromLTRB(
        AppSizes.w20,
        AppSizes.h20,
        AppSizes.w20,
        AppSizes.h32,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle ──
          Center(
            child: Container(
              width: AppSizes.w40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(AppSizes.r4),
              ),
            ),
          ),
          Gap(AppSizes.h20),

          Text(
            l10n.new_study_reminder,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Gap(AppSizes.h20),

          // ── Label ──
          TextField(
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: AppSizes.sp14,
                  fontWeight: FontWeight.w600,
                ),
            controller: _labelController,
            decoration: InputDecoration(
              labelText: l10n.label_optional,
              hintText: l10n.label_hint,
              prefixIcon: const Icon(Icons.label_outline_rounded),
            ),
          ),
          Gap(AppSizes.h16),

          // ── Time Picker ──
          GestureDetector(
            onTap: _pickTime,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w16,
                vertical: AppSizes.h14,
              ),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time_rounded, color: scheme.primary),
                  Gap(AppSizes.w12),
                  Text(l10n.time, style: Theme.of(context).textTheme.displaySmall),
                  const Spacer(),
                  Text(
                    _timeLabel,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(AppSizes.h16),

          // ── Day Selector ──
          Text(l10n.days, style: Theme.of(context).textTheme.displaySmall),
          Gap(AppSizes.h10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (i) {
              final day = i + 1;
              final selected = _selectedDays.contains(day);
              return GestureDetector(
                onTap: () => setState(() {
                  if (selected) {
                    if (_selectedDays.length > 1) _selectedDays.remove(day);
                  } else {
                    _selectedDays.add(day);
                  }
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: AppSizes.h38,
                  height: AppSizes.h38,
                  decoration: BoxDecoration(
                    color: selected
                        ? scheme.primary
                        : (isDark ? const Color(0xFF1E293B) : Colors.white),
                    shape: BoxShape.circle,
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: scheme.primary.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      dayNames[i],
                      style: TextStyle(
                        fontSize: AppSizes.sp10,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Gap(AppSizes.h24),

          // ── Save Button ──
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check_rounded),
              label: Text(l10n.save_reminder),
            ),
          ),
        ],
      ),
    );
  }

  String get _timeLabel {
    return _time.format(context);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedDays.isEmpty) return;

    final granted = await NotificationService.instance.requestPermission();
    if (!granted) {
      if (mounted) {
        showCustomSnackBar(
          context,
          message: l10n.notification_denied,
          type: SnackBarType.error,
        );
      }
      return;
    }

    if (mounted) {
      context.read<ReminderCubit>().addReminder(
        label: _labelController.text.trim(),
        time: _time,
        weekdays: _selectedDays.toList()..sort(),
      );
      Navigator.pop(context);
      showCustomSnackBar(
        context,
        message: l10n.reminder_saved,
        type: SnackBarType.success,
      );
    }
  }
}
