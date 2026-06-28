import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: settings.when(
        data: (s) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppCard(
              child: Row(
                children: [
                  CircleAvatar(radius: 28, backgroundColor: context.colors.primarySoft, child: Icon(Icons.person, color: context.colors.primary)),
                  const SizedBox(width: AppSpacing.md),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Hello, ${s.displayName}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                    Text('All data stays on this device', style: TextStyle(color: context.colors.textSecondary, fontSize: 13)),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _Tile(icon: Icons.palette_outlined, title: 'Theme', subtitle: s.themeMode, onTap: () {}),
            _Tile(icon: Icons.notifications_outlined, title: 'Reminders', onTap: () => context.push('/reminders')),
            _Tile(icon: Icons.mood, title: 'Mood tracker', onTap: () => context.push('/mood')),
            _Tile(icon: Icons.format_quote, title: 'Affirmations', onTap: () => context.push('/affirmations')),
            _Tile(icon: Icons.insights, title: 'Progress', onTap: () => context.push('/progress')),
            _Tile(icon: Icons.privacy_tip_outlined, title: 'Privacy', subtitle: 'Local-first · No account'),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Reset all data', style: TextStyle(color: Colors.red)),
              onTap: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset data?'),
                    content: const Text('This removes all local wellness data. Cannot be undone.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reset')),
                    ],
                  ),
                );
                if (ok == true) {
                  await ref.read(settingsRepositoryProvider).resetAllData();
                  if (context.mounted) context.go('/onboarding/welcome');
                }
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Center(child: Text('CalmCalibrate v1.0.0', style: TextStyle(color: context.colors.textMuted, fontSize: 12))),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, this.subtitle, this.onTap});
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
