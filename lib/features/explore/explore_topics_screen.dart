import 'package:desk_wellness/core/constants/affirmation_topics.dart';
import 'package:desk_wellness/core/constants/affirmation_categories.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
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
    final topics = _filtered;

    return KindledScreen(
      title: 'Explore topics',
      showBack: true,
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ],
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search topics',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: c.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: AppSpacing.md),
            KindledPrimaryButton(
              label: 'Make your own mix',
              onPressed: _selected.isEmpty ? null : _save,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('For you', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.05,
                ),
                itemCount: topics.length,
                itemBuilder: (context, i) {
                  final topic = topics[i];
                  final active = _selected.contains(topic.id);
                  return Material(
                    color: active ? c.primarySoft : c.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      side: BorderSide(color: active ? c.primary : c.border, width: active ? 2 : 1),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
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
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(topic.icon, style: const TextStyle(fontSize: 36)),
                            const Spacer(),
                            Text(topic.title, style: TextStyle(fontWeight: FontWeight.w700, color: c.textPrimary)),
                            const SizedBox(height: AppSpacing.sm),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                active ? Icons.check_circle : Icons.circle_outlined,
                                color: active ? c.primary : c.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
