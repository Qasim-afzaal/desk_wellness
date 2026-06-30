import 'package:shared_preferences/shared_preferences.dart';

class ThemeSelectionService {
  static const _key = 'selected_theme_id';

  Future<String> getSelectedThemeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'sage';
  }

  Future<void> setSelectedThemeId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, id);
  }
}
