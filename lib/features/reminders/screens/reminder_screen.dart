import 'package:eduon/features/reminders/cubit/reminder_cubit.dart';
import 'package:eduon/features/reminders/cubit/reminder_state.dart';
import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/reminders/widgets/empty_reminders.dart';
import 'package:eduon/features/reminders/widgets/add_reminder_sheet.dart';
import 'package:eduon/features/reminders/widgets/reminder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:eduon/l10n/app_localizations.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReminderCubit()..loadReminders(),
      child: const _ReminderBody(),
    );
  }
}

class _ReminderBody extends StatelessWidget {
  const _ReminderBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.study_reminders), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddReminderSheet.show(context),
        icon: const Icon(Icons.add_alarm_rounded),
        label: Text(l10n.add_reminder),
      ),
      body: BlocBuilder<ReminderCubit, ReminderState>(
        builder: (context, state) {
          if (state is ReminderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ReminderLoaded && state.reminders.isEmpty) {
            return const EmptyReminders();
          }

          if (state is ReminderLoaded) {
            return ListView.separated(
              padding: EdgeInsets.all(AppSizes.h16),
              separatorBuilder: (_, _) => Gap(AppSizes.h12),
              itemCount: state.reminders.length,
              itemBuilder: (context, i) =>
                  ReminderCard(reminder: state.reminders[i]),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
