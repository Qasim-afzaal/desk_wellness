import 'package:drift/drift.dart';

import 'package:desk_wellness/database/app_database.dart';

abstract final class SeedData {
  static final categories = [
    ExerciseCategoriesCompanion.insert(slug: 'neck', name: 'Neck Pain', sortOrder: const Value(1)),
    ExerciseCategoriesCompanion.insert(slug: 'shoulder', name: 'Shoulder', sortOrder: const Value(2)),
    ExerciseCategoriesCompanion.insert(slug: 'back', name: 'Back', sortOrder: const Value(3)),
    ExerciseCategoriesCompanion.insert(slug: 'wrist', name: 'Wrist', sortOrder: const Value(4)),
    ExerciseCategoriesCompanion.insert(slug: 'eyes', name: 'Eyes', sortOrder: const Value(5)),
    ExerciseCategoriesCompanion.insert(slug: 'standing', name: 'Standing Stretch', sortOrder: const Value(6)),
    ExerciseCategoriesCompanion.insert(slug: 'desk_yoga', name: 'Desk Yoga', sortOrder: const Value(7)),
    ExerciseCategoriesCompanion.insert(slug: 'breathing', name: 'Breathing', sortOrder: const Value(8)),
    ExerciseCategoriesCompanion.insert(slug: 'focus', name: 'Focus Reset', sortOrder: const Value(9)),
  ];

  static List<ExercisesCompanion> get exercises => [
        _ex(1, 'neck_roll', 'Neck Roll', 1, 90, 'easy', 'assets/exercises/neck_roll.gif',
            'Gentle neck circles to release tension from screen time.',
            'Slowly roll your head in a circle. Breathe steadily. Switch direction halfway.',
            'Reduces neck stiffness, improves circulation.', 'Neck, upper traps'),
        _ex(2, 'shoulder_shrug', 'Shoulder Shrug Release', 2, 60, 'easy', 'assets/exercises/shoulder_shrug.gif',
            'Release shoulder tension from typing and poor posture.',
            'Lift shoulders to ears, hold 3 seconds, release slowly. Repeat 5 times.',
            'Relieves shoulder tightness.', 'Trapezius, deltoids'),
        _ex(3, 'desk_stretch', 'Desk Side Stretch', 3, 90, 'easy', 'assets/exercises/desk_stretch.gif',
            'Open the side body while seated.',
            'Reach one arm overhead and lean to the side. Hold 20 seconds each side.',
            'Improves spinal mobility.', 'Obliques, lats'),
        _ex(4, 'seated_cat_cow', 'Seated Cat-Cow', 7, 90, 'easy', 'assets/exercises/seated_cat_cow.gif',
            'Mobilize the spine at your desk.',
            'Alternate rounding and arching your back with breath. 8 slow reps.',
            'Reduces back stiffness.', 'Spine, core'),
        _ex(5, 'deep_breathing', 'Deep Breathing Reset', 8, 120, 'easy', 'assets/exercises/deep_breathing.gif',
            'Calm the nervous system in two minutes.',
            'Inhale 4 counts, hold 4, exhale 6. Repeat for the full duration.',
            'Lowers stress, improves focus.', 'Diaphragm'),
      ];

  static ExercisesCompanion _ex(
    int id,
    String slug,
    String title,
    int catId,
    int secs,
    String diff,
    String asset,
    String desc,
    String instr,
    String benefits,
    String muscles,
  ) =>
      ExercisesCompanion.insert(
        id: Value(id),
        slug: slug,
        title: title,
        categoryId: catId,
        durationSeconds: secs,
        difficulty: diff,
        animationAsset: Value(asset),
        description: desc,
        instructions: instr,
        benefits: benefits,
        targetMuscles: muscles,
      );

  static final affirmations = [
    AffirmationsCompanion.insert(content: 'I take mindful breaks and return to work refreshed.', category: 'focus'),
    AffirmationsCompanion.insert(content: 'My body deserves care, even on busy days.', category: 'health'),
    AffirmationsCompanion.insert(content: 'I breathe deeply and release tension with every exhale.', category: 'stress'),
    AffirmationsCompanion.insert(content: 'I am capable, calm, and focused.', category: 'confidence'),
    AffirmationsCompanion.insert(content: 'Small habits create lasting wellness.', category: 'motivation'),
    AffirmationsCompanion.insert(content: 'I lead with clarity and compassion.', category: 'leadership'),
    AffirmationsCompanion.insert(content: 'I protect my energy and prioritize rest.', category: 'sleep'),
    AffirmationsCompanion.insert(content: 'Deep work flows when my body feels good.', category: 'productivity'),
  ];

  static final achievements = [
    AchievementsCompanion.insert(
        slug: 'first_break', title: 'First Break', description: 'Completed your first exercise',
        icon: 'emoji_events'),
    AchievementsCompanion.insert(
        slug: 'streak_3', title: '3 Day Streak', description: 'Three days of wellness',
        icon: 'local_fire_department'),
    AchievementsCompanion.insert(
        slug: 'streak_7', title: 'Week Warrior', description: 'Seven day streak',
        icon: 'military_tech'),
    AchievementsCompanion.insert(
        slug: 'journal_start', title: 'Reflective Mind', description: 'First journal entry',
        icon: 'menu_book'),
    AchievementsCompanion.insert(
        slug: 'breathe_calm', title: 'Calm Breath', description: 'Completed a breathing session',
        icon: 'air'),
  ];

  static final defaultSettings = UserSettingsCompanion.insert();
}
