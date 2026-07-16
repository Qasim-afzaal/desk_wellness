import 'package:desk_wellness/core/constants/affirmation_categories.dart';
import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/models/canvas_document.dart';
import 'package:desk_wellness/core/models/editor_state.dart';
import 'package:desk_wellness/core/services/tts_service.dart';
import 'package:desk_wellness/core/services/widget_service.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/app_logo.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:desk_wellness/core/utils/platform_native.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  String _category = 'all';
  final _pageController = PageController();
  int _pageIndex = 0;
  bool _speaking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncCurrentIfReady());
  }

  Future<void> _syncCurrentIfReady() async {
    final items = ref.read(affirmationFeedProvider(_category)).valueOrNull;
    final themeId = ref.read(selectedThemeIdProvider).valueOrNull ?? 'sage';
    if (items == null || items.isEmpty || _pageIndex >= items.length) return;
    final theme = AffirmationTemplates.byId(themeId) ?? AffirmationTemplates.all.first;
    await _syncSurfaces(items[_pageIndex], theme);
  }

  @override
  void dispose() {
    _pageController.dispose();
    getIt<TtsService>().stop();
    super.dispose();
  }

  Future<void> _syncSurfaces(Affirmation item, AffirmationTemplate theme) async {
    final hex = WidgetService.colorToHex(theme.background.toARGB32());
    // Home-widget text is edited on Widgets & Watch — don't overwrite it while browsing.
    await ref.read(watchSyncServiceProvider).syncAffirmation(
          text: item.content,
          backgroundHex: hex,
        );
  }

  Future<void> _toggleFavorite(Affirmation item) async {
    HapticFeedback.lightImpact();
    await ref.read(affirmationRepositoryProvider).toggleFavorite(item.id, !item.isFavorite);
    ref.invalidate(affirmationFeedProvider(_category));
  }

  Future<void> _speak(String text) async {
    HapticFeedback.selectionClick();
    if (_speaking) {
      await ref.read(ttsServiceProvider).stop();
      setState(() => _speaking = false);
      return;
    }
    setState(() => _speaking = true);
    final ok = await ref.read(ttsServiceProvider).speak(text);
    if (mounted) {
      setState(() => _speaking = false);
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voice unavailable. $kNativePluginHint')),
        );
      }
    }
  }

  void _openCanvasEditor(Affirmation item) {
    ref.read(canvasDocumentProvider.notifier).state = CanvasDocument(
      affirmationText: item.content,
    );
    context.push('/canvas/editor');
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;
    final feedAsync = ref.watch(affirmationFeedProvider(_category));
    final themeIdAsync = ref.watch(selectedThemeIdProvider);
    final streakAsync = ref.watch(engagementStreakProvider);

    return CelestialScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
              child: Row(
                children: [
                  AffirfestingBrandMark(
                    logoSize: 40,
                    titleStyle: CelestialTypography.headlineLg(brightness: brightness).copyWith(fontSize: 20),
                    subtitle: 'Daily affirmations',
                  ),
                  const Spacer(),
                  streakAsync.when(
                    data: (s) => s > 0
                        ? GlassPanel(
                            radius: AppRadius.pill,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_fire_department, size: 16, color: CelestialPalette.tertiary(brightness)),
                                const SizedBox(width: 4),
                                Text(
                                  '$s',
                                  style: CelestialTypography.labelCaps(
                                    color: c.textPrimary,
                                    brightness: brightness,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: AffirmationCategories.feedTabs.map((tab) {
                    final active = tab == _category;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: CelestialPillChip(
                        label: AffirmationCategories.label(tab),
                        selected: active,
                        onTap: () {
                          setState(() {
                            _category = tab;
                            _pageIndex = 0;
                          });
                          ref.invalidate(affirmationFeedProvider(tab));
                          if (_pageController.hasClients) _pageController.jumpToPage(0);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: feedAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: KindledPrimaryButton(
                        label: 'Explore topics',
                        onPressed: () => context.push('/explore'),
                      ),
                    );
                  }
                  return themeIdAsync.when(
                    data: (themeId) {
                      final theme = AffirmationTemplates.byId(themeId) ?? AffirmationTemplates.all.first;
                      return PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        onPageChanged: (i) {
                          HapticFeedback.selectionClick();
                          setState(() => _pageIndex = i);
                          _syncSurfaces(items[i], theme);
                        },
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _IamAffirmationCard(
                            item: item,
                            theme: theme,
                            speaking: _speaking && index == _pageIndex,
                            onFavorite: () => _toggleFavorite(item),
                            onListen: () => _speak(item.content),
                            onPractice: () => context.push('/practice', extra: item.content),
                            onEdit: () => _openCanvasEditor(item),
                            onExplore: () => context.push('/explore'),
                            onProfile: () => context.go('/profile'),
                            onWallpaper: () => context.go('/visual'),
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const SizedBox.shrink(),
                  );
                },
                loading: () => const Center(child: ShimmerCardPlaceholder(height: 400)),
                error: (_, __) => const Center(child: Text('Could not load affirmations')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IamAffirmationCard extends StatelessWidget {
  const _IamAffirmationCard({
    required this.item,
    required this.theme,
    required this.speaking,
    required this.onFavorite,
    required this.onListen,
    required this.onPractice,
    required this.onEdit,
    required this.onExplore,
    required this.onProfile,
    required this.onWallpaper,
  });

  final Affirmation item;
  final AffirmationTemplate theme;
  final bool speaking;
  final VoidCallback onFavorite;
  final VoidCallback onListen;
  final VoidCallback onPractice;
  final VoidCallback onEdit;
  final VoidCallback onExplore;
  final VoidCallback onProfile;
  final VoidCallback onWallpaper;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;
    final onDark = theme.background.computeLuminance() < 0.45;
    final textColor = onDark ? CelestialPalette.onSurface(brightness) : c.textPrimary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
      child: Stack(
        children: [
          GlassPanel(
            glow: true,
            radius: AppRadius.xl,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl - 4),
                gradient: CelestialGradients.cardGlow,
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    Icon(Icons.auto_awesome, color: c.buttonPrimary, size: 32),
                    const SizedBox(height: AppSpacing.md),
                    Expanded(
                      child: Center(
                        child: Text(
                          item.content,
                          textAlign: TextAlign.center,
                          style: CelestialTypography.displayAffirmation(color: textColor, brightness: brightness),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CircleAction(
                          icon: Icons.favorite_border,
                          activeIcon: Icons.favorite,
                          active: item.isFavorite,
                          onTap: onFavorite,
                          color: c.buttonPrimary,
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        _CircleAction(
                          icon: speaking ? Icons.stop : Icons.volume_up_outlined,
                          onTap: onListen,
                          color: CelestialPalette.tertiary(brightness),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    CelestialPrimaryButton(
                      label: 'Practice',
                      icon: Icons.self_improvement_outlined,
                      expanded: false,
                      onPressed: onPractice,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: 12, left: 12, child: _FloatingIconButton(icon: Icons.person_outline, onTap: onProfile)),
          Positioned(bottom: 88, left: 12, child: _FloatingIconButton(icon: Icons.grid_view, onTap: onExplore)),
          Positioned(bottom: 88, right: 12, child: _FloatingIconButton(icon: Icons.edit_outlined, onTap: onEdit)),
          Positioned(top: 12, right: 12, child: _FloatingIconButton(icon: Icons.wallpaper_outlined, onTap: onWallpaper)),
        ],
      ),
    );
  }
}

class _FloatingIconButton extends StatelessWidget {
  const _FloatingIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GlassPanel(
      radius: AppRadius.pill,
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Icon(icon, color: c.textPrimary, size: 20),
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.onTap,
    required this.color,
    this.activeIcon,
    this.active = false,
  });

  final IconData icon;
  final IconData? activeIcon;
  final VoidCallback onTap;
  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(active && activeIcon != null ? activeIcon : icon, color: color, size: 28),
    );
  }
}
