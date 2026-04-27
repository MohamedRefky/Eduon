import 'package:flutter/material.dart';

class StudyReminder {
  final int id;
  final String label;
  final TimeOfDay time;
  final List<int> weekdays; // 1=Monday ... 7=Sunday
  final bool isActive;

  const StudyReminder({
    required this.id,
    required this.label,
    required this.time,
    required this.weekdays,
    this.isActive = true,
  });

  StudyReminder copyWith({
    int? id,
    String? label,
    TimeOfDay? time,
    List<int>? weekdays,
    bool? isActive,
  }) {
    return StudyReminder(
      id: id ?? this.id,
      label: label ?? this.label,
      time: time ?? this.time,
      weekdays: weekdays ?? this.weekdays,
      isActive: isActive ?? this.isActive,
    );
  }

  // ─── Serialization ───────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'hour': time.hour,
    'minute': time.minute,
    'weekdays': weekdays,
    'isActive': isActive,
  };

  factory StudyReminder.fromJson(Map<String, dynamic> json) => StudyReminder(
    id: json['id'] as int,
    label: json['label'] as String,
    time: TimeOfDay(hour: json['hour'] as int, minute: json['minute'] as int),
    weekdays: List<int>.from(json['weekdays'] as List),
    isActive: json['isActive'] as bool,
  );

  String get timeLabel {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String get daysLabel {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (weekdays.length == 7) return 'Every day';
    if (weekdays.toSet().containsAll({6, 7}) && weekdays.length == 2) {
      return 'Weekends';
    }
    if (weekdays.toSet().containsAll({1, 2, 3, 4, 5}) && weekdays.length == 5) {
      return 'Weekdays';
    }
    return weekdays.map((d) => names[d - 1]).join(', ');
  }
}
