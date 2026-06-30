import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AffirmationsScreen extends ConsumerStatefulWidget {
  const AffirmationsScreen({super.key});

  @override
  ConsumerState<AffirmationsScreen> createState() => _AffirmationsScreenState();
}

class _AffirmationsScreenState extends ConsumerState<AffirmationsScreen> {
  String _tab = 'all';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final affirmationsAsync = ref.watch(affirmationsStreamProvider(_tab));

    return KindledScreen(
      title: 'AFFIRMATIONS',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            FilterTabs(
              tabs: const ['all', 'favorites', 'manifest', 'abundance', 'love', 'calm', 'focus'],
              selected: _tab,
              onSelected: (v) => setState(() => _tab = v),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write a new affirmation…',
                      filled: true,
                      fillColor: c.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  onPressed: () async {
                    final text = _controller.text.trim();
                    if (text.isEmpty) return;
                    await ref.read(affirmationRepositoryProvider).addCustom(text, _tab == 'all' ? 'manifest' : _tab);
                    _controller.clear();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: affirmationsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        _tab == 'favorites' ? 'No favorites yet — tap ♥ on any affirmation' : 'No affirmations yet',
                        style: TextStyle(color: c.textMuted),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return Material(
                        color: c.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          side: BorderSide(color: c.border),
                        ),
                        child: ListTile(
                          title: Text(item.content, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(item.category),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(item.isFavorite ? Icons.favorite : Icons.favorite_border, color: c.primary),
                                onPressed: () => ref
                                    .read(affirmationRepositoryProvider)
                                    .toggleFavorite(item.id, !item.isFavorite),
                              ),
                              IconButton(
                                icon: const Icon(Icons.wallpaper_outlined),
                                onPressed: () {
                                  final template = AffirmationTemplates.forCategory(item.category) ??
                                      AffirmationTemplates.all.first;
                                  ref.read(editorDraftProvider.notifier).state =
                                      AffirmationDraft(text: item.content, template: template);
                                  context.push('/editor');
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
