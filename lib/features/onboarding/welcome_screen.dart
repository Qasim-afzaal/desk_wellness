import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(color: c.primarySoft, borderRadius: BorderRadius.circular(AppRadius.lg)),
                child: Icon(Icons.self_improvement, size: 48, color: c.primary),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('CalmCalibrate', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Premium wellness for desk workers. Posture, focus, breathing, and calm — fully offline on your device.',
                style: TextStyle(color: c.textSecondary, fontSize: 16, height: 1.5),
              ),
              const Spacer(),
              PrimaryButton(label: 'Get started', onPressed: () => context.push('/onboarding/goals')),
            ],
          ),
        ),
      ),
    );
  }
}
