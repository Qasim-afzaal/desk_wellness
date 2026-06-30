import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:desk_wellness/database/seed_affirmations.dart';
import 'package:desk_wellness/database/seed_data.dart';
import 'package:desk_wellness/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  ExerciseCategories,
  Exercises,
  ExerciseHistories,
  Affirmations,
  JournalEntries,
  Reminders,
  Moods,
  Achievements,
  DailyProgresses,
  UserSettings,
  WaterTrackings,
  BreathingHistories,
  Favorites,
  SavedCreations,
  ManifestSessions,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.forTesting(super.e);

  static AppDatabase? _instance;

  static Future<AppDatabase> open() async {
    if (_instance != null) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'kindled_studio.sqlite'));
    _instance = AppDatabase(NativeDatabase.createInBackground(file));
    await _instance!._ensureSeed();
    return _instance!;
  }

  static AppDatabase openMemory() {
    return AppDatabase.forTesting(NativeDatabase.memory());
  }

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(savedCreations);
          }
          if (from < 3) {
            await m.createTable(manifestSessions);
          }
          if (from < 4) {
            await _seedExpandedAffirmations();
          }
        },
      );

  Future<void> _seedExpandedAffirmations() async {
    final existing = await select(affirmations).get();
    final known = existing.map((a) => a.content).toSet();
    final missing = SeedAffirmations.entries
        .where((e) => !known.contains(e.$2))
        .map((e) => AffirmationsCompanion.insert(content: e.$2, category: e.$1))
        .toList();
    if (missing.isEmpty) return;
    await batch((b) => b.insertAll(affirmations, missing));
  }

  Future<void> _ensureSeed() async {
    final settings = await select(userSettings).getSingleOrNull();
    if (settings != null) return;
    await transaction(() async {
      await batch((b) {
        b.insertAll(affirmations, SeedData.affirmations);
        b.insertAll(reminders, SeedData.defaultReminders);
        b.insert(userSettings, SeedData.defaultSettings);
      });
    });
  }

  Future<UserSetting> getSettings() async {
    final row = await select(userSettings).getSingleOrNull();
    if (row != null) return row;
    final id = await into(userSettings).insert(SeedData.defaultSettings);
    return (await (select(userSettings)..where((t) => t.id.equals(id))).getSingle());
  }

  Future<void> updateSettings(UserSettingsCompanion companion) async {
    final current = await getSettings();
    await (update(userSettings)..where((t) => t.id.equals(current.id))).write(companion);
  }
}
