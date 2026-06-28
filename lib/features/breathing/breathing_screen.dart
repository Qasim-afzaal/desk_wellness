import 'dart:async';

import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BreathingScreen extends ConsumerStatefulWidget {
  const BreathingScreen({super.key});

  @override
  ConsumerState<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends ConsumerState<BreathingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _pattern = 'box';
  int _cycles = 0;
  bool _active = false;

  static const _patterns = {
    'box': (4, 4, 4, 4, 'Box Breathing'),
    '478': (4, 7, 8, 0, '4-7-8 Calm'),
    'focus': (4, 2, 4, 2, 'Focus'),
    'calm': (5, 0, 5, 0, 'Calm'),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    setState(() {
      _active = true;
      _cycles = 0;
    });
    _controller.repeat(reverse: true);
    for (var i = 0; i < 6 && _active; i++) {
      await Future<void>.delayed(const Duration(seconds: 16));
      if (mounted) setState(() => _cycles++);
    }
    _controller.stop();
    await ref.read(breathingRepositoryProvider).recordSession(_pattern, 96);
    await ref.read(progressRepositoryProvider).touchToday(breathing: 1);
    await ref.read(progressRepositoryProvider).unlockAchievement('breathe_calm');
    if (mounted) {
      setState(() => _active = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Breathing session complete')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final label = _patterns[_pattern]?.$5 ?? 'Breathe';

    return Scaffold(
      appBar: AppBar(title: const Text('Breathe')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              children: _patterns.keys.map((k) {
                return ChoiceChip(
                  label: Text(_patterns[k]!.$5),
                  selected: _pattern == k,
                  onSelected: _active ? null : (v) => setState(() => _pattern = k),
                );
              }).toList(),
            ),
            const Spacer(),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final scale = 0.6 + (_controller.value * 0.5);
                return Container(
                  width: 220 * scale,
                  height: 220 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [c.accentBlue.withValues(alpha: 0.8), c.primary.withValues(alpha: 0.4)]),
                    boxShadow: [BoxShadow(color: c.primary.withValues(alpha: 0.25), blurRadius: 40, spreadRadius: 4)],
                  ),
                  child: Center(child: Text(_active ? 'Breathe' : label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(_active ? 'Cycle $_cycles' : 'Follow the circle. Inhale as it grows.', style: TextStyle(color: c.textSecondary)),
            const Spacer(),
            PrimaryButton(label: _active ? 'Stop' : 'Start session', onPressed: _active ? () => setState(() => _active = false) : _start),
          ],
        ),
      ),
    );
  }
}
