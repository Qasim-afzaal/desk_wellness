import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final _selected = <String>{};

  static const _goals = [
    'Reduce neck pain',
    'Fix posture',
    'Lower stress',
    'Stay focused',
    'Build habits',
    'Sleep better',
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(title: const Text('Your goals')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What do you want to improve?', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text('Pick at least one. We will personalize your experience.', style: TextStyle(color: c.textSecondary)),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _goals.map((g) {
                    final on = _selected.contains(g);
                    return FilterChip(
                      label: Text(g),
                      selected: on,
                      onSelected: (v) => setState(() => v ? _selected.add(g) : _selected.remove(g)),
                    );
                  }).toList(),
                ),
              ),
              PrimaryButton(
                label: 'Continue',
                onPressed: _selected.isEmpty ? null : () => context.push('/onboarding/notifications', extra: _selected.toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
