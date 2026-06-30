import 'package:desk_wellness/core/constants/app_goals.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class AffirmationRepository {
  AffirmationRepository(this._db);
  final AppDatabase _db;

  Stream<List<Affirmation>> watchAll({String? category}) {
    final q = _db.select(_db.affirmations)..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (category != null && category != 'all') {
      q.where((t) => t.category.equals(category));
    }
    return q.watch();
  }

  Stream<List<Affirmation>> watchFavorites() {
    return (_db.select(_db.affirmations)
          ..where((t) => t.isFavorite.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<List<Affirmation>> getFeed({
    String? category,
    List<String> topicCategories = const [],
  }) async {
    final q = _db.select(_db.affirmations);
    if (category != null && category != 'all') {
      q.where((t) => t.category.equals(category));
    }
    var all = await q.get();

    if ((category == null || category == 'all') && topicCategories.isNotEmpty) {
      all = all.where((a) => topicCategories.contains(a.category)).toList();
    }

    if (all.isEmpty) return all;
    final offset = DateTime.now().day % all.length;
    return [...all.sublist(offset), ...all.sublist(0, offset)];
  }

  Future<String> randomAffirmationText() async {
    final all = await _db.select(_db.affirmations).get();
    if (all.isEmpty) return 'Open Affirmly for your daily affirmation.';
    return all[DateTime.now().millisecond % all.length].content;
  }

  Future<Affirmation?> todayAffirmation({List<String> goalIds = const []}) async {
    final all = await _db.select(_db.affirmations).get();
    if (all.isEmpty) return null;

    if (goalIds.isNotEmpty) {
      final category = AppGoals.categoryForGoal(goalIds.first);
      final matched = all.where((a) => a.category == category).toList();
      if (matched.isNotEmpty) {
        return matched[DateTime.now().day % matched.length];
      }
    }

    return all[DateTime.now().day % all.length];
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
