import 'package:eduon/l10n/app_localizations.dart';
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

  String getTimeLabel(BuildContext context) {
    return time.format(context);
  }

  String getDaysLabel(AppLocalizations l10n) {
    final names = [
      l10n.mon,
      l10n.tue,
      l10n.wed,
      l10n.thu,
      l10n.fri,
      l10n.sat,
      l10n.sun,
    ];

    if (weekdays.length == 7) return l10n.every_day;
    if (weekdays.toSet().containsAll({6, 7}) && weekdays.length == 2) {
      return l10n.weekends;
    }
    if (weekdays.toSet().containsAll({1, 2, 3, 4, 5}) && weekdays.length == 5) {
      return l10n.weekdays;
    }
    return weekdays.map((d) => names[d - 1]).join(', ');
  }
}
