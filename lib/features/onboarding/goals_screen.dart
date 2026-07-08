import 'package:desk_wellness/core/constants/app_goals.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
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
    final brightness = Theme.of(context).brightness;

    return CelestialScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isOnboarding)
                IconButton(
                  icon: Icon(Icons.arrow_back, color: c.textPrimary),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              Text(
                widget.isOnboarding ? 'YOUR GOALS' : 'MY GOALS',
                style: CelestialTypography.labelCaps(color: c.primary, brightness: brightness),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'What do you want to manifest?',
                style: CelestialTypography.headlineLg(brightness: brightness),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Pick up to 3 focus areas. Your daily affirmations will match.',
                style: CelestialTypography.bodyMd(brightness: brightness),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.35,
                  ),
                  itemCount: AppGoals.all.length,
                  itemBuilder: (context, i) {
                    final goal = AppGoals.all[i];
                    final active = _selected.contains(goal.id);
                    return _GoalCard(
                      goal: goal,
                      selected: active,
                      onTap: () => setState(() {
                        if (active) {
                          _selected.remove(goal.id);
                        } else if (_selected.length < 3) {
                          _selected.add(goal.id);
                        }
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '${_selected.length}/3 selected',
                style: CelestialTypography.labelCaps(brightness: brightness),
              ),
              const SizedBox(height: AppSpacing.sm),
              CelestialPrimaryButton(
                label: widget.isOnboarding ? 'Continue' : 'Save goals',
                icon: Icons.arrow_forward,
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
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal, required this.selected, required this.onTap});

  final AppGoal goal;
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
                      goal.icon,
                      color: selected ? c.buttonPrimary : c.primary,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    goal.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: selected ? c.textPrimary : c.textSecondary,
                    ),
                  ),
                  if (selected)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.check_circle, size: 16, color: c.buttonPrimary),
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
