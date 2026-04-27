import 'package:eduon/features/reminders/data/models/study_reminder.dart';
import 'package:equatable/equatable.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object?> get props => [];
}

class ReminderInitial extends ReminderState {
  const ReminderInitial();
}

class ReminderLoading extends ReminderState {
  const ReminderLoading();
}

class ReminderLoaded extends ReminderState {
  final List<StudyReminder> reminders;

  const ReminderLoaded(this.reminders);

  @override
  List<Object?> get props => [reminders];
}

class ReminderError extends ReminderState {
  final String message;

  const ReminderError(this.message);

  @override
  List<Object?> get props => [message];
}
