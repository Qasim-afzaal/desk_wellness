import 'package:flutter/material.dart';

@immutable
class AppGoal {
  const AppGoal({
    required this.id,
    required this.title,
    required this.icon,
    required this.prompt,
  });

  final String id;
  final String title;
  final IconData icon;
  final String prompt;
}

abstract final class AppGoals {
  static const all = [
    AppGoal(
      id: 'confidence',
      title: 'Confidence',
      icon: Icons.auto_awesome_outlined,
      prompt: 'I am becoming more confident every day.',
    ),
    AppGoal(
      id: 'abundance',
      title: 'Abundance',
      icon: Icons.diamond_outlined,
      prompt: 'Abundance flows to me with ease.',
    ),
    AppGoal(
      id: 'love',
      title: 'Self-love',
      icon: Icons.favorite_border,
      prompt: 'I love and accept myself fully.',
    ),
    AppGoal(
      id: 'career',
      title: 'Career',
      icon: Icons.rocket_launch_outlined,
      prompt: 'I attract opportunities aligned with my purpose.',
    ),
    AppGoal(
      id: 'health',
      title: 'Health',
      icon: Icons.spa_outlined,
      prompt: 'My body is strong, calm, and energized.',
    ),
    AppGoal(
      id: 'peace',
      title: 'Inner peace',
      icon: Icons.self_improvement_outlined,
      prompt: 'I choose peace in every moment.',
    ),
    AppGoal(
      id: 'creativity',
      title: 'Creativity',
      icon: Icons.palette_outlined,
      prompt: 'Creative ideas flow through me freely.',
    ),
    AppGoal(
      id: 'relationships',
      title: 'Relationships',
      icon: Icons.people_outline,
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
