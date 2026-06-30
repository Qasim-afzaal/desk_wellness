import 'package:flutter/material.dart';

@immutable
class AffirmationTemplate {
  const AffirmationTemplate({
    required this.id,
    required this.name,
    required this.label,
    required this.category,
    required this.background,
    required this.accent,
    required this.sampleText,
  });

  final String id;
  final String name;
  final String label;
  final String category;
  final Color background;
  final Color accent;
  final String sampleText;
}

abstract final class AffirmationTemplates {
  static const categories = ['all', 'calm', 'bold', 'manifest', 'abundance', 'love', 'focus'];

  static const all = [
    // Calm
    AffirmationTemplate(
      id: 'sun',
      name: 'Soft sunrise',
      label: 'Sun',
      category: 'calm',
      background: Color(0xFFF2D4D4),
      accent: Color(0xFFF5D76E),
      sampleText: 'I welcome gentle progress.',
    ),
    AffirmationTemplate(
      id: 'sage',
      name: 'Sage morning',
      label: 'Sage',
      category: 'calm',
      background: Color(0xFFD4E2D0),
      accent: Color(0xFF6B8F71),
      sampleText: 'My words can shape a kinder day.',
    ),
    AffirmationTemplate(
      id: 'moon',
      name: 'Moonlit calm',
      label: 'Moon',
      category: 'calm',
      background: Color(0xFFD8DCE8),
      accent: Color(0xFF8B93A8),
      sampleText: 'I release what I cannot control.',
    ),
    AffirmationTemplate(
      id: 'bloom',
      name: 'Quiet bloom',
      label: 'Bloom',
      category: 'calm',
      background: Color(0xFFF5F0E8),
      accent: Color(0xFFE8C4C4),
      sampleText: 'I grow at my own pace.',
    ),
    AffirmationTemplate(
      id: 'mist',
      name: 'Morning mist',
      label: 'Mist',
      category: 'calm',
      background: Color(0xFFE8EEF0),
      accent: Color(0xFFB8C9CE),
      sampleText: 'I breathe in calm and breathe out tension.',
    ),
    // Bold
    AffirmationTemplate(
      id: 'glow',
      name: 'Golden glow',
      label: 'Glow',
      category: 'bold',
      background: Color(0xFFF5E6A8),
      accent: Color(0xFFE8A84C),
      sampleText: 'I choose thoughts that lift me up.',
    ),
    AffirmationTemplate(
      id: 'forest',
      name: 'Forest deep',
      label: 'Forest',
      category: 'bold',
      background: Color(0xFF3D5A45),
      accent: Color(0xFFF5F0E8),
      sampleText: 'I am rooted, steady, and strong.',
    ),
    AffirmationTemplate(
      id: 'ember',
      name: 'Warm ember',
      label: 'Ember',
      category: 'bold',
      background: Color(0xFF5C3D3D),
      accent: Color(0xFFE8A84C),
      sampleText: 'I am powerful, focused, and ready.',
    ),
    // Manifest
    AffirmationTemplate(
      id: 'vision',
      name: 'Vision board',
      label: 'Vision',
      category: 'manifest',
      background: Color(0xFF2A3347),
      accent: Color(0xFFF5D76E),
      sampleText: 'What I speak, I create.',
    ),
    AffirmationTemplate(
      id: 'portal',
      name: 'Open portal',
      label: 'Portal',
      category: 'manifest',
      background: Color(0xFF4A3F6B),
      accent: Color(0xFFE8C4C4),
      sampleText: 'My dreams are becoming my reality.',
    ),
    AffirmationTemplate(
      id: 'spark',
      name: 'First spark',
      label: 'Spark',
      category: 'manifest',
      background: Color(0xFF1C1C1C),
      accent: Color(0xFFF5E6A8),
      sampleText: 'I am aligned with my highest path.',
    ),
    // Abundance
    AffirmationTemplate(
      id: 'gold',
      name: 'Golden flow',
      label: 'Gold',
      category: 'abundance',
      background: Color(0xFFF5E6A8),
      accent: Color(0xFFD4AF37),
      sampleText: 'Abundance flows to me with ease.',
    ),
    AffirmationTemplate(
      id: 'harvest',
      name: 'Rich harvest',
      label: 'Harvest',
      category: 'abundance',
      background: Color(0xFF6B8F71),
      accent: Color(0xFFF5F0E8),
      sampleText: 'I am open to receiving more good.',
    ),
    // Love
    AffirmationTemplate(
      id: 'rose',
      name: 'Soft rose',
      label: 'Rose',
      category: 'love',
      background: Color(0xFFF2D4D4),
      accent: Color(0xFFE8A0A0),
      sampleText: 'I love and accept myself fully.',
    ),
    AffirmationTemplate(
      id: 'heart',
      name: 'Open heart',
      label: 'Heart',
      category: 'love',
      background: Color(0xFFE8C4C4),
      accent: Color(0xFF8B4A5C),
      sampleText: 'I give and receive love freely.',
    ),
    // Focus
    AffirmationTemplate(
      id: 'clarity',
      name: 'Clear mind',
      label: 'Clarity',
      category: 'focus',
      background: Color(0xFFD8DCE8),
      accent: Color(0xFF3D5A45),
      sampleText: 'My mind is clear and my focus is sharp.',
    ),
    AffirmationTemplate(
      id: 'peak',
      name: 'Summit',
      label: 'Peak',
      category: 'focus',
      background: Color(0xFF2A3347),
      accent: Color(0xFF8EB8A8),
      sampleText: 'I show up fully for what matters.',
    ),
  ];

  static AffirmationTemplate? byId(String id) {
    for (final t in all) {
      if (t.id == id) return t;
    }
    return null;
  }

  static List<AffirmationTemplate> filtered(String tab) {
    if (tab == 'all') return all;
    return all.where((t) => t.category == tab).toList();
  }

  static AffirmationTemplate? forCategory(String category) {
    return switch (category) {
      'calm' => byId('sage'),
      'bold' => byId('peak'),
      'manifest' => byId('sun'),
      'abundance' => byId('gold'),
      'love' => byId('rose'),
      'focus' => byId('vision'),
      _ => byId('sage'),
    };
  }

  static AffirmationTemplate? forGoal(String goalId) {
    return switch (goalId) {
      'abundance' => byId('gold'),
      'love' => byId('rose'),
      'career' || 'creativity' => byId('peak'),
      'confidence' || 'relationships' => byId('vision'),
      'health' || 'peace' => byId('sage'),
      _ => byId('sun'),
    };
  }
}
