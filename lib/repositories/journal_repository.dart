import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class JournalRepository {
  JournalRepository(this._db);
  final AppDatabase _db;

  Stream<List<JournalEntry>> watchAll() =>
      (_db.select(_db.journalEntries)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).watch();

  Future<void> save({int? id, required String title, required String body, String tags = ''}) async {
    if (id == null) {
      await _db.into(_db.journalEntries).insert(JournalEntriesCompanion.insert(
            title: Value(title),
            body: body,
            tags: Value(tags),
          ));
    } else {
      await (_db.update(_db.journalEntries)..where((t) => t.id.equals(id))).write(
        JournalEntriesCompanion(
          title: Value(title),
          body: Value(body),
          tags: Value(tags),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<void> delete(int id) =>
      (_db.delete(_db.journalEntries)..where((t) => t.id.equals(id))).go();
}
