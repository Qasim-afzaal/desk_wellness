import 'package:desk_wellness/core/constants/affirmation_categories.dart';
import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final favoritesAsync = ref.watch(favoritesStreamProvider);

    return KindledScreen(
      title: 'Favorites',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: favoritesAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    KindledLottie(asset: KindledAssets.emptyLibrary, width: 160, height: 160),
                    const SizedBox(height: AppSpacing.md),
                    Text('No favorites yet', style: TextStyle(color: c.textMuted, fontSize: 16)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Tap the heart on any affirmation to save it here',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: c.textMuted, fontSize: 13),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    KindledPrimaryButton(
                      label: 'Browse affirmations',
                      onPressed: () => context.go('/today'),
                    ),
                  ],
                ).fadeSlideIn(),
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    title: Text(
                      item.content,
                      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.35),
                    ),
                    subtitle: Text(AffirmationCategories.label(item.category)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite, color: c.primary),
                          onPressed: () => ref
                              .read(affirmationRepositoryProvider)
                              .toggleFavorite(item.id, false),
                        ),
                        IconButton(
                          icon: const Icon(Icons.wallpaper_outlined),
                          onPressed: () {
                            final template = AffirmationTemplates.forCategory(item.category) ??
                                AffirmationTemplates.all.first;
                            ref.read(editorDraftProvider.notifier).state =
                                AffirmationDraft(text: item.content, template: template);
                            context.push('/wallpaper/preview');
                          },
                        ),
                      ],
                    ),
                  ),
                ).staggerIn(i);
              },
            );
          },
          loading: () => Center(child: KindledLottie(asset: KindledAssets.loadingDots, width: 100, height: 40)),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
