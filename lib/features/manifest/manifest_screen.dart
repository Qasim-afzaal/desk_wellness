import 'package:desk_wellness/core/constants/app_goals.dart';
import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ManifestScreen extends ConsumerStatefulWidget {
  const ManifestScreen({super.key});

  @override
  ConsumerState<ManifestScreen> createState() => _ManifestScreenState();
}

class _ManifestScreenState extends ConsumerState<ManifestScreen> {
  late final TextEditingController _controller;
  String _goalId = 'confidence';
  int _step = 0;

  @override
  void initState() {
    super.initState();
    final goals = ref.read(userGoalsProvider);
    _goalId = goals.isNotEmpty ? goals.first.id : 'confidence';
    _controller = TextEditingController(text: AppGoals.byId(_goalId)?.prompt ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveManifestation() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    await ref.read(manifestRepositoryProvider).save(content: text, goalTag: _goalId);
    await ref.read(affirmationRepositoryProvider).addCustom(text, AppGoals.categoryForGoal(_goalId));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Manifestation saved to your library')),
      );
      context.pop();
    }
  }

  void _createWallpaper() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final template = AffirmationTemplates.forGoal(_goalId) ?? AffirmationTemplates.all.first;
    ref.read(editorDraftProvider.notifier).state = AffirmationDraft(text: text, template: template);
    context.push('/editor');
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final goals = ref.watch(userGoalsProvider);
    final goalOptions = goals.isNotEmpty ? goals : AppGoals.all.take(3).toList();

    return KindledScreen(
      title: 'MANIFEST',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(3, (i) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < 2 ? AppSpacing.sm : 0),
                    decoration: BoxDecoration(
                      color: i <= _step ? c.primary : c.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_step == 0) ...[
              Text('Choose your focus', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: goalOptions.map((g) {
                  final active = g.id == _goalId;
                  return ChoiceChip(
                    label: Text('${g.icon} ${g.title}'),
                    selected: active,
                    onSelected: (_) => setState(() {
                      _goalId = g.id;
                      _controller.text = g.prompt;
                    }),
                  );
                }).toList(),
              ),
              const Spacer(),
              KindledPrimaryButton(label: 'Next', onPressed: () => setState(() => _step = 1)),
            ] else if (_step == 1) ...[
              Text('Write your manifestation', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Speak it in present tense…',
                    filled: true,
                    fillColor: c.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                  ),
                  style: const TextStyle(fontSize: 18, height: 1.4),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              KindledPrimaryButton(label: 'Next', onPressed: () => setState(() => _step = 2)),
            ] else ...[
              Text('Visualize & claim it', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: AffirmationCard(
                  text: _controller.text,
                  background: c.cardForest,
                  accent: c.cardYellow,
                  fontStyle: 'calm',
                  pulseAccent: true,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              KindledPrimaryButton(label: 'Save manifestation', icon: Icons.check, onPressed: _saveManifestation),
              const SizedBox(height: AppSpacing.sm),
              KindledSecondaryButton(label: 'Create wallpaper', icon: Icons.wallpaper_outlined, onPressed: _createWallpaper),
            ],
          ],
        ),
      ),
    );
  }
}
