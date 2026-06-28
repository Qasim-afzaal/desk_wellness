import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class ReminderRepository {
  ReminderRepository(this._db);
  final AppDatabase _db;

  Stream<List<Reminder>> watchAll() => _db.select(_db.reminders).watch();

  Future<void> addDefaultBreakReminder(String time) async {
    await _db.into(_db.reminders).insert(RemindersCompanion.insert(
          type: 'stretch',
          title: 'Desk break',
          timeOfDay: time,
        ));
  }

  Future<void> toggle(int id, bool enabled) =>
      (_db.update(_db.reminders)..where((t) => t.id.equals(id)))
          .write(RemindersCompanion(enabled: Value(enabled)));
}
