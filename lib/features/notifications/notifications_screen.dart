import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final remindersAsync = ref.watch(remindersStreamProvider);

    return KindledScreen(
      title: 'NOTIFICATIONS',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: remindersAsync.when(
          data: (reminders) {
            final dailyOn = reminders.any((r) => r.enabled);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: c.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: c.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Daily notification', style: TextStyle(fontWeight: FontWeight.w700)),
                            Text('Morning boost · 8:30 AM', style: TextStyle(color: c.textMuted, fontSize: 13)),
                          ],
                        ),
                      ),
                      Switch(
                        value: dailyOn,
                        onChanged: (v) => ref.read(reminderRepositoryProvider).setAllEnabled(v),
                        activeThumbColor: c.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Schedule', style: TextStyle(color: c.textSecondary, fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: ListView.separated(
                    itemCount: reminders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) {
                      final reminder = reminders[i];
                      return Material(
                        color: c.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          side: BorderSide(color: c.border),
                        ),
                        child: ListTile(
                          title: Text(reminder.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(reminder.timeOfDay),
                          trailing: Switch(
                            value: reminder.enabled,
                            onChanged: (v) => ref.read(reminderRepositoryProvider).toggle(reminder.id, v),
                          ),
                          onTap: () => context.push('/notifications/${reminder.id}'),
                        ),
                      );
                    },
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

class ReminderDetailScreen extends ConsumerStatefulWidget {
  const ReminderDetailScreen({super.key, required this.reminderId});

  final int reminderId;

  @override
  ConsumerState<ReminderDetailScreen> createState() => _ReminderDetailScreenState();
}

class _ReminderDetailScreenState extends ConsumerState<ReminderDetailScreen> {
  TimeOfDay? _time;
  bool _everyDay = true;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final reminderAsync = ref.watch(reminderByIdProvider(widget.reminderId));
    final affirmationAsync = ref.watch(todayAffirmationProvider);

    return KindledScreen(
      title: 'REMINDER DETAIL',
      showBack: true,
      child: reminderAsync.when(
        data: (reminder) {
          if (reminder == null) return const Center(child: Text('Reminder not found'));
          _time ??= _parseTime(reminder.timeOfDay);
          final preview = affirmationAsync.valueOrNull?.content ?? 'My words can shape a kinder day.';

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSpacing.lg),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Time'),
                  subtitle: Text(_time?.format(context) ?? reminder.timeOfDay),
                  trailing: const Icon(Icons.schedule),
                  onTap: () async {
                    final picked = await showTimePicker(context: context, initialTime: _time!);
                    if (picked != null) setState(() => _time = picked);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Repeat'),
                  subtitle: Text(_everyDay ? 'Every day' : 'Weekdays'),
                  trailing: Switch(
                    value: _everyDay,
                    onChanged: (v) => setState(() => _everyDay = v),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Message preview', style: TextStyle(color: c.textSecondary, fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 120,
                  child: AffirmationCard(
                    text: preview,
                    background: c.cardForest,
                    accent: c.cardYellow,
                    compact: true,
                  ),
                ),
                const Spacer(),
                KindledPrimaryButton(
                  label: 'Save reminder',
                  onPressed: () async {
                    final t = _time!;
                    final formatted = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
                    await ref.read(reminderRepositoryProvider).updateReminder(
                          id: reminder.id,
                          timeOfDay: formatted,
                          daysOfWeek: _everyDay ? '1,2,3,4,5,6,7' : '1,2,3,4,5',
                          enabled: reminder.enabled,
                        );
                    if (context.mounted) context.pop();
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

  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
