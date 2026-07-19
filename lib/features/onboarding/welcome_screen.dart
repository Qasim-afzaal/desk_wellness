import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/app_logo.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    await ref.read(settingsRepositoryProvider).setDisplayName(name);
    if (mounted) context.go('/onboarding/goals');
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return CelestialScaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - AppSpacing.xl),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(),
                    const AffirmationLogo(size: 128).fadeSlideIn(),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Welcome to Affirmation',
                      textAlign: TextAlign.center,
                      style: CelestialTypography.headlineLg(brightness: brightness),
                    ).fadeSlideIn(delay: 120.ms),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'What should we call you?',
                      textAlign: TextAlign.center,
                      style: CelestialTypography.bodyMd(brightness: brightness),
                    ).fadeSlideIn(delay: 180.ms),
                    const SizedBox(height: AppSpacing.lg),
                    TextField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _continue(),
                      decoration: const InputDecoration(
                        labelText: 'Your name',
                        hintText: 'Enter your name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ).fadeSlideIn(delay: 240.ms),
                    const Spacer(),
                    CelestialPrimaryButton(
                      label: 'Continue',
                      icon: Icons.arrow_forward,
                      onPressed: _nameController.text.trim().isEmpty ? null : _continue,
                    ).fadeSlideIn(delay: 320.ms),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
