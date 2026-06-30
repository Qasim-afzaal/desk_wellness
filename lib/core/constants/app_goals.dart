import 'package:meta/meta.dart';

@immutable
class AppGoal {
  const AppGoal({required this.id, required this.title, required this.icon, required this.prompt});

  final String id;
  final String title;
  final String icon;
  final String prompt;
}

abstract final class AppGoals {
  static const all = [
    AppGoal(
      id: 'confidence',
      title: 'Confidence',
      icon: '✨',
      prompt: 'I am becoming more confident every day.',
    ),
    AppGoal(
      id: 'abundance',
      title: 'Abundance',
      icon: '💫',
      prompt: 'Abundance flows to me with ease.',
    ),
    AppGoal(
      id: 'love',
      title: 'Self-love',
      icon: '💗',
      prompt: 'I love and accept myself fully.',
    ),
    AppGoal(
      id: 'career',
      title: 'Career',
      icon: '🚀',
      prompt: 'I attract opportunities aligned with my purpose.',
    ),
    AppGoal(
      id: 'health',
      title: 'Health',
      icon: '🌿',
      prompt: 'My body is strong, calm, and energized.',
    ),
    AppGoal(
      id: 'peace',
      title: 'Inner peace',
      icon: '🕊️',
      prompt: 'I choose peace in every moment.',
    ),
    AppGoal(
      id: 'creativity',
      title: 'Creativity',
      icon: '🎨',
      prompt: 'Creative ideas flow through me freely.',
    ),
    AppGoal(
      id: 'relationships',
      title: 'Relationships',
      icon: '🤝',
      prompt: 'I attract loving, supportive connections.',
    ),
  ];

  static AppGoal? byId(String id) {
    for (final g in all) {
      if (g.id == id) return g;
    }
    return null;
  }

  static List<AppGoal> fromCsv(String csv) {
    if (csv.isEmpty) return [];
    return csv.split(',').map((id) => byId(id.trim())).whereType<AppGoal>().toList();
  }

  static String categoryForGoal(String goalId) => switch (goalId) {
        'abundance' => 'abundance',
        'love' || 'relationships' => 'love',
        'career' || 'creativity' => 'focus',
        'confidence' => 'manifest',
        'health' || 'peace' => 'calm',
        _ => 'manifest',
      };
}
