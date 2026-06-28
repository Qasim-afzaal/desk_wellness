import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class MoodRepository {
  MoodRepository(this._db);
  final AppDatabase _db;

  Stream<List<Mood>> watchRecent({int limit = 30}) =>
      (_db.select(_db.moods)
            ..orderBy([(t) => OrderingTerm.desc(t.recordedAt)])
            ..limit(limit))
          .watch();

  Future<void> record({
    required int mood,
    required int stress,
    required int energy,
    int? sleep,
    String notes = '',
  }) async {
    await _db.into(_db.moods).insert(MoodsCompanion.insert(
          moodLevel: mood,
          stressLevel: stress,
          energyLevel: energy,
          sleepQuality: Value(sleep),
          notes: Value(notes),
        ));
  }

  Future<Mood?> latest() async {
    return (_db.select(_db.moods)
          ..orderBy([(t) => OrderingTerm.desc(t.recordedAt)])
          ..limit(1))
        .getSingleOrNull();
  }
}
