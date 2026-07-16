import 'package:desk_wellness/database/seed_affirmations.dart';
import 'package:drift/drift.dart';

import 'package:desk_wellness/database/app_database.dart';

abstract final class SeedData {
  static List<AffirmationsCompanion> get affirmations => SeedAffirmations.entries
      .map((e) => AffirmationsCompanion.insert(content: e.$2, category: e.$1))
      .toList();

  static final defaultReminders = [
    RemindersCompanion.insert(
      type: 'morning',
      title: 'Morning manifestation',
      timeOfDay: '08:30',
      enabled: const Value(true),
    ),
    RemindersCompanion.insert(
      type: 'midday',
      title: 'Midday affirmation',
      timeOfDay: '12:30',
      enabled: const Value(true),
    ),
    RemindersCompanion.insert(
      type: 'evening',
      title: 'Evening reflection',
      timeOfDay: '20:00',
      enabled: const Value(true),
    ),
  ];

  static final defaultSettings = UserSettingsCompanion.insert(
    displayName: const Value(''),
    goals: const Value('confidence,abundance,peace'),
  );
}
