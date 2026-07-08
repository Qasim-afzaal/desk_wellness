import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/features/onboarding/goals_screen.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static String _themeLabel(String mode) => switch (mode) {
        'light' => 'Light',
        'dark' => 'Dark',
        _ => 'System',
      };

  static IconData _themeIcon(String mode) => switch (mode) {
        'light' => Icons.light_mode_outlined,
        'dark' => Icons.dark_mode_outlined,
        _ => Icons.brightness_auto_outlined,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;
    final settingsAsync = ref.watch(settingsStreamProvider);
    final streakAsync = ref.watch(engagementStreakProvider);
    final weeklyAsync = ref.watch(weeklyActivityProvider);
    final favCountAsync = ref.watch(favoritesStreamProvider);

    return CelestialScaffold(
      body: SafeArea(
        child: settingsAsync.when(
          data: (settings) {
            final initial = settings.displayName.isNotEmpty ? settings.displayName[0].toUpperCase() : 'A';
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                    child: Text(
                      'PROFILE',
                      style: CelestialTypography.labelCaps(color: c.primary, brightness: brightness),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: GlassPanel(
                      radius: AppRadius.xl,
                      glow: true,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  gradient: CelestialGradients.button(brightness),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: c.buttonPrimary.withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  initial,
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: c.onPrimary),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      settings.displayName.isNotEmpty ? settings.displayName : 'Affirmly member',
                                      style: CelestialTypography.headlineLg(brightness: brightness).copyWith(fontSize: 22),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Your mindful space',
                                      style: CelestialTypography.bodyMd(color: c.textMuted, brightness: brightness),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.local_fire_department,
                                  value: streakAsync.maybeWhen(data: (s) => '$s', orElse: () => '—'),
                                  label: 'Day streak',
                                  color: CelestialPalette.tertiary(brightness),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.favorite_outline,
                                  value: favCountAsync.maybeWhen(data: (f) => '${f.length}', orElse: () => '—'),
                                  label: 'Favorites',
                                  color: c.buttonPrimary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.flag_outlined,
                                  value: '${settings.goals.split(',').where((g) => g.trim().isNotEmpty).length}',
                                  label: 'Goals',
                                  color: c.secondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly rhythm',
                          style: CelestialTypography.headlineLg(brightness: brightness).copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        GlassPanel(
                          radius: AppRadius.lg,
                          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md),
                          child: SizedBox(
                            height: 140,
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
                                            color: c.buttonPrimary,
                                            width: 14,
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (_, __) => Center(
                                child: Text('Could not load activity', style: TextStyle(color: c.textMuted)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.sm),
                    child: Text(
                      'Discover',
                      style: CelestialTypography.labelCaps(brightness: brightness),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _SettingsTile(icon: Icons.explore_outlined, title: 'Explore topics', onTap: () => context.push('/explore')),
                      _SettingsTile(icon: Icons.format_quote_outlined, title: 'Affirmation library', onTap: () => context.push('/affirmations')),
                      _SettingsTile(icon: Icons.bookmark_outlined, title: 'Saved wallpapers', onTap: () => context.push('/wallpapers')),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.sm),
                    child: Text('Your practice', style: CelestialTypography.labelCaps(brightness: brightness)),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
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
                      _SettingsTile(icon: Icons.auto_awesome_outlined, title: 'Manifest session', onTap: () => context.push('/manifest')),
                      _SettingsTile(icon: Icons.notifications_outlined, title: 'Reminders', onTap: () => context.push('/notifications')),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.sm),
                    child: Text('App', style: CelestialTypography.labelCaps(brightness: brightness)),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xxl),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _SettingsTile(icon: Icons.widgets_outlined, title: 'Widgets & Watch', onTap: () => context.push('/widgets')),
                      _SettingsTile(icon: Icons.watch_outlined, title: 'Watch face', onTap: () => context.push('/watch')),
                      _SettingsTile(
                        icon: _themeIcon(settings.themeMode),
                        title: 'Appearance',
                        subtitle: _themeLabel(settings.themeMode),
                        onTap: () async {
                          final next = switch (settings.themeMode) {
                            'light' => 'dark',
                            'dark' => 'system',
                            _ => 'light',
                          };
                          await ref.read(settingsRepositoryProvider).setThemeMode(next);
                        },
                      ),
                    ]),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.value, required this.label, required this.color});

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: c.textPrimary)),
          Text(label, style: CelestialTypography.labelCaps(color: c.textMuted, brightness: brightness)),
        ],
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
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: GlassPanel(
            radius: AppRadius.lg,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: c.buttonPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, color: c.buttonPrimary, size: 22),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: c.textPrimary, fontSize: 15)),
                      if (subtitle != null)
                        Text(subtitle!, style: TextStyle(color: c.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: c.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
