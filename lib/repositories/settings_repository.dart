import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class SettingsRepository {
  SettingsRepository(this._db);
  final AppDatabase _db;

  Stream<UserSetting> watchSettings() =>
      _db.select(_db.userSettings).watchSingleOrNull().map((s) => s!);

  Future<UserSetting> getSettings() => _db.getSettings();

  Future<void> completeOnboarding({List<String> goals = const []}) async {
    await _db.updateSettings(UserSettingsCompanion(
      onboardingComplete: const Value(true),
      goals: Value(goals.join(',')),
      notificationsEnabled: const Value(true),
    ));
  }

  Future<void> setGoals(List<String> goalIds) =>
      _db.updateSettings(UserSettingsCompanion(goals: Value(goalIds.join(','))));

  Future<void> setDisplayName(String name) =>
      _db.updateSettings(UserSettingsCompanion(displayName: Value(name)));

  Future<void> setThemeMode(String mode) =>
      _db.updateSettings(UserSettingsCompanion(themeMode: Value(mode)));

  Future<void> setNotificationsEnabled(bool enabled) =>
      _db.updateSettings(UserSettingsCompanion(notificationsEnabled: Value(enabled)));

  Future<void> resetAllData() async {
    await _db.delete(_db.savedCreations).go();
    await _db.delete(_db.manifestSessions).go();
    await _db.update(_db.affirmations).write(const AffirmationsCompanion(isFavorite: Value(false)));
    await _db.updateSettings(const UserSettingsCompanion(onboardingComplete: Value(false)));
  }
}
