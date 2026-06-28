import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  int? _categoryId;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final categories = ref.watch(exerciseRepositoryProvider).watchCategories();
    final exercises = ref.watch(exerciseRepositoryProvider).watchExercises(categoryId: _categoryId);

    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 48,
            child: StreamBuilder<List<ExerciseCategory>>(
              stream: categories,
              builder: (context, snap) {
                final cats = snap.data ?? [];
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('All'),
                        selected: _categoryId == null,
                        onSelected: (_) => setState(() => _categoryId = null),
                      ),
                    ),
                    ...cats.map((cat) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(cat.name),
                            selected: _categoryId == cat.id,
                            onSelected: (_) => setState(() => _categoryId = cat.id),
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Exercise>>(
              stream: exercises,
              builder: (context, snap) {
                final list = snap.data ?? [];
                if (list.isEmpty) {
                  return const EmptyState(icon: Icons.fitness_center, title: 'No exercises yet', subtitle: 'Seed data loads on first launch.');
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    final ex = list[i];
                    return AppCard(
                      onTap: () => context.push('/exercise/${ex.id}'),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(color: c.primarySoft, borderRadius: BorderRadius.circular(AppRadius.sm)),
                            child: Icon(Icons.play_circle_outline, color: c.primary),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ex.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text('${ex.durationSeconds}s · ${ex.difficulty}', style: TextStyle(color: c.textSecondary, fontSize: 13)),
                              ],
                            ),
                          ),
                          if (ex.isFavorite) Icon(Icons.favorite, size: 18, color: c.primary),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
