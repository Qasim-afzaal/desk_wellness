import 'dart:async';

import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.affirmation});

  final String affirmation;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _breathController;
  Timer? _timer;
  int _secondsLeft = 60;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breathController.dispose();
    ref.read(ttsServiceProvider).stop();
    super.dispose();
  }

  void _togglePractice() {
    setState(() => _running = !_running);
    if (_running) {
      ref.read(ttsServiceProvider).speak(widget.affirmation);
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (_secondsLeft <= 1) {
          t.cancel();
          setState(() {
            _running = false;
            _secondsLeft = 60;
          });
          ref.read(ttsServiceProvider).stop();
        } else {
          setState(() => _secondsLeft--);
        }
      });
    } else {
      _timer?.cancel();
      ref.read(ttsServiceProvider).stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final themeAsync = ref.watch(selectedThemeIdProvider);

    return themeAsync.when(
      data: (themeId) {
        final template = AffirmationTemplates.byId(themeId) ?? AffirmationTemplates.all.first;
        final onDark = template.background.computeLuminance() < 0.45;
        final textColor = onDark ? Colors.white : c.textPrimary;

        return Scaffold(
          backgroundColor: template.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, color: textColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: _breathController,
                    builder: (context, child) {
                      final scale = 0.85 + (_breathController.value * 0.15);
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: template.accent.withValues(alpha: 0.35),
                            border: Border.all(color: template.accent, width: 2),
                          ),
                          child: Icon(Icons.self_improvement, color: textColor, size: 48),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    widget.affirmation,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    _running ? 'Breathe with your affirmation · $_secondsLeft s' : 'Tap practice to begin',
                    style: TextStyle(color: textColor.withValues(alpha: 0.75)),
                  ),
                  const Spacer(),
                  KindledPrimaryButton(
                    label: _running ? 'Pause practice' : 'Practice',
                    icon: Icons.self_improvement_outlined,
                    onPressed: _togglePractice,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Scaffold(body: Center(child: Text('Could not load theme'))),
    );
  }
}
