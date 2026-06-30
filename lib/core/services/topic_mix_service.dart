import 'package:shared_preferences/shared_preferences.dart';

class TopicMixService {
  static const _key = 'topic_mix_ids';

  Future<List<String>> getSelectedTopicIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? ['stress', 'positive', 'self_love'];
  }

  Future<void> setSelectedTopicIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids);
  }
}
