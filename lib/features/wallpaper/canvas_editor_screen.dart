import 'dart:io';

import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/models/canvas_document.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Stitch edit_set_wallpaper_celestial — full canvas editor with text, fonts, shapes, icons.
class CanvasEditorScreen extends ConsumerStatefulWidget {
  const CanvasEditorScreen({super.key});

  @override
  ConsumerState<CanvasEditorScreen> createState() => _CanvasEditorScreenState();
}

class _CanvasEditorScreenState extends ConsumerState<CanvasEditorScreen> {
  final _canvasKey = GlobalKey();
  late final TextEditingController _textController;
  String _toolTab = 'text';
  String? _selectedLayerId;

  static const _categories = ['Inner Peace', 'Gratitude', 'Abundance', 'Focus', 'Healing'];
  static const _fonts = [
    ('playfair', 'Playfair'),
    ('nunito', 'Nunito'),
    ('inter', 'Inter'),
    ('oswald', 'Bold'),
    ('spirit', 'Spirit'),
  ];
  static const _shapes = ['circle', 'square', 'line'];
  static const _icons = [
    Icons.auto_awesome,
    Icons.spa_outlined,
    Icons.favorite_border,
    Icons.wb_sunny_outlined,
    Icons.nightlight_round,
    Icons.water_drop_outlined,
  ];

  @override
  void initState() {
    super.initState();
    final doc = ref.read(canvasDocumentProvider);
    _textController = TextEditingController(text: doc?.affirmationText ?? 'I am enough.');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _syncTextController(String text) {
    if (_textController.text != text) {
      _textController.value = _textController.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  CanvasDocument get _doc => ref.watch(canvasDocumentProvider) ?? const CanvasDocument(affirmationText: '');

  void _update(CanvasDocument doc) => ref.read(canvasDocumentProvider.notifier).state = doc;

  TextStyle _fontFor(String style, {double size = 32, Color color = Colors.white, bool italic = true, bool bold = false}) {
    return switch (style) {
      'nunito' => GoogleFonts.nunitoSans(fontSize: size, fontWeight: bold ? FontWeight.w800 : FontWeight.w600, color: color, fontStyle: italic ? FontStyle.italic : FontStyle.normal),
      'inter' => GoogleFonts.inter(fontSize: size, fontWeight: bold ? FontWeight.w700 : FontWeight.w500, color: color),
      'oswald' => GoogleFonts.oswald(fontSize: size, fontWeight: FontWeight.w700, color: color),
      'spirit' => GoogleFonts.cormorantGaramond(fontSize: size, fontWeight: FontWeight.w600, color: color, fontStyle: FontStyle.italic),
      _ => GoogleFonts.playfairDisplay(fontSize: size, fontWeight: bold ? FontWeight.w800 : FontWeight.w700, color: color, fontStyle: italic ? FontStyle.italic : FontStyle.normal, height: 1.35),
    };
  }

  void _exportToWallpaper() {
    final template = AffirmationTemplates.all.first;
    ref.read(editorDraftProvider.notifier).state = AffirmationDraft(
      text: _doc.affirmationText,
      template: template,
      fontStyle: _doc.fontStyle,
      backgroundOverride: CelestialColors.primaryContainer,
      backgroundImagePath: _doc.backgroundImagePath,
    );
    context.push('/wallpaper/preview');
  }

  @override
  Widget build(BuildContext context) {
    final doc = _doc;
    _syncTextController(doc.affirmationText);

    return Scaffold(
      backgroundColor: CelestialColors.background,
      extendBodyBehindAppBar: true,
      appBar: CelestialAppBar(
        title: 'I am',
        showBack: true,
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: _exportToWallpaper),
          IconButton(icon: const Icon(Icons.check_circle_outline), onPressed: _exportToWallpaper),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 80, AppSpacing.lg, 0),
                child: RepaintBoundary(
                  key: _canvasKey,
                  child: _CanvasPreview(
                    doc: doc,
                    fontBuilder: _fontFor,
                    selectedLayerId: _selectedLayerId,
                    onLayerTap: (id) => setState(() => _selectedLayerId = id),
                    onLayerDrag: (id, delta) {
                      final layer = doc.layers.firstWhere((l) => l.id == id);
                      _update(doc.updateLayer(id, layer.copyWith(offset: layer.offset + delta)));
                    },
                    onAffirmationTap: () => setState(() {
                      _selectedLayerId = null;
                      _toolTab = 'text';
                    }),
                  ),
                ),
              ),
            ),
          ),
          _EditorToolbar(
            doc: doc,
            toolTab: _toolTab,
            textController: _textController,
            categories: _categories,
            fonts: _fonts,
            shapes: _shapes,
            icons: _icons,
            onTab: (t) => setState(() => _toolTab = t),
            onCategory: (c) => _update(doc.copyWith(category: c)),
            onTextChanged: (t) => _update(doc.copyWith(affirmationText: t)),
            onFont: (f) => _update(doc.copyWith(fontStyle: f)),
            onAlign: (a) => _update(doc.copyWith(textAlign: a)),
            onAddShape: (s) {
              final layer = CanvasLayer.shapeLayer(s);
              _update(doc.addLayer(layer));
              setState(() => _selectedLayerId = layer.id);
            },
            onAddIcon: (i) {
              final layer = CanvasLayer.iconLayer(i);
              _update(doc.addLayer(layer));
              setState(() => _selectedLayerId = layer.id);
            },
            onAddText: () {
              final layer = CanvasLayer.textLayer(text: 'New text', fontStyle: doc.fontStyle);
              _update(doc.addLayer(layer));
              setState(() => _selectedLayerId = layer.id);
            },
            onSearchWallpaper: () => context.push('/wallpaper/search', extra: doc.affirmationText),
            onDone: _exportToWallpaper,
          ),
        ],
      ),
    );
  }
}

