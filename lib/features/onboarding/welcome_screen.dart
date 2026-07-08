import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    return CelestialScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(flex: 2),
              KindledLottie(asset: KindledAssets.sunrise, width: 200, height: 200).fadeSlideIn(),
              const SizedBox(height: AppSpacing.lg),
              Text('Affirmly', style: CelestialTypography.headlineLg(brightness: brightness)).fadeSlideIn(delay: 120.ms),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Your calm space for daily affirmations.\nGrow with intention. Live with peace.',
                textAlign: TextAlign.center,
                style: CelestialTypography.bodyMd(brightness: brightness),
              ).fadeSlideIn(delay: 220.ms),
              const Spacer(flex: 3),
              CelestialPrimaryButton(
                label: 'Begin your journey',
                icon: Icons.auto_awesome,
                onPressed: () => context.go('/onboarding/goals'),
              ).fadeSlideIn(delay: 320.ms),
            ],
          ),
        ),
      ),
    );
  }
}
