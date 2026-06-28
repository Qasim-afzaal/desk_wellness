import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class BreathingRepository {
  BreathingRepository(this._db);
  final AppDatabase _db;

  Future<void> recordSession(String pattern, int durationSeconds) async {
    await _db.into(_db.breathingHistories).insert(BreathingHistoriesCompanion.insert(
          pattern: pattern,
          durationSeconds: durationSeconds,
        ));
  }

  Stream<List<BreathingHistory>> watchRecent() =>
      (_db.select(_db.breathingHistories)..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
          .watch();
}
