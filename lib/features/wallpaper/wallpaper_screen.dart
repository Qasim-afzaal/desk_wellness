import 'dart:io';

import 'dart:ui' as ui;

import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:desk_wellness/core/utils/share_utils.dart';

class WallpaperPreviewScreen extends ConsumerWidget {
  const WallpaperPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(editorDraftProvider);
    if (draft == null) {
      return const Scaffold(body: Center(child: Text('No draft to preview')));
    }

    return CelestialScaffold(
      appBar: const CelestialAppBar(title: 'Set Wallpaper', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: FloatingPhoneFrame(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (draft.backgroundImagePath != null && File(draft.backgroundImagePath!).existsSync())
                        Image.file(File(draft.backgroundImagePath!), fit: BoxFit.cover)
                      else if (draft.backgroundImageUrl != null && draft.backgroundImageUrl!.isNotEmpty)
                        Image.network(draft.backgroundImageUrl!, fit: BoxFit.cover)
                      else
                        Container(color: draft.background),
                      Container(color: Colors.black.withValues(alpha: 0.35)),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          children: [
                            Text('9:41', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 18)),
                            const Spacer(),
                            Text(
                              draft.text,
                              textAlign: TextAlign.center,
                              style: CelestialTypography.displayAffirmation(),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => shareAffirmation(context, draft.text),
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: CelestialPrimaryButton(
                    label: 'Save',
                    icon: Icons.save_outlined,
                    onPressed: () => context.push('/export'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  final _captureKey = GlobalKey();
  bool _showSuccess = false;

  Future<void> _saveToPhotos() async {
    final draft = ref.read(editorDraftProvider);
    if (draft == null) return;

    final boundary = _captureKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;

    final image = await boundary.toImage(pixelRatio: 3);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) return;

    try {
      await Gal.putImageBytes(bytes.buffer.asUint8List());
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save to photos — check permissions')),
        );
      }
      return;
    }

    await ref.read(creationRepositoryProvider).save(
          content: draft.text,
          templateId: draft.template.id,
          background: draft.background,
          accent: draft.template.accent,
          fontStyle: draft.fontStyle,
          textAlign: draft.textAlign,
          exportType: draft.exportType,
        );

    if (mounted) setState(() => _showSuccess = true);
  }

  void _onSuccessFinished() {
    if (!mounted) return;
    setState(() => _showSuccess = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to photos and library')),
    );
    context.go('/saved');
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(editorDraftProvider);
    if (draft == null) {
      return const Scaffold(body: Center(child: Text('No draft to export')));
    }

    return Stack(
      children: [
        KindledScreen(
          title: 'EXPORT',
          showBack: true,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: draft.exportType == 'story' ? 9 / 16 : 9 / 19.5,
                      child: RepaintBoundary(
                        key: _captureKey,
                        child: AffirmationCardFromDraft(draft: draft),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Wallpaper'),
                        selected: draft.exportType == 'wallpaper',
                        onSelected: (_) => ref.read(editorDraftProvider.notifier).state =
                            draft.copyWith(exportType: 'wallpaper'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Story'),
                        selected: draft.exportType == 'story',
                        onSelected: (_) => ref.read(editorDraftProvider.notifier).state =
                            draft.copyWith(exportType: 'story'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                KindledPrimaryButton(
                  label: 'Save to photos',
                  icon: Icons.download_outlined,
                  onPressed: _saveToPhotos,
                ),
              ],
            ),
          ),
        ),
        if (_showSuccess) SuccessBurstOverlay(onFinished: _onSuccessFinished),
      ],
    );
  }
}
