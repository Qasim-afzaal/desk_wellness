import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class ManifestRepository {
  ManifestRepository(this._db);
  final AppDatabase _db;

  Stream<List<ManifestSession>> watchRecent({int limit = 20}) {
    return (_db.select(_db.manifestSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .watch();
  }

  Future<int> count() async {
    final rows = await _db.select(_db.manifestSessions).get();
    return rows.length;
  }

  Future<void> save({required String content, required String goalTag}) async {
    await _db.into(_db.manifestSessions).insert(ManifestSessionsCompanion.insert(
          content: content,
          goalTag: Value(goalTag),
        ));
  }
}
