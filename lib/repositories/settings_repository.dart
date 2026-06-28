import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class SettingsRepository {
  SettingsRepository(this._db);
  final AppDatabase _db;

  Stream<UserSetting> watchSettings() =>
      _db.select(_db.userSettings).watchSingleOrNull().map((s) => s!);

  Future<UserSetting> getSettings() => _db.getSettings();

  Future<void> completeOnboarding({
    required List<String> goals,
    required String reminderTime,
    required bool notificationsEnabled,
  }) async {
    await _db.updateSettings(UserSettingsCompanion(
      onboardingComplete: const Value(true),
      goals: Value(goals.join(',')),
      defaultReminderTime: Value(reminderTime),
      notificationsEnabled: Value(notificationsEnabled),
    ));
  }

  Future<void> setThemeMode(String mode) =>
      _db.updateSettings(UserSettingsCompanion(themeMode: Value(mode)));

  Future<void> resetAllData() async {
    await _db.delete(_db.exerciseHistories).go();
    await _db.delete(_db.journalEntries).go();
    await _db.delete(_db.moods).go();
    await _db.delete(_db.breathingHistories).go();
    await _db.delete(_db.waterTrackings).go();
    await _db.delete(_db.dailyProgresses).go();
    await _db.updateSettings(const UserSettingsCompanion(onboardingComplete: Value(false)));
  }
}
