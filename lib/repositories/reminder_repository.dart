import 'package:desk_wellness/core/services/notification_service.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/repositories/affirmation_repository.dart';
import 'package:drift/drift.dart';

class ReminderRepository {
  ReminderRepository(this._db, this._notifications, this._affirmations);

  final AppDatabase _db;
  final NotificationService _notifications;
  final AffirmationRepository _affirmations;

  Stream<List<Reminder>> watchAll() => _db.select(_db.reminders).watch();

  Future<Reminder?> getById(int id) async =>
      (_db.select(_db.reminders)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> toggle(int id, bool enabled) async {
    await (_db.update(_db.reminders)..where((t) => t.id.equals(id)))
        .write(RemindersCompanion(enabled: Value(enabled)));
    await syncScheduledNotifications();
  }

  Future<void> updateReminder({
    required int id,
    required String timeOfDay,
    required String daysOfWeek,
    required bool enabled,
  }) async {
    await (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
      RemindersCompanion(
        timeOfDay: Value(timeOfDay),
        daysOfWeek: Value(daysOfWeek),
        enabled: Value(enabled),
      ),
    );
    await syncScheduledNotifications();
  }

  Future<bool> dailyNotificationsEnabled() async {
    final rows = await _db.select(_db.reminders).get();
    return rows.any((r) => r.enabled);
  }

  Future<void> setAllEnabled(bool enabled) async {
    await _db.update(_db.reminders).write(RemindersCompanion(enabled: Value(enabled)));
    await syncScheduledNotifications();
  }

  Future<void> syncScheduledNotifications() async {
    try {
      await _notifications.cancelAll();
      final reminders = await _db.select(_db.reminders).get();
      final body = await _affirmations.randomAffirmationText();

      for (final reminder in reminders) {
        if (!reminder.enabled) continue;
        final parts = reminder.timeOfDay.split(':');
        if (parts.length < 2) continue;
        await _notifications.scheduleDaily(
          id: reminder.id,
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
          title: reminder.title,
          body: body,
        );
      }
    } catch (_) {
      // Never fail app startup because of scheduler issues.
    }
  }
}
