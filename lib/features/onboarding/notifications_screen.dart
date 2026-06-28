import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/services/notification_service.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCard(
                child: Row(
                  children: [
                    Icon(Icons.notifications_active_outlined, color: c.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Break reminders', style: TextStyle(fontWeight: FontWeight.w600)),
                          Text('Gentle nudges during work hours', style: TextStyle(color: c.textSecondary, fontSize: 13)),
                        ],
                      ),
                    ),
                    Switch(
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'CalmCalibrate sends local reminders only. No account required. You can change this anytime in Profile.',
                style: TextStyle(color: c.textSecondary, height: 1.5),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () async {
                  if (_enabled) await getIt<NotificationService>().requestPermission();
                  if (!context.mounted) return;
                  final goals = GoRouterState.of(context).extra;
                  context.push('/onboarding/reminder', extra: {
                    'goals': goals is List ? goals.cast<String>() : <String>[],
                    'notifications': _enabled,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
