import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AffirmationsScreen extends ConsumerStatefulWidget {
  const AffirmationsScreen({super.key});

  @override
  ConsumerState<AffirmationsScreen> createState() => _AffirmationsScreenState();
}

class _AffirmationsScreenState extends ConsumerState<AffirmationsScreen> {
  String _category = 'all';

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final stream = ref.watch(affirmationRepositoryProvider).watchAll(category: _category);
    const cats = ['all', 'focus', 'stress', 'confidence', 'health', 'motivation'];

    return Scaffold(
      appBar: AppBar(title: const Text('Affirmations')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAdd(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: cats.map((cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(cat == 'all' ? 'All' : cat[0].toUpperCase() + cat.substring(1)),
                      selected: _category == cat,
                      onSelected: (_) => setState(() => _category = cat),
                    ),
                  )).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Affirmation>>(
              stream: stream,
              builder: (context, snap) {
                final list = snap.data ?? [];
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final a = list[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a.content, style: const TextStyle(fontSize: 16, height: 1.5)),
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                Chip(label: Text(a.category), visualDensity: VisualDensity.compact),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(a.isFavorite ? Icons.favorite : Icons.favorite_border, color: c.primary),
                                  onPressed: () => ref.read(affirmationRepositoryProvider).toggleFavorite(a.id, !a.isFavorite),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Future<void> _showAdd(BuildContext context) async {
    final ctrl = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New affirmation'),
        content: TextField(controller: ctrl, maxLines: 3),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              if (ctrl.text.trim().isEmpty) return;
              await ref.read(affirmationRepositoryProvider).addCustom(ctrl.text.trim(), 'motivation');
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
