import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desk_wellness/core/models/canvas_document.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/services/image_search_service.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WallpaperSearchScreen extends ConsumerStatefulWidget {
  const WallpaperSearchScreen({
    super.key,
    this.initialQuery,
    this.affirmationText,
    this.embeddedInShell = false,
  });

  final String? initialQuery;
  final String? affirmationText;
  final bool embeddedInShell;

  @override
  ConsumerState<WallpaperSearchScreen> createState() => _WallpaperSearchScreenState();
}

class _WallpaperSearchScreenState extends ConsumerState<WallpaperSearchScreen> {
  late final TextEditingController _searchController;
  String _query = '';
  bool _loading = false;
  List<WallpaperImageResult> _results = [];
  String? _error;

  static const _suggestions = [
    'forest morning mist',
    'ocean sunset calm',
    'golden mountains',
    'soft clouds pastel',
    'northern lights',
    'zen garden',
  ];

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery ?? 'nature calm wallpaper';
    _searchController = TextEditingController(text: _query);
    WidgetsBinding.instance.addPostFrameCallback((_) => _search());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final q = _searchController.text.trim();
    if (q.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
      _query = q;
    });
    try {
      final results = await ref.read(imageSearchServiceProvider).searchWallpapers(q, count: 12);
      if (!mounted) return;
      setState(() {
        _results = results;
        _loading = false;
        if (results.isEmpty) _error = 'No images found. Try another search.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Search failed. Check your connection.';
      });
    }
  }

  void _openEditor(WallpaperImageResult result) {
    final text = widget.affirmationText ?? 'I am the architect of my own peace.';
    ref.read(canvasDocumentProvider.notifier).state = CanvasDocument(
      affirmationText: text,
      backgroundImagePath: result.localPath,
      backgroundImageUrl: result.sourceUrl,
    );
    context.push('/canvas/editor');
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;

    final scroll = CustomScrollView(
      slivers: [
        if (widget.embeddedInShell)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visual Breath',
                    style: CelestialTypography.headlineLg(brightness: brightness).copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SEARCH WALLPAPERS',
                    style: CelestialTypography.labelCaps(
                      color: CelestialPalette.tertiary(brightness),
                      brightness: brightness,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CelestialGlassSearchBar(
                  controller: _searchController,
                  hint: 'Mountains, ocean, flowers…',
                  onSubmitted: (_) => _search(),
                  onSearch: _search,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Popular searches', style: CelestialTypography.labelCaps(brightness: brightness)),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _suggestions.map((s) {
                    return CelestialPillChip(
                      label: s,
                      selected: _query.toLowerCase() == s.toLowerCase(),
                      onTap: () {
                        _searchController.text = s;
                        _search();
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        if (_loading)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: c.buttonPrimary),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Finding wallpapers…',
                    style: CelestialTypography.bodyMd(color: c.textMuted, brightness: brightness),
                  ),
                ],
              ),
            ),
          )
        else if (_error != null)
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported_outlined, size: 48, color: c.textMuted),
                  const SizedBox(height: AppSpacing.md),
                  Text(_error!, textAlign: TextAlign.center, style: CelestialTypography.bodyMd(brightness: brightness)),
                  const SizedBox(height: AppSpacing.lg),
                  CelestialPrimaryButton(label: 'Try again', expanded: false, onPressed: _search),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xxl),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.62,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _results[index];
                  return _WallpaperTile(result: item, onTap: () => _openEditor(item));
                },
                childCount: _results.length,
              ),
            ),
          ),
      ],
    );

    final body = SafeArea(child: scroll);

    if (widget.embeddedInShell) {
      return CelestialScaffold(body: body);
    }

    return CelestialScaffold(
      appBar: CelestialAppBar(title: 'Visual Breath', subtitle: 'SEARCH WALLPAPERS', showBack: true),
      body: body,
    );
  }
}

class _WallpaperTile extends StatelessWidget {
  const _WallpaperTile({required this.result, required this.onTap});

  final WallpaperImageResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final file = File(result.localPath);
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (file.existsSync())
              Image.file(file, fit: BoxFit.cover)
            else
              CachedNetworkImage(imageUrl: result.sourceUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Icon(Icons.brush_outlined, color: CelestialPalette.tertiary(brightness), size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Edit on canvas',
                      style: CelestialTypography.labelCaps(color: Colors.white, brightness: brightness),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
