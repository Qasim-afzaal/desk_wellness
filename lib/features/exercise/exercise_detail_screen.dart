import 'dart:async';

import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  const ExerciseDetailScreen({super.key, required this.id});
  final int id;

  @override
  ConsumerState<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  Exercise? _exercise;
  Timer? _timer;
  int _remaining = 0;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ex = await ref.read(exerciseRepositoryProvider).getById(widget.id);
    setState(() {
      _exercise = ex;
      _remaining = ex?.durationSeconds ?? 0;
    });
  }

  void _toggleTimer() {
    if (_exercise == null) return;
    if (_running) {
      _timer?.cancel();
      setState(() => _running = false);
      return;
    }
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      if (_remaining <= 1) {
        t.cancel();
        await ref.read(exerciseRepositoryProvider).recordCompletion(_exercise!.id, _exercise!.durationSeconds);
        await ref.read(progressRepositoryProvider).touchToday(exercises: 1);
        await ref.read(progressRepositoryProvider).unlockAchievement('first_break');
        if (mounted) {
          setState(() => _running = false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exercise complete!')));
        }
        await _load();
        setState(() => _remaining = _exercise!.durationSeconds);
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final ex = _exercise;
    if (ex == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text(ex.title)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (ex.animationAsset != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Image.asset(ex.animationAsset!, height: 220, fit: BoxFit.cover),
            ),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: Text('${_remaining}s', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, color: c.primary)),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: PrimaryButton(label: _running ? 'Pause' : 'Start', onPressed: _toggleTimer)),
              const SizedBox(width: AppSpacing.sm),
              IconButton.filledTonal(
                onPressed: () => ref.read(exerciseRepositoryProvider).toggleFavorite(ex.id, !ex.isFavorite).then((_) => _load()),
                icon: Icon(ex.isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(ex.description, style: TextStyle(color: c.textSecondary, height: 1.5)),
          const SizedBox(height: AppSpacing.md),
          const Text('Instructions', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          Text(ex.instructions, style: TextStyle(color: c.textSecondary, height: 1.5)),
          const SizedBox(height: AppSpacing.md),
          const Text('Benefits', style: TextStyle(fontWeight: FontWeight.w700)),
          Text(ex.benefits, style: TextStyle(color: c.textSecondary)),
        ],
      ),
    );
  }
}
