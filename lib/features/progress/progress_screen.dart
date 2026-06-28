import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);
    final score = ref.watch(wellnessScoreProvider);
    final achievements = ref.watch(progressRepositoryProvider).watchAchievements();

    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            children: [
              Expanded(child: AppCard(padding: const EdgeInsets.all(AppSpacing.md), child: Column(children: [const Text('Streak'), Text('${streak.valueOrNull ?? 0}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800))]))),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: AppCard(padding: const EdgeInsets.all(AppSpacing.md), child: Column(children: [const Text('Score'), Text('${score.valueOrNull ?? 0}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800))]))),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Achievements'),
          StreamBuilder<List<Achievement>>(
            stream: achievements,
            builder: (context, snap) {
              final list = snap.data ?? [];
              return Column(
                children: list.map((a) => ListTile(
                      leading: Icon(a.isUnlocked ? Icons.emoji_events : Icons.lock_outline, color: a.isUnlocked ? context.colors.warning : context.colors.textMuted),
                      title: Text(a.title),
                      subtitle: Text(a.description),
                    )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
