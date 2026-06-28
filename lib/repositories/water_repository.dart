import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';

class WaterRepository {
  WaterRepository(this._db);
  final AppDatabase _db;

  Future<int> todayGlasses() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final row = await (_db.select(_db.waterTrackings)..where((t) => t.date.equals(start)))
        .getSingleOrNull();
    return row?.glasses ?? 0;
  }

  Future<void> addGlass() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final existing = await (_db.select(_db.waterTrackings)..where((t) => t.date.equals(start)))
        .getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.waterTrackings).insert(WaterTrackingsCompanion.insert(date: start, glasses: const Value(1)));
    } else {
      await (_db.update(_db.waterTrackings)..where((t) => t.id.equals(existing.id)))
          .write(WaterTrackingsCompanion(glasses: Value(existing.glasses + 1)));
    }
  }
}
