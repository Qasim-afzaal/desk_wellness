import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/services/notification_service.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingRemindersScreen extends ConsumerWidget {
  const OnboardingRemindersScreen({super.key, required this.goalIds});

  final List<String> goalIds;

  Future<void> _finish(BuildContext context, WidgetRef ref, {required bool enableReminders}) async {
    if (enableReminders) {
      await getIt<NotificationService>().requestPermission();
      await ref.read(reminderRepositoryProvider).setAllEnabled(true);
    } else {
      await ref.read(reminderRepositoryProvider).setAllEnabled(false);
    }
    await ref.read(reminderRepositoryProvider).syncScheduledNotifications();
    await ref.read(settingsRepositoryProvider).completeOnboarding(goals: goalIds);
    if (context.mounted) context.go('/today');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return KindledScreen(
      title: 'Reminders',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stay consistent',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Get affirmations throughout your day — morning, midday, and evening.',
              style: TextStyle(color: c.textMuted, height: 1.4),
            ),
            const SizedBox(height: AppSpacing.xl),
            _ReminderRow(icon: Icons.wb_sunny_outlined, title: 'Morning boost', time: '8:30 AM'),
            const SizedBox(height: AppSpacing.sm),
            _ReminderRow(icon: Icons.lightbulb_outline, title: 'Midday affirmation', time: '12:30 PM'),
            const SizedBox(height: AppSpacing.sm),
            _ReminderRow(icon: Icons.nightlight_outlined, title: 'Evening reflection', time: '8:00 PM'),
            const Spacer(),
            KindledPrimaryButton(
              label: 'Enable reminders',
              icon: Icons.notifications_active_outlined,
              onPressed: () => _finish(context, ref, enableReminders: true),
            ),
            const SizedBox(height: AppSpacing.sm),
            KindledSecondaryButton(
              label: 'Maybe later',
              onPressed: () => _finish(context, ref, enableReminders: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({required this.icon, required this.title, required this.time});

  final IconData icon;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: c.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(time, style: TextStyle(color: c.textMuted)),
        ],
      ),
    );
  }
}
