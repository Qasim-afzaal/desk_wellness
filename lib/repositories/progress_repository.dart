import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class ProgressRepository {
  ProgressRepository(this._db);
  final AppDatabase _db;

  Future<int> streakDays() async {
    final rows = await (_db.select(_db.dailyProgresses)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
    if (rows.isEmpty) return 0;
    var streak = 0;
    var check = DateTime.now();
    for (final _ in rows) {
      final day = DateTime(check.year, check.month, check.day);
      final match = rows.any((r) {
        final d = r.date;
        return d.year == day.year && d.month == day.month && d.day == day.day && r.exercisesCompleted > 0;
      });
      if (!match) break;
      streak++;
      check = check.subtract(const Duration(days: 1));
    }
    return streak;
  }

  Future<int> wellnessScore() async {
    final exerciseCount = await _exerciseCountLast7Days();
    final moodAvg = await _moodAverageLast7Days();
    final journalCount = await _journalCountLast7Days();
    final score = (exerciseCount * 8 + moodAvg * 12 + journalCount * 5).clamp(0, 100);
    return score;
  }

  Future<int> _exerciseCountLast7Days() async {
    final since = DateTime.now().subtract(const Duration(days: 7));
    final rows = await (_db.select(_db.exerciseHistories)
          ..where((t) => t.completedAt.isBiggerOrEqualValue(since)))
        .get();
    return rows.length;
  }

  Future<int> _moodAverageLast7Days() async {
    final since = DateTime.now().subtract(const Duration(days: 7));
    final rows = await (_db.select(_db.moods)
          ..where((t) => t.recordedAt.isBiggerOrEqualValue(since)))
        .get();
    if (rows.isEmpty) return 3;
    return (rows.map((m) => m.moodLevel).reduce((a, b) => a + b) / rows.length).round();
  }

  Future<int> _journalCountLast7Days() async {
    final since = DateTime.now().subtract(const Duration(days: 7));
    final rows = await (_db.select(_db.journalEntries)
          ..where((t) => t.createdAt.isBiggerOrEqualValue(since)))
        .get();
    return rows.length;
  }

  Future<void> touchToday({int exercises = 0, int breathing = 0}) async {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    final existing = await (_db.select(_db.dailyProgresses)..where((t) => t.date.equals(day)))
        .getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.dailyProgresses).insert(DailyProgressesCompanion.insert(
            date: day,
            exercisesCompleted: Value(exercises),
            breathingSessions: Value(breathing),
            wellnessScore: Value(await wellnessScore()),
          ));
    } else {
      await (_db.update(_db.dailyProgresses)..where((t) => t.id.equals(existing.id))).write(
        DailyProgressesCompanion(
          exercisesCompleted: Value(existing.exercisesCompleted + exercises),
          breathingSessions: Value(existing.breathingSessions + breathing),
          wellnessScore: Value(await wellnessScore()),
        ),
      );
    }
  }

  Stream<List<Achievement>> watchAchievements() => _db.select(_db.achievements).watch();

  Future<void> unlockAchievement(String slug) async {
    await (_db.update(_db.achievements)..where((t) => t.slug.equals(slug))).write(
      AchievementsCompanion(isUnlocked: const Value(true), unlockedAt: Value(DateTime.now())),
    );
  }
}
