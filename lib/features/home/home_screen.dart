import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final score = ref.watch(wellnessScoreProvider);
    final streak = ref.watch(streakProvider);
    final affirmation = ref.watch(todayAffirmationProvider);
    final water = ref.watch(waterTodayProvider);
    final mood = ref.watch(latestMoodProvider);
    final insight = ref.watch(aiServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CalmCalibrate'),
        actions: [IconButton(onPressed: () => context.push('/progress'), icon: const Icon(Icons.insights_outlined))],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(wellnessScoreProvider);
          ref.invalidate(streakProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text('Good ${_greeting()}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Row(
                children: [
                  _ScoreRing(score: score.valueOrNull ?? 0),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Wellness score', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('Based on movement, mood, and journal activity', style: TextStyle(color: c.textSecondary, fontSize: 13)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('${streak.valueOrNull ?? 0} day streak', style: TextStyle(color: c.primary, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(child: _QuickStat(icon: Icons.mood, label: 'Mood', value: _moodLabel(mood.valueOrNull?.moodLevel))),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _QuickStat(icon: Icons.water_drop_outlined, label: 'Water', value: '${water.valueOrNull ?? 0}/8')),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: "Today's affirmation"),
            affirmation.when(
              data: (a) => AppCard(
                child: Text(a?.content ?? 'Take a breath. You are doing enough.', style: const TextStyle(fontSize: 16, height: 1.5)),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: 'Quick actions'),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _ActionChip(icon: Icons.directions_run, label: 'Exercise', onTap: () => context.go('/exercises')),
                _ActionChip(icon: Icons.air, label: 'Breathe', onTap: () => context.go('/breathe')),
                _ActionChip(icon: Icons.mood, label: 'Log mood', onTap: () => context.push('/mood')),
                _ActionChip(icon: Icons.water_drop, label: '+ Water', onTap: () => ref.read(waterRepositoryProvider).addGlass().then((_) => ref.invalidate(waterTodayProvider))),
                _ActionChip(icon: Icons.format_quote, label: 'Affirmations', onTap: () => context.push('/affirmations')),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            FutureBuilder(
              future: insight.dailyInsight(
                wellnessScore: score.valueOrNull ?? 0,
                streakDays: streak.valueOrNull ?? 0,
                goals: '',
              ),
              builder: (context, snap) {
                if (!snap.hasData) return const SizedBox.shrink();
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Icon(Icons.auto_awesome, size: 18, color: c.secondary), const SizedBox(width: 8), const Text('Daily insight', style: TextStyle(fontWeight: FontWeight.w600))]),
                      const SizedBox(height: AppSpacing.sm),
                      Text(snap.data!, style: TextStyle(color: c.textSecondary, height: 1.5)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'morning';
    if (h < 17) return 'afternoon';
    return 'evening';
  }

  String _moodLabel(int? level) {
    if (level == null) return 'Log';
    const labels = ['', 'Low', 'Meh', 'OK', 'Good', 'Great'];
    return labels[level.clamp(1, 5)];
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(value: score / 100, strokeWidth: 8, color: c.primary, backgroundColor: c.primarySoft),
          Text('$score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: c.primary)),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: c.primary, size: 22),
        const SizedBox(height: AppSpacing.sm),
        Text(label, style: TextStyle(color: c.textMuted, fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
      ]),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(avatar: Icon(icon, size: 18), label: Text(label), onPressed: onTap);
  }
}
