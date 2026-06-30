import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/features/onboarding/goals_screen.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final settingsAsync = ref.watch(settingsStreamProvider);
    final streakAsync = ref.watch(engagementStreakProvider);
    final weeklyAsync = ref.watch(weeklyActivityProvider);

    return KindledScreen(
      title: 'PROFILE',
      child: settingsAsync.when(
        data: (settings) {
          final initial = settings.displayName.isNotEmpty ? settings.displayName[0].toUpperCase() : 'K';
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: c.primarySoft,
                      child: Text(initial, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: c.primary)),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(settings.displayName, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                          streakAsync.when(
                            data: (s) => Text('$s day streak', style: TextStyle(color: c.textMuted)),
                            loading: () => Text('…', style: TextStyle(color: c.textMuted)),
                            error: (_, __) => Text('0 day mindful streak', style: TextStyle(color: c.textMuted)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Text('Weekly rhythm', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 160,
                  child: weeklyAsync.when(
                    data: (values) {
                      final maxVal = values.reduce((a, b) => a > b ? a : b);
                      return BarChart(
                        BarChartData(
                          maxY: (maxVal + 1).toDouble(),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, _) {
                                  const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                                  final i = value.toInt();
                                  if (i < 0 || i >= days.length) return const SizedBox.shrink();
                                  return Text(days[i], style: TextStyle(color: c.textMuted, fontSize: 12));
                                },
                              ),
                            ),
                          ),
                          barGroups: List.generate(
                            values.length,
                            (i) => BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: values[i].toDouble(),
                                  color: c.primary,
                                  width: 16,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => Center(child: Text('Could not load activity', style: TextStyle(color: c.textMuted))),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _SettingsTile(
                  icon: Icons.explore_outlined,
                  title: 'Explore topics',
                  onTap: () => context.push('/explore'),
                ),
                _SettingsTile(
                  icon: Icons.watch_outlined,
                  title: 'Watch face',
                  onTap: () => context.push('/watch'),
                ),
                _SettingsTile(
                  icon: Icons.widgets_outlined,
                  title: 'Widgets & Watch',
                  onTap: () => context.push('/widgets'),
                ),
                _SettingsTile(
                  icon: Icons.bookmark_outlined,
                  title: 'Saved wallpapers',
                  onTap: () => context.push('/wallpapers'),
                ),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Reminders',
                  onTap: () => context.push('/notifications'),
                ),
                _SettingsTile(
                  icon: Icons.flag_outlined,
                  title: 'Manifestation goals',
                  onTap: () async {
                    final result = await Navigator.of(context).push<List<String>>(
                      MaterialPageRoute(builder: (_) => const OnboardingGoalsScreen(isOnboarding: false)),
                    );
                    if (result != null && result.isNotEmpty) {
                      await ref.read(settingsRepositoryProvider).setGoals(result);
                    }
                  },
                ),
                _SettingsTile(
                  icon: Icons.format_quote_outlined,
                  title: 'Affirmation library',
                  onTap: () => context.push('/affirmations'),
                ),
                _SettingsTile(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Manifest session',
                  onTap: () => context.push('/manifest'),
                ),
                _SettingsTile(
                  icon: Icons.record_voice_over_outlined,
                  title: 'Voice',
                  subtitle: 'Listen on Today tab',
                  onTap: () => context.go('/today'),
                ),
                _SettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: settings.themeMode,
                  onTap: () async {
                    final next = settings.themeMode == 'dark' ? 'light' : 'dark';
                    await ref.read(settingsRepositoryProvider).setThemeMode(next);
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: c.border),
        ),
        child: ListTile(
          leading: Icon(icon, color: c.primary),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
