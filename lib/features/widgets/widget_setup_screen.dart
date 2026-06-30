import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WidgetSetupScreen extends ConsumerWidget {
  const WidgetSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final affirmationAsync = ref.watch(todayAffirmationProvider);
    final watchAsync = ref.watch(watchStatusProvider);

    return KindledScreen(
      title: 'Widgets & Watch',
      showBack: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customizable widgets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Pin an affirmation to your home screen. It updates when you browse affirmations in the app.',
              style: TextStyle(color: c.textMuted, height: 1.4),
            ),
            const SizedBox(height: AppSpacing.lg),
            _PreviewCard(
              text: affirmationAsync.valueOrNull?.content ?? 'I am enough.',
              template: AffirmationTemplates.byId('sage')!,
            ),
            const SizedBox(height: AppSpacing.lg),
            KindledPrimaryButton(
              label: 'Add home screen widget',
              icon: Icons.widgets_outlined,
              onPressed: () async {
                final text = affirmationAsync.valueOrNull?.content ?? 'I am enough.';
                final template = AffirmationTemplates.byId('sage')!;
                await ref.read(widgetServiceProvider).updateAffirmation(
                      text: text,
                      backgroundHex: '#D4E2D0',
                      templateId: template.id,
                    );
                final pinned = await ref.read(widgetServiceProvider).requestPinWidget();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        pinned
                            ? 'Widget added — long-press home screen to place it'
                            : 'Widget data saved — add Affirmly from your widget gallery',
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Watch support',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            watchAsync.when(
              data: (status) {
                final (supported, paired) = status;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supported
                          ? paired
                              ? 'Apple Watch paired — affirmations sync when you swipe'
                              : 'Watch supported — pair a watch to sync affirmations'
                          : 'Watch sync works on iPhone with a paired Apple Watch',
                      style: TextStyle(color: c.textMuted, height: 1.4),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    KindledSecondaryButton(
                      label: 'Preview watch face',
                      icon: Icons.watch_outlined,
                      onPressed: () => context.push('/watch'),
                    ),
                    if (supported && paired) ...[
                      const SizedBox(height: AppSpacing.sm),
                      KindledSecondaryButton(
                        label: 'Sync now',
                        onPressed: () async {
                          final text = affirmationAsync.valueOrNull?.content ?? 'I am enough.';
                          await ref.read(watchSyncServiceProvider).syncAffirmation(
                                text: text,
                                backgroundHex: '#000000',
                              );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sent to watch')),
                            );
                          }
                        },
                      ),
                    ],
                  ],
                );
              },
              loading: () => Text('Checking watch…', style: TextStyle(color: c.textMuted)),
              error: (_, __) => Text('Watch status unavailable', style: TextStyle(color: c.textMuted)),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Native Apple Watch app included. Swipe affirmations on iPhone — they appear on your watch automatically.',
              style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.text, required this.template});

  final String text;
  final AffirmationTemplate template;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: template.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: template.background.computeLuminance() < 0.45 ? Colors.white : Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.35,
        ),
      ),
    );
  }
}
