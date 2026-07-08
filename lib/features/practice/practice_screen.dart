import 'dart:async';

import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/services/tts_service.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.affirmation});

  final String affirmation;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _breathController;
  late final TtsService _tts;
  Timer? _timer;
  int _secondsLeft = 60;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _tts = getIt<TtsService>();
    _breathController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breathController.dispose();
    _tts.stop();
    super.dispose();
  }

  void _togglePractice() {
    setState(() => _running = !_running);
    if (_running) {
      _tts.speak(widget.affirmation);
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (_secondsLeft <= 1) {
          t.cancel();
          setState(() {
            _running = false;
            _secondsLeft = 60;
          });
          _tts.stop();
        } else {
          setState(() => _secondsLeft--);
        }
      });
    } else {
      _timer?.cancel();
      _tts.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;
    final themeAsync = ref.watch(selectedThemeIdProvider);

    return themeAsync.when(
      data: (themeId) {
        final template = AffirmationTemplates.byId(themeId) ?? AffirmationTemplates.all.first;

        return CelestialScaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Theme color wash over sage backdrop
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      template.background.withValues(alpha: 0.55),
                      CelestialPalette.background(brightness).withValues(alpha: 0.9),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GlassPanel(
                          radius: AppRadius.pill,
                          padding: const EdgeInsets.all(4),
                          child: IconButton(
                            icon: Icon(Icons.close, color: c.textPrimary, size: 22),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                      const Spacer(),
                      AnimatedBuilder(
                        animation: _breathController,
                        builder: (context, child) {
                          final scale = 0.88 + (_breathController.value * 0.12);
                          final glow = 0.2 + (_breathController.value * 0.25);
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: c.buttonPrimary.withValues(alpha: glow),
                                border: Border.all(color: c.buttonPrimary, width: 2.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: c.buttonPrimary.withValues(alpha: glow),
                                    blurRadius: 32,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.self_improvement, color: c.onPrimary, size: 52),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      GlassPanel(
                        radius: AppRadius.xl,
                        glow: true,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
                        child: Text(
                          widget.affirmation,
                          textAlign: TextAlign.center,
                          style: CelestialTypography.displayAffirmation(
                            color: c.textPrimary,
                            brightness: brightness,
                          ).copyWith(fontSize: 26),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      GlassPanel(
                        radius: AppRadius.pill,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _running ? Icons.timer_outlined : Icons.touch_app_outlined,
                              size: 16,
                              color: CelestialPalette.tertiary(brightness),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _running
                                  ? 'Breathe with your affirmation · $_secondsLeft s'
                                  : 'Tap practice to begin · 60 s',
                              style: CelestialTypography.labelCaps(
                                color: c.textSecondary,
                                brightness: brightness,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      CelestialPrimaryButton(
                        label: _running ? 'Pause practice' : 'Start practice',
                        icon: _running ? Icons.pause_rounded : Icons.self_improvement_outlined,
                        onPressed: _togglePractice,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => CelestialScaffold(body: const Center(child: CircularProgressIndicator())),
      error: (_, __) => CelestialScaffold(
        body: Center(child: Text('Could not load theme', style: CelestialTypography.bodyMd())),
      ),
    );
  }
}
