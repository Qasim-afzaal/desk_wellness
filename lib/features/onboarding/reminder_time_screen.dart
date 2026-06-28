import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/services/notification_service.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/repositories/reminder_repository.dart';
import 'package:desk_wellness/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReminderTimeScreen extends StatefulWidget {
  const ReminderTimeScreen({super.key});

  @override
  State<ReminderTimeScreen> createState() => _ReminderTimeScreenState();
}

class _ReminderTimeScreenState extends State<ReminderTimeScreen> {
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    List<String> goals = [];
    var notifications = true;
    if (extra is Map) {
      goals = (extra['goals'] as List?)?.cast<String>() ?? [];
      notifications = extra['notifications'] as bool? ?? true;
    } else if (extra is List) {
      goals = extra.cast<String>();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reminder time')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('When should we remind you?', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                onTap: () async {
                  final picked = await showTimePicker(context: context, initialTime: _time);
                  if (picked != null) setState(() => _time = picked);
                },
                child: Row(
                  children: [
                    const Icon(Icons.schedule),
                    const SizedBox(width: AppSpacing.md),
                    Text(_time.format(context), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Start CalmCalibrate',
                onPressed: () async {
                  final timeStr = '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
                  await getIt<SettingsRepository>().completeOnboarding(
                    goals: goals,
                    reminderTime: timeStr,
                    notificationsEnabled: notifications,
                  );
                  if (notifications) {
                    await getIt<ReminderRepository>().addDefaultBreakReminder(timeStr);
                    final parts = timeStr.split(':');
                    await getIt<NotificationService>().scheduleDaily(
                      id: 1,
                      hour: int.parse(parts[0]),
                      minute: int.parse(parts[1]),
                      title: 'Time for a desk break',
                      body: 'A 90-second stretch can reset your focus.',
                    );
                  }
                  if (context.mounted) context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
