import 'package:desk_wellness/core/constants/affirmation_topics.dart';
import 'package:desk_wellness/core/constants/affirmation_categories.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExploreTopicsScreen extends ConsumerStatefulWidget {
  const ExploreTopicsScreen({super.key});

  @override
  ConsumerState<ExploreTopicsScreen> createState() => _ExploreTopicsScreenState();
}

class _ExploreTopicsScreenState extends ConsumerState<ExploreTopicsScreen> {
  late Set<String> _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = {};
    ref.read(topicMixProvider.future).then((ids) {
      if (mounted) setState(() => _selected = ids.toSet());
    });
  }

  List<AffirmationTopic> get _filtered {
    if (_query.isEmpty) return AffirmationTopics.all;
    final q = _query.toLowerCase();
    return AffirmationTopics.all.where((t) => t.title.toLowerCase().contains(q)).toList();
  }

  Future<void> _save() async {
    await ref.read(topicMixServiceProvider).setSelectedTopicIds(_selected.toList());
    ref.invalidate(topicMixProvider);
    for (final tab in AffirmationCategories.feedTabs) {
      ref.invalidate(affirmationFeedProvider(tab));
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your mix was updated')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;
    final topics = _filtered;

    return CelestialScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: c.textPrimary),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Expanded(
                    child: Text(
                      'EXPLORE TOPICS',
                      style: CelestialTypography.labelCaps(color: c.primary, brightness: brightness),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassPanel(
                      radius: AppRadius.pill,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextField(
                        style: TextStyle(color: c.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Search topics',
                          hintStyle: TextStyle(color: c.textMuted),
                          prefixIcon: Icon(Icons.search, color: c.primary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onChanged: (v) => setState(() => _query = v),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CelestialPrimaryButton(
                      label: _selected.isEmpty ? 'Select topics below' : 'Save my mix',
                      icon: Icons.tune,
                      onPressed: _selected.isEmpty ? null : _save,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'For you',
                      style: CelestialTypography.headlineLg(brightness: brightness).copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${_selected.length} topic${_selected.length == 1 ? '' : 's'} in your mix',
                      style: CelestialTypography.labelCaps(brightness: brightness),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: topics.length,
                        itemBuilder: (context, i) {
                          final topic = topics[i];
                          final active = _selected.contains(topic.id);
                          return _TopicCard(
                            topic: topic,
                            selected: active,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() {
                                if (active) {
                                  _selected.remove(topic.id);
                                } else {
                                  _selected.add(topic.id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic, required this.selected, required this.onTap});

  final AffirmationTopic topic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: GlassPanel(
          radius: AppRadius.lg,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg - 2),
              border: Border.all(
                color: selected ? CelestialPalette.selectedBorder(brightness) : Colors.transparent,
                width: 2,
              ),
              color: selected ? CelestialPalette.selectedFill(brightness) : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected
                          ? c.buttonPrimary.withValues(alpha: 0.2)
                          : c.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      topic.icon,
                      color: selected ? c.buttonPrimary : c.primary,
                      size: 26,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    topic.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.25,
                      color: selected ? c.textPrimary : c.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      selected ? Icons.check_circle : Icons.circle_outlined,
                      color: selected ? c.buttonPrimary : c.textMuted,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
