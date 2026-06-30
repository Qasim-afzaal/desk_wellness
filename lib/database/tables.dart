import 'package:drift/drift.dart';

class ExerciseCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text().unique()();
  TextColumn get name => text()();
  TextColumn get icon => text().withDefault(const Constant('fitness_center'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text().unique()();
  TextColumn get title => text()();
  IntColumn get categoryId => integer().references(ExerciseCategories, #id)();
  IntColumn get durationSeconds => integer()();
  TextColumn get difficulty => text()(); // easy, medium, hard
  TextColumn get animationAsset => text().nullable()();
  TextColumn get description => text()();
  TextColumn get instructions => text()();
  TextColumn get benefits => text()();
  TextColumn get targetMuscles => text()();
  IntColumn get caloriesEstimate => integer().withDefault(const Constant(5))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

class ExerciseHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get durationSeconds => integer()();
}

class Affirmations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  TextColumn get category => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Moods extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get moodLevel => integer()();
  IntColumn get stressLevel => integer()();
  IntColumn get energyLevel => integer()();
  IntColumn get sleepQuality => integer().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();
}

class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get body => text()();
  TextColumn get tags => text().withDefault(const Constant(''))();
  IntColumn get moodId => integer().nullable().references(Moods, #id)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // stretch, exercise, water, breathing, affirmation, break, custom
  TextColumn get title => text()();
  TextColumn get timeOfDay => text()(); // HH:mm
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  TextColumn get daysOfWeek => text().withDefault(const Constant('1,2,3,4,5'))(); // Mon-Fri
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Achievements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text().unique()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get icon => text()();
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
}

class DailyProgresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  IntColumn get wellnessScore => integer().withDefault(const Constant(0))();
  IntColumn get exercisesCompleted => integer().withDefault(const Constant(0))();
  IntColumn get breathingSessions => integer().withDefault(const Constant(0))();
  IntColumn get journalEntries => integer().withDefault(const Constant(0))();
  IntColumn get waterGlasses => integer().withDefault(const Constant(0))();
  IntColumn get streakDay => integer().withDefault(const Constant(0))();
}

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get onboardingComplete => boolean().withDefault(const Constant(false))();
  TextColumn get displayName => text().withDefault(const Constant('there'))();
  TextColumn get goals => text().withDefault(const Constant(''))(); // comma-separated
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get defaultReminderTime => text().withDefault(const Constant('10:00'))();
  IntColumn get dailyWaterGoal => integer().withDefault(const Constant(8))();
}

class WaterTrackings extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get glasses => integer().withDefault(const Constant(0))();
}

class BreathingHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get pattern => text()(); // box, 478, calm, focus, sleep
  IntColumn get durationSeconds => integer()();
  DateTimeColumn get completedAt => dateTime().withDefault(currentDateAndTime)();
}

class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // exercise, affirmation
  IntColumn get entityId => integer()();
}

class SavedCreations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  TextColumn get templateId => text()();
  TextColumn get backgroundHex => text()();
  TextColumn get accentHex => text()();
  TextColumn get fontStyle => text().withDefault(const Constant('calm'))();
  TextColumn get textAlign => text().withDefault(const Constant('center'))();
  TextColumn get exportType => text().withDefault(const Constant('wallpaper'))();
  BoolColumn get isBookmarked => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ManifestSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  TextColumn get goalTag => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
