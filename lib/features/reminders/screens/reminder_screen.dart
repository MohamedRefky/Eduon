import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/features/reminders/cubit/reminder_cubit.dart';
import 'package:eduon/features/reminders/cubit/reminder_state.dart';
import 'package:eduon/features/reminders/widgets/add_reminder_sheet.dart';
import 'package:eduon/features/reminders/widgets/reminder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Study Reminders'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReminderSheet(context),
        icon: const Icon(Icons.add_alarm_rounded),
        label: const Text('Add Reminder'),
      ),
      body: BlocBuilder<ReminderCubit, ReminderState>(
        builder: (context, state) {
          if (state is ReminderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ReminderLoaded && state.reminders.isEmpty) {
            return _buildEmpty(context);
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

  Widget _buildEmpty(BuildContext context) {
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
            'No reminders yet',
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(color: Colors.grey[500]),
          ),
          Gap(AppSizes.h8),
          Text(
            'Tap + Add Reminder to schedule your study sessions',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(color: Colors.grey[400]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddReminderSheet(BuildContext parentContext) {
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
}