class _CanvasPreview extends StatelessWidget {
  const _CanvasPreview({
    required this.doc,
    required this.fontBuilder,
    this.selectedLayerId,
    required this.onLayerTap,
    required this.onLayerDrag,
    required this.onAffirmationTap,
  });

  final CanvasDocument doc;
  final TextStyle Function(String style, {double size, Color color, bool italic, bool bold}) fontBuilder;
  final String? selectedLayerId;
  final ValueChanged<String> onLayerTap;
  final void Function(String id, Offset delta) onLayerDrag;
  final VoidCallback onAffirmationTap;

  @override
  Widget build(BuildContext context) {
    final bgFile = doc.backgroundImagePath != null ? File(doc.backgroundImagePath!) : null;

    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (bgFile != null && bgFile.existsSync())
              Image.file(bgFile, fit: BoxFit.cover)
            else if (doc.backgroundImageUrl != null)
              Image.network(doc.backgroundImageUrl!, fit: BoxFit.cover)
            else
              const DecoratedBox(decoration: BoxDecoration(gradient: CelestialGradients.primary)),
            // Light scrim — not heavy blur
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: doc.overlayOpacity * 0.35),
                    Colors.black.withValues(alpha: doc.overlayOpacity),
                    Colors.black.withValues(alpha: doc.overlayOpacity * 0.5),
                  ],
                ),
              ),
            ),
            // Main affirmation — tap to edit text, no frosted glass
            Center(
              child: GestureDetector(
                onTap: onAffirmationTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: CelestialColors.primary.withValues(alpha: 0.9), size: 32),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        doc.affirmationText,
                        textAlign: doc.textAlign,
                        style: fontBuilder(doc.fontStyle, size: 28, color: doc.textColor, italic: true).copyWith(
                          shadows: const [
                            Shadow(blurRadius: 12, color: Colors.black54, offset: Offset(0, 2)),
                            Shadow(blurRadius: 24, color: Colors.black38, offset: Offset(0, 4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Stickers / shapes / extra text on top
            ...doc.layers.map(
              (layer) => _LayerWidget(
                layer: layer,
                selected: layer.id == selectedLayerId,
                fontBuilder: fontBuilder,
                onTap: () => onLayerTap(layer.id),
                onDrag: (d) => onLayerDrag(layer.id, d),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LayerWidget extends StatelessWidget {
  const _LayerWidget({
    required this.layer,
    required this.selected,
    required this.fontBuilder,
    required this.onTap,
    required this.onDrag,
  });

  final CanvasLayer layer;
  final bool selected;
  final TextStyle Function(String style, {double size, Color color, bool italic, bool bold}) fontBuilder;
  final VoidCallback onTap;
  final ValueChanged<Offset> onDrag;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        layer.offset.dx.clamp(-0.85, 0.85),
        layer.offset.dy.clamp(-0.85, 0.85),
      ),
      child: GestureDetector(
        onTap: onTap,
        onPanUpdate: (d) => onDrag(d.delta / 120),
        child: Transform.scale(
          scale: layer.scale,
          child: Container(
            decoration: selected
                ? BoxDecoration(
                    border: Border.all(color: CelestialColors.tertiary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            padding: const EdgeInsets.all(6),
            child: switch (layer.type) {
              CanvasLayerType.text => Text(
                  layer.text ?? '',
                  style: fontBuilder(
                    layer.fontStyle,
                    size: layer.fontSize,
                    color: layer.color,
                    italic: layer.italic,
                    bold: layer.bold,
                  ),
                ),
              CanvasLayerType.icon => Icon(layer.icon, color: layer.color, size: 40),
              CanvasLayerType.shape => _ShapePreview(shape: layer.shape, color: layer.color),
            },
          ),
        ),
      ),
    );
  }
}

class _ShapePreview extends StatelessWidget {
  const _ShapePreview({required this.shape, required this.color});

  final String shape;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return switch (shape) {
      'square' => Container(width: 48, height: 48, color: color.withValues(alpha: 0.5)),
      'line' => Container(width: 80, height: 3, color: color),
      _ => Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withValues(alpha: 0.5), shape: BoxShape.circle)),
    };
  }
}

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar({
    required this.doc,
    required this.toolTab,
    required this.textController,
    required this.categories,
    required this.fonts,
    required this.shapes,
    required this.icons,
    required this.onTab,
    required this.onCategory,
    required this.onTextChanged,
    required this.onFont,
    required this.onAlign,
    required this.onAddShape,
    required this.onAddIcon,
    required this.onAddText,
    required this.onSearchWallpaper,
    required this.onDone,
  });

  final CanvasDocument doc;
  final String toolTab;
  final TextEditingController textController;
  final List<String> categories;
  final List<(String, String)> fonts;
  final List<String> shapes;
  final List<IconData> icons;
  final ValueChanged<String> onTab;
  final ValueChanged<String> onCategory;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onFont;
  final ValueChanged<TextAlign> onAlign;
  final ValueChanged<String> onAddShape;
  final ValueChanged<IconData> onAddIcon;
  final VoidCallback onAddText;
  final VoidCallback onSearchWallpaper;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: AppRadius.xl,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((c) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: CelestialPillChip(
                      label: c,
                      selected: doc.category == c,
                      onTap: () => onCategory(c),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _ToolTab(label: 'Text', icon: Icons.text_fields, active: toolTab == 'text', onTap: () => onTab('text')),
                _ToolTab(label: 'Fonts', icon: Icons.font_download_outlined, active: toolTab == 'fonts', onTap: () => onTab('fonts')),
                _ToolTab(label: 'Shapes', icon: Icons.crop_square_outlined, active: toolTab == 'shapes', onTap: () => onTab('shapes')),
                _ToolTab(label: 'Icons', icon: Icons.emoji_emotions_outlined, active: toolTab == 'icons', onTap: () => onTab('icons')),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (toolTab == 'text') ...[
              TextField(
                controller: textController,
                onChanged: onTextChanged,
                style: CelestialTypography.bodyMd(color: CelestialColors.onSurface),
                decoration: InputDecoration(
                  hintText: 'Edit affirmation…',
                  hintStyle: CelestialTypography.bodyMd(),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.06),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  IconButton(onPressed: () => onAlign(TextAlign.left), icon: const Icon(Icons.format_align_left)),
                  IconButton(onPressed: () => onAlign(TextAlign.center), icon: const Icon(Icons.format_align_center)),
                  IconButton(onPressed: () => onAlign(TextAlign.right), icon: const Icon(Icons.format_align_right)),
                  const Spacer(),
                  TextButton(onPressed: onAddText, child: const Text('+ Layer')),
                ],
              ),
            ],
            if (toolTab == 'fonts') ...[
              Text(
                'Tap a font to style the main affirmation',
                style: CelestialTypography.labelCaps(color: CelestialColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.sm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: fonts.map((f) {
                    final (id, label) = f;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: CelestialPillChip(label: label, selected: doc.fontStyle == id, onTap: () => onFont(id)),
                    );
                  }).toList(),
                ),
              ),
            ],
            if (toolTab == 'shapes') ...[
              Text(
                'Tap a shape to add it — drag on preview to move',
                style: CelestialTypography.labelCaps(color: CelestialColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.sm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: shapes.map((s) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: OutlinedButton(onPressed: () => onAddShape(s), child: Text(s)),
                    );
                  }).toList(),
                ),
              ),
            ],
            if (toolTab == 'icons') ...[
              Text(
                'Tap an icon to add it — drag on preview to move',
                style: CelestialTypography.labelCaps(color: CelestialColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.sm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: icons.map((i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: IconButton(
                        onPressed: () => onAddIcon(i),
                        icon: Icon(i, color: CelestialColors.primary),
                        style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.08)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onSearchWallpaper,
                    icon: const Icon(Icons.image_search),
                    label: const Text('Search wallpaper'),
                    style: OutlinedButton.styleFrom(foregroundColor: CelestialColors.onSurface),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: CelestialPrimaryButton(label: 'Set wallpaper', onPressed: onDone, expanded: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolTab extends StatelessWidget {
  const _ToolTab({required this.label, required this.icon, required this.active, required this.onTap});

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: active ? CelestialColors.primary.withValues(alpha: 0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Icon(icon, color: active ? CelestialColors.primary : CelestialColors.onSurfaceVariant, size: 22),
                const SizedBox(height: 4),
                Text(label, style: CelestialTypography.labelCaps(color: active ? CelestialColors.primary : null)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
