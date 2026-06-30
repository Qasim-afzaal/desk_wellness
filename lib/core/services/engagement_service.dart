import 'package:shared_preferences/shared_preferences.dart';

class EngagementService {
  static const _lastOpenKey = 'engagement_last_open';
  static const _streakKey = 'engagement_streak';

  Future<void> recordDailyEngagement() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _dateKey(DateTime.now());
    final last = prefs.getString(_lastOpenKey);
    if (last == today) return;

    var streak = prefs.getInt(_streakKey) ?? 0;
    if (last != null) {
      final yesterday = _dateKey(DateTime.now().subtract(const Duration(days: 1)));
      streak = last == yesterday ? streak + 1 : 1;
    } else {
      streak = 1;
    }

    await prefs.setString(_lastOpenKey, today);
    await prefs.setInt(_streakKey, streak);
  }

  Future<int> streakDays() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString(_lastOpenKey);
    if (last == null) return 0;

    final today = _dateKey(DateTime.now());
    final yesterday = _dateKey(DateTime.now().subtract(const Duration(days: 1)));
    if (last != today && last != yesterday) return 0;
    return prefs.getInt(_streakKey) ?? 0;
  }

  String _dateKey(DateTime d) => '${d.year}-${d.month}-${d.day}';
}
