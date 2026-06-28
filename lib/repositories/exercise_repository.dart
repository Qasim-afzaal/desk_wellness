import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class ExerciseRepository {
  ExerciseRepository(this._db);
  final AppDatabase _db;

  Stream<List<ExerciseCategory>> watchCategories() =>
      (_db.select(_db.exerciseCategories)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();

  Stream<List<Exercise>> watchExercises({int? categoryId}) {
    final q = _db.select(_db.exercises);
    if (categoryId != null) {
      q.where((t) => t.categoryId.equals(categoryId));
    }
    return q.watch();
  }

  Future<Exercise?> getById(int id) =>
      (_db.select(_db.exercises)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> toggleFavorite(int id, bool fav) =>
      (_db.update(_db.exercises)..where((t) => t.id.equals(id)))
          .write(ExercisesCompanion(isFavorite: Value(fav)));

  Future<void> recordCompletion(int exerciseId, int durationSeconds) async {
    await _db.into(_db.exerciseHistories).insert(ExerciseHistoriesCompanion.insert(
          exerciseId: exerciseId,
          completedAt: DateTime.now(),
          durationSeconds: durationSeconds,
        ));
  }

  Future<int> todayCompletionCount() async {
    final start = DateTime.now();
    final dayStart = DateTime(start.year, start.month, start.day);
    final rows = await (_db.select(_db.exerciseHistories)
          ..where((t) => t.completedAt.isBiggerOrEqualValue(dayStart)))
        .get();
    return rows.length;
  }
}
