import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const Spacer(flex: 2),
                KindledLottie(asset: KindledAssets.sunrise, width: 200, height: 200).fadeSlideIn(),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Affirmly',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                ).fadeSlideIn(delay: 120.ms),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Daily affirmations to rewire your mind.\nBuild self-esteem. Change negative thought patterns.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: c.textSecondary, fontSize: 16, height: 1.5),
                ).fadeSlideIn(delay: 220.ms),
                const Spacer(flex: 3),
                KindledPrimaryButton(
                  label: 'Get started',
                  onPressed: () => context.go('/onboarding/goals'),
                ).fadeSlideIn(delay: 320.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
