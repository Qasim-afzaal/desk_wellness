import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/repositories/creation_repository.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedLibraryScreen extends ConsumerStatefulWidget {
  const SavedLibraryScreen({super.key});

  @override
  ConsumerState<SavedLibraryScreen> createState() => _SavedLibraryScreenState();
}

class _SavedLibraryScreenState extends ConsumerState<SavedLibraryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final savedAsync = ref.watch(savedCreationsProvider(_query));

    return KindledScreen(
      title: 'SAVED LIBRARY',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search affirmations',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: c.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  borderSide: BorderSide(color: c.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  borderSide: BorderSide(color: c.border),
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ).fadeSlideIn(),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: savedAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          KindledLottie(asset: KindledAssets.emptyLibrary, width: 160, height: 160),
                          const SizedBox(height: AppSpacing.md),
                          Text('No saved affirmations yet', style: TextStyle(color: c.textMuted)),
                          const SizedBox(height: AppSpacing.xs),
                          Text('Create a wallpaper to see it here', style: TextStyle(color: c.textMuted, fontSize: 13)),
                        ],
                      ).fadeSlideIn(),
                    );
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) {
                      final item = items[i];
                      final bg = CreationRepository.colorFromHex(item.backgroundHex);
                      return Material(
                        color: c.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          side: BorderSide(color: c.border),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
                          ),
                          title: Text(
                            item.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(_labelForType(item.exportType)),
                          trailing: Icon(
                            item.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: c.primary,
                          ),
                          onTap: () => ref
                              .read(creationRepositoryProvider)
                              .toggleBookmark(item.id, !item.isBookmarked),
                        ),
                      ).staggerIn(i);
                    },
                  );
                },
                loading: () => Center(child: KindledLottie(asset: KindledAssets.loadingDots, width: 100, height: 40)),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _labelForType(String type) {
    switch (type) {
      case 'story':
        return 'Story';
      case 'lock_screen':
        return 'Lock screen';
      default:
        return 'Wallpaper';
    }
  }
}
