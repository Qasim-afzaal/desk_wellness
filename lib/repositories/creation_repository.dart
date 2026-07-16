import 'package:desk_wellness/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class CreationRepository {
  CreationRepository(this._db);
  final AppDatabase _db;

  Stream<List<SavedCreation>> watchSaved({String? query}) {
    final q = _db.select(_db.savedCreations)
      ..where((t) => t.isBookmarked.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return q.watch().map((rows) {
      if (query == null || query.isEmpty) return rows;
      final lower = query.toLowerCase();
      return rows.where((r) => r.content.toLowerCase().contains(lower)).toList();
    });
  }

  Future<int> wallpaperCount() async {
    final rows = await _db.select(_db.savedCreations).get();
    return rows.length;
  }

  Future<int> streakDays() async {
    final rows = await (_db.select(_db.savedCreations)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    if (rows.isEmpty) return 0;

    var streak = 0;
    var cursor = DateTime.now();
    final days = rows.map((r) => DateTime(r.createdAt.year, r.createdAt.month, r.createdAt.day)).toSet();

    while (days.contains(DateTime(cursor.year, cursor.month, cursor.day))) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  Future<List<int>> weeklyActivity() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = today.subtract(Duration(days: now.weekday - DateTime.monday));
    final rows = await (_db.select(_db.savedCreations)
          ..where((t) => t.createdAt.isBiggerOrEqualValue(start)))
        .get();

    return List.generate(7, (i) {
      final day = start.add(Duration(days: i));
      return rows
          .where((r) =>
              r.createdAt.year == day.year && r.createdAt.month == day.month && r.createdAt.day == day.day)
          .length;
    });
  }

  Future<void> save({
    required String content,
    required String templateId,
    required Color background,
    required Color accent,
    required String fontStyle,
    required String textAlign,
    required String exportType,
  }) async {
    await _db.into(_db.savedCreations).insert(SavedCreationsCompanion.insert(
          content: content,
          templateId: templateId,
          backgroundHex: _hex(background),
          accentHex: _hex(accent),
          fontStyle: Value(fontStyle),
          textAlign: Value(textAlign),
          exportType: Value(exportType),
        ));
  }

  Future<void> toggleBookmark(int id, bool bookmarked) =>
      (_db.update(_db.savedCreations)..where((t) => t.id.equals(id)))
          .write(SavedCreationsCompanion(isBookmarked: Value(bookmarked)));

  Future<void> delete(int id) =>
      (_db.delete(_db.savedCreations)..where((t) => t.id.equals(id))).go();

  static String _hex(Color c) =>
      '#${c.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  static Color colorFromHex(String hex) {
    final value = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color(0xFF000000 | value);
  }
}
