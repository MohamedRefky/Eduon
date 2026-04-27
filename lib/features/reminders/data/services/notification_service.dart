import 'dart:convert';

import 'package:eduon/features/reminders/data/models/study_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const _prefsKey = 'study_reminders';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ─── Initialize ──────────────────────────────────────────────────────────────
  Future<void> initialize() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings);
  }

  // ─── Request Permission ───────────────────────────────────────────────────────
  Future<bool> requestPermission() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    bool granted = true;
    if (android != null) {
      granted = await android.requestNotificationsPermission() ?? false;
      await android.requestExactAlarmsPermission();
    }
    if (ios != null) {
      granted = await ios.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }
    return granted;
  }

  // ─── Test (fires immediately) ─────────────────────────────────────────────
  Future<void> testNotification() async {
    await _plugin.show(
      99999,
      '📚 Study Reminder - Test',
      "This is a test notification. It's working! 🚀",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'study_reminders',
          'Study Reminders',
          channelDescription: 'Reminds you to study at scheduled times',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  // ─── Schedule Reminder ────────────────────────────────────────────────────────
  Future<void> scheduleReminder(StudyReminder reminder) async {
    if (!reminder.isActive) return;

    for (final weekday in reminder.weekdays) {
      final id = _notifId(reminder.id, weekday);
      final scheduledDate = _nextInstanceOfWeekdayTime(
        weekday,
        reminder.time,
      );

      await _plugin.zonedSchedule(
        id,
        '📚 Study Reminder',
        reminder.label.isEmpty ? "Time to study! Let's go 🚀" : reminder.label,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'study_reminders',
            'Study Reminders',
            channelDescription: 'Reminds you to study at scheduled times',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  // ─── Cancel Reminder ──────────────────────────────────────────────────────────
  Future<void> cancelReminder(StudyReminder reminder) async {
    for (final weekday in reminder.weekdays) {
      await _plugin.cancel(_notifId(reminder.id, weekday));
    }
  }

  Future<void> cancelAllReminders() async {
    await _plugin.cancelAll();
  }

  // ─── Persistence ─────────────────────────────────────────────────────────────
  Future<List<StudyReminder>> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKey) ?? [];
    return raw
        .map((e) => StudyReminder.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveReminders(List<StudyReminder> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _prefsKey,
      reminders.map((r) => jsonEncode(r.toJson())).toList(),
    );
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────────
  /// Unique notification id per reminder+weekday combo
  int _notifId(int reminderId, int weekday) => reminderId * 10 + weekday;

  tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // weekday: 1=Mon, 7=Sun (Flutter's DateTime.weekday uses same convention)
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
