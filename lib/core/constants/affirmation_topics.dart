import 'package:flutter/material.dart';

@immutable
class AffirmationTopic {
  const AffirmationTopic({
    required this.id,
    required this.title,
    required this.icon,
    required this.categories,
    this.isFree = true,
  });

  final String id;
  final String title;
  final IconData icon;
  final List<String> categories;
  final bool isFree;
}

abstract final class AffirmationTopics {
  static const all = [
    AffirmationTopic(
      id: 'stress',
      title: 'Stress & anxiety',
      icon: Icons.waves_outlined,
      categories: ['calm'],
    ),
    AffirmationTopic(
      id: 'positive',
      title: 'Positive thinking',
      icon: Icons.lightbulb_outline,
      categories: ['manifest', 'bold'],
    ),
    AffirmationTopic(
      id: 'health',
      title: 'Health',
      icon: Icons.favorite_outline,
      categories: ['calm', 'focus'],
    ),
    AffirmationTopic(
      id: 'self_love',
      title: 'Love yourself',
      icon: Icons.self_improvement_outlined,
      categories: ['love'],
    ),
    AffirmationTopic(
      id: 'abundance',
      title: 'Abundance',
      icon: Icons.diamond_outlined,
      categories: ['abundance'],
    ),
    AffirmationTopic(
      id: 'confidence',
      title: 'Confidence',
      icon: Icons.auto_awesome_outlined,
      categories: ['bold', 'manifest'],
    ),
    AffirmationTopic(
      id: 'relationships',
      title: 'Relationships',
      icon: Icons.people_outline,
      categories: ['love'],
    ),
    AffirmationTopic(
      id: 'focus',
      title: 'Focus & work',
      icon: Icons.track_changes_outlined,
      categories: ['focus'],
    ),
  ];

  static AffirmationTopic? byId(String id) {
    for (final t in all) {
      if (t.id == id) return t;
    }
    return null;
  }

  static List<String> categoriesForTopics(List<String> topicIds) {
    final cats = <String>{};
    for (final id in topicIds) {
      final topic = byId(id);
      if (topic != null) cats.addAll(topic.categories);
    }
    return cats.toList();
  }
}

abstract final class ThemeMixes {
  static const mixes = [
    ('plain', 'Plain', ['sage']),
    ('sunsets', 'Sunsets', ['sun', 'glow', 'gold']),
    ('popular', 'Most popular', ['sage', 'forest', 'rose', 'gold']),
    ('nature', 'Nature', ['forest', 'bloom', 'harvest', 'mist']),
  ];
}
