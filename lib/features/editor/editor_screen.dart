import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late final TextEditingController _controller;

  static const _backgrounds = [
    Color(0xFFF2D4D4),
    Color(0xFFD4E2D0),
    Color(0xFFF5E6A8),
    Color(0xFF3D5A45),
    Color(0xFFD8DCE8),
    Color(0xFFF5F0E8),
  ];

  @override
  void initState() {
    super.initState();
    final draft = ref.read(editorDraftProvider);
    _controller = TextEditingController(text: draft?.text ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateDraft(AffirmationDraft draft) {
    ref.read(editorDraftProvider.notifier).state = draft;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final draft = ref.watch(editorDraftProvider);
    if (draft == null) {
      return const Scaffold(body: Center(child: Text('Start from a template first')));
    }

    return KindledScreen(
      title: 'EDITOR',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Write', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)).fadeSlideIn(),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: SizedBox(
                height: 88,
                width: double.infinity,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: AffirmationCardFromDraft(
                    key: ValueKey('${draft.text}_${draft.background}'),
                    draft: draft,
                    compact: true,
                    showAccent: false,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                onChanged: (v) => _updateDraft(draft.copyWith(text: v)),
                decoration: InputDecoration(
                  hintText: 'Write your affirmation…',
                  filled: true,
                  fillColor: c.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    borderSide: BorderSide(color: c.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    borderSide: BorderSide(color: c.border),
                  ),
                ),
                style: const TextStyle(fontSize: 18, height: 1.4),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Background', style: TextStyle(color: c.textSecondary, fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _backgrounds.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (_, i) {
                  final color = _backgrounds[i];
                  final selected = draft.background == color;
                  return GestureDetector(
                    onTap: () => _updateDraft(draft.copyWith(backgroundOverride: color)),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: selected ? Border.all(color: c.primary, width: 3) : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            KindledPrimaryButton(
              label: 'Continue to style',
              onPressed: () {
                _updateDraft(draft.copyWith(text: _controller.text.trim().isEmpty ? draft.text : _controller.text));
                context.push('/editor/style');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StyleControlsScreen extends ConsumerWidget {
  const StyleControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final draft = ref.watch(editorDraftProvider);
    if (draft == null) return const Scaffold(body: Center(child: Text('No draft')));

    return KindledScreen(
      title: 'STYLE CONTROLS',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: AffirmationCardFromDraft(
                    key: ValueKey('${draft.fontStyle}_${draft.textAlign}_${draft.text}'),
                    draft: draft,
                    compact: true,
                  ),
                ),
              ),
            ).fadeSlideIn(),
            const SizedBox(height: AppSpacing.lg),
            Text('Font', style: TextStyle(color: c.textSecondary, fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _FontChip(label: 'Calm', value: 'calm', draft: draft, ref: ref),
                const SizedBox(width: AppSpacing.sm),
                _FontChip(label: 'Spirit', value: 'spirit', draft: draft, ref: ref),
                const SizedBox(width: AppSpacing.sm),
                _FontChip(label: 'Bold', value: 'bold', draft: draft, ref: ref),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Text position', style: TextStyle(color: c.textSecondary, fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _AlignChip(icon: Icons.vertical_align_top, value: 'top', draft: draft, ref: ref),
                const SizedBox(width: AppSpacing.sm),
                _AlignChip(icon: Icons.vertical_align_center, value: 'center', draft: draft, ref: ref),
                const SizedBox(width: AppSpacing.sm),
                _AlignChip(icon: Icons.vertical_align_bottom, value: 'bottom', draft: draft, ref: ref),
              ],
            ),
            const Spacer(),
            KindledPrimaryButton(
              label: 'Preview wallpaper',
              onPressed: () => context.push('/wallpaper/preview'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontChip extends StatelessWidget {
  const _FontChip({required this.label, required this.value, required this.draft, required this.ref});

  final String label;
  final String value;
  final AffirmationDraft draft;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final selected = draft.fontStyle == value;
    final c = context.colors;
    return Expanded(
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => ref.read(editorDraftProvider.notifier).state = draft.copyWith(fontStyle: value),
        selectedColor: c.primarySoft,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? c.primary : c.textSecondary,
        ),
      ),
    );
  }
}

class _AlignChip extends StatelessWidget {
  const _AlignChip({required this.icon, required this.value, required this.draft, required this.ref});

  final IconData icon;
  final String value;
  final AffirmationDraft draft;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final selected = draft.textAlign == value;
    final c = context.colors;
    return Expanded(
      child: OutlinedButton(
        onPressed: () => ref.read(editorDraftProvider.notifier).state = draft.copyWith(textAlign: value),
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? c.primarySoft : null,
          side: BorderSide(color: selected ? c.primary : c.border),
          minimumSize: const Size(0, 48),
        ),
        child: Icon(icon, color: selected ? c.primary : c.textSecondary),
      ),
    );
  }
}
