import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class AffirmationRepository {
  AffirmationRepository(this._db);
  final AppDatabase _db;

  Stream<List<Affirmation>> watchAll({String? category}) {
    final q = _db.select(_db.affirmations);
    if (category != null && category != 'all') {
      q.where((t) => t.category.equals(category));
    }
    return q.watch();
  }

  Future<Affirmation?> todayAffirmation() async {
    final all = await _db.select(_db.affirmations).get();
    if (all.isEmpty) return null;
    final dayIndex = DateTime.now().day % all.length;
    return all[dayIndex];
  }

  Future<void> addCustom(String text, String category) =>
      _db.into(_db.affirmations).insert(AffirmationsCompanion.insert(
            content: text,
            category: category,
            isCustom: const Value(true),
          ));

  Future<void> toggleFavorite(int id, bool fav) =>
      (_db.update(_db.affirmations)..where((t) => t.id.equals(id)))
          .write(AffirmationsCompanion(isFavorite: Value(fav)));

  Future<void> delete(int id) =>
      (_db.delete(_db.affirmations)..where((t) => t.id.equals(id))).go();
}
