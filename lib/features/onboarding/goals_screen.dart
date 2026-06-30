import 'package:desk_wellness/core/constants/app_goals.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingGoalsScreen extends ConsumerStatefulWidget {
  const OnboardingGoalsScreen({super.key, this.isOnboarding = true});

  final bool isOnboarding;

  @override
  ConsumerState<OnboardingGoalsScreen> createState() => _OnboardingGoalsScreenState();
}

class _OnboardingGoalsScreenState extends ConsumerState<OnboardingGoalsScreen> {
  late final Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.isOnboarding
        ? {'confidence', 'abundance', 'peace'}
        : ref.read(userGoalsProvider).map((g) => g.id).toSet();
    if (_selected.isEmpty) _selected.add('confidence');
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return KindledScreen(
      title: widget.isOnboarding ? 'YOUR GOALS' : 'MY GOALS',
      showBack: !widget.isOnboarding,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What do you want to manifest?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Pick up to 3 focus areas. Your daily affirmations will match.', style: TextStyle(color: c.textMuted)),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 1.6,
                ),
                itemCount: AppGoals.all.length,
                itemBuilder: (context, i) {
                  final goal = AppGoals.all[i];
                  final active = _selected.contains(goal.id);
                  return Material(
                    color: active ? c.primarySoft : c.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      side: BorderSide(color: active ? c.primary : c.border, width: active ? 2 : 1),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      onTap: () => setState(() {
                        if (active) {
                          _selected.remove(goal.id);
                        } else if (_selected.length < 3) {
                          _selected.add(goal.id);
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(goal.icon, style: const TextStyle(fontSize: 24)),
                            const Spacer(),
                            Text(goal.title, style: TextStyle(fontWeight: FontWeight.w700, color: active ? c.primary : c.textPrimary)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            KindledPrimaryButton(
              label: widget.isOnboarding ? 'Continue' : 'Save goals',
              onPressed: _selected.isEmpty
                  ? null
                  : () {
                      final ids = _selected.toList();
                      if (widget.isOnboarding) {
                        context.push('/onboarding/reminders', extra: ids);
                      } else {
                        Navigator.of(context).pop(ids);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
