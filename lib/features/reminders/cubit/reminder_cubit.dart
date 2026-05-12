import 'package:bloc/bloc.dart';
import 'package:eduon/features/reminders/cubit/reminder_state.dart';
import 'package:eduon/features/reminders/data/models/study_reminder.dart';
import 'package:eduon/features/reminders/data/services/notification_service.dart';
import 'package:flutter/material.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(const ReminderInitial());

  final _service = NotificationService.instance;

  List<StudyReminder> _reminders = [];

  // ─── Load ─────────────────────────────────────────────────────────────────────
  Future<void> loadReminders() async {
    emit(const ReminderLoading());
    try {
      _reminders = await _service.loadReminders();
      emit(ReminderLoaded(List.from(_reminders)));
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  // ─── Add ──────────────────────────────────────────────────────────────────────
  Future<void> addReminder({
    required String label,
    required TimeOfDay time,
    required List<int> weekdays,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch % 100000;
    final reminder = StudyReminder(
      id: id,
      label: label,
      time: time,
      weekdays: weekdays,
    );
    _reminders.add(reminder);
    await _service.scheduleReminder(reminder);
    await _service.saveReminders(_reminders);
    emit(ReminderLoaded(List.from(_reminders)));
  }

  // ─── Toggle ───────────────────────────────────────────────────────────────────
  Future<void> toggleReminder(StudyReminder reminder) async {
    final updated = reminder.copyWith(isActive: !reminder.isActive);
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index == -1) return;

    _reminders[index] = updated;

    if (updated.isActive) {
      await _service.scheduleReminder(updated);
    } else {
      await _service.cancelReminder(updated);
    }

    await _service.saveReminders(_reminders);
    emit(ReminderLoaded(List.from(_reminders)));
  }

  // ─── Delete ───────────────────────────────────────────────────────────────────
  Future<void> deleteReminder(StudyReminder reminder) async {
    await _service.cancelReminder(reminder);
    _reminders.removeWhere((r) => r.id == reminder.id);
    await _service.saveReminders(_reminders);
    emit(ReminderLoaded(List.from(_reminders)));
  }
}
