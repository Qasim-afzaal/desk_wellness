import 'package:desk_wellness/core/constants/affirmation_topics.dart';
import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_motion.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  String _tab = 'all';

  List<AffirmationTemplate> get _templates {
    var list = AffirmationTemplates.filtered(_tab == 'free' || _tab == 'new' || _tab == 'popular' || _tab == 'seasonal' ? 'all' : _tab);
    return switch (_tab) {
      'new' => list.where((t) => {'mist', 'portal', 'spark', 'clarity'}.contains(t.id)).toList(),
      'popular' => list.where((t) => {'sage', 'forest', 'rose', 'gold', 'sun'}.contains(t.id)).toList(),
      'seasonal' => list.where((t) => {'bloom', 'harvest', 'moon', 'glow'}.contains(t.id)).toList(),
      'free' => list,
      _ => list,
    };
  }

  Future<void> _selectTheme(AffirmationTemplate template) async {
    await ref.read(themeSelectionServiceProvider).setSelectedThemeId(template.id);
    ref.invalidate(selectedThemeIdProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${template.label} theme applied')),
      );
      context.go('/today');
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final templates = _templates;
    final selectedAsync = ref.watch(selectedThemeIdProvider);

    return KindledScreen(
      title: 'Themes',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['create', 'all', 'new', 'free', 'seasonal', 'popular'].map((tab) {
                  final active = tab == _tab;
                  final label = switch (tab) {
                    'create' => '+ Create',
                    'all' => 'All',
                    'new' => 'New',
                    'free' => 'Free',
                    'seasonal' => 'Seasonal',
                    'popular' => 'Most popular',
                    _ => tab,
                  };
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(label),
                      selected: active,
                      onSelected: (_) {
                        if (tab == 'create') {
                          final t = AffirmationTemplates.all.first;
                          ref.read(editorDraftProvider.notifier).state =
                              AffirmationDraft(text: t.sampleText, template: t);
                          context.push('/editor');
                          return;
                        }
                        setState(() => _tab = tab);
                      },
                      selectedColor: c.buttonPrimary,
                      labelStyle: TextStyle(color: active ? c.onPrimary : c.textSecondary, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ).fadeSlideIn(),
            const SizedBox(height: AppSpacing.lg),
            Text('Theme mixes', style: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ThemeMixes.mixes.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, i) {
                  final (_, label, ids) = ThemeMixes.mixes[i];
                  final preview = AffirmationTemplates.byId(ids.first)!;
                  return GestureDetector(
                    onTap: () => _selectTheme(preview),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: preview.background,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: c.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: preview.background.computeLuminance() < 0.45 ? Colors.white : c.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('For you', style: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: selectedAsync.when(
                data: (selectedId) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    final template = templates[index];
                    final selected = template.id == selectedId;
                    return GestureDetector(
                      onTap: () => _selectTheme(template),
                      onLongPress: () => context.push('/templates/${template.id}'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: template.background,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: selected ? c.primary : c.border, width: selected ? 2.5 : 1),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                'I am',
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: template.background.computeLuminance() < 0.45
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: Text(
                                template.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: template.background.computeLuminance() < 0.45
                                      ? Colors.white
                                      : c.textPrimary,
                                ),
                              ),
                            ),
                            if (selected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Icon(Icons.check_circle, color: c.primary, size: 20),
                              ),
                          ],
                        ),
                      ),
                    ).staggerIn(index);
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({super.key, required this.templateId});

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = AffirmationTemplates.byId(templateId);
    if (template == null) {
      return const Scaffold(body: Center(child: Text('Theme not found')));
    }

    return KindledScreen(
      title: 'Theme detail',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Text(template.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.lg),
            Expanded(child: AffirmationCardFromTemplate(template: template)),
            const SizedBox(height: AppSpacing.lg),
            KindledPrimaryButton(
              label: 'Use this theme',
              onPressed: () async {
                await ref.read(themeSelectionServiceProvider).setSelectedThemeId(template.id);
                ref.invalidate(selectedThemeIdProvider);
                if (context.mounted) context.go('/today');
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            KindledSecondaryButton(
              label: 'Customize wallpaper',
              onPressed: () {
                ref.read(editorDraftProvider.notifier).state = AffirmationDraft(
                  text: template.sampleText,
                  template: template,
                );
                context.push('/editor');
              },
            ),
          ],
        ),
      ),
    );
  }
}
