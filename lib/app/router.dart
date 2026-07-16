import 'package:desk_wellness/features/affirmations/affirmations_screen.dart';
import 'package:desk_wellness/features/editor/editor_screen.dart';
import 'package:desk_wellness/features/manifest/manifest_screen.dart';
import 'package:desk_wellness/features/notifications/notifications_screen.dart';
import 'package:desk_wellness/features/onboarding/goals_screen.dart';
import 'package:desk_wellness/features/onboarding/reminders_screen.dart';
import 'package:desk_wellness/features/onboarding/welcome_screen.dart';
import 'package:desk_wellness/features/profile/profile_screen.dart';
import 'package:desk_wellness/features/favorites/favorites_screen.dart';
import 'package:desk_wellness/features/saved/saved_library_screen.dart';
import 'package:desk_wellness/features/templates/templates_screen.dart';
import 'package:desk_wellness/features/today/today_screen.dart';
import 'package:desk_wellness/features/explore/explore_topics_screen.dart';
import 'package:desk_wellness/features/practice/practice_screen.dart';
import 'package:desk_wellness/features/wallpaper/canvas_editor_screen.dart';
import 'package:desk_wellness/features/wallpaper/wallpaper_search_screen.dart';
import 'package:desk_wellness/features/wallpaper/wallpaper_screen.dart';
import 'package:desk_wellness/features/widgets/widget_setup_screen.dart';
import 'package:desk_wellness/features/watch/watch_face_screen.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/app_logo.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Rebuilds redirects when settings change without recreating [GoRouter]
/// (recreating would reset navigation mid-onboarding).
class _RouterRefresh extends ChangeNotifier {
  void ping() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh();
  ref.onDispose(refresh.dispose);
  ref.listen(settingsStreamProvider, (_, __) => refresh.ping());

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final settings = ref.read(settingsStreamProvider);
      final onboarded =
          settings.maybeWhen(data: (s) => s.onboardingComplete, orElse: () => false);
      final loc = state.matchedLocation;
      if (settings.isLoading) return loc == '/splash' ? null : '/splash';
      if (!onboarded && !loc.startsWith('/onboarding')) return '/onboarding/welcome';
      if (onboarded && (loc.startsWith('/onboarding') || loc == '/splash')) return '/today';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const _SplashScreen()),
      GoRoute(path: '/onboarding/welcome', builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/onboarding/goals', builder: (_, __) => const OnboardingGoalsScreen()),
      GoRoute(
        path: '/onboarding/reminders',
        builder: (_, state) => OnboardingRemindersScreen(
          goalIds: state.extra as List<String>? ?? const [],
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/today', builder: (_, __) => const TodayScreen())]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/visual',
                builder: (_, __) => const WallpaperSearchScreen(embeddedInShell: true),
              ),
            ],
          ),
          StatefulShellBranch(routes: [GoRoute(path: '/templates', builder: (_, __) => const TemplatesScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/saved', builder: (_, __) => const FavoritesScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen())]),
        ],
      ),
      GoRoute(
        path: '/templates/:id',
        builder: (_, state) => TemplateDetailScreen(templateId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/editor', builder: (_, __) => const EditorScreen()),
      GoRoute(path: '/editor/style', builder: (_, __) => const StyleControlsScreen()),
      GoRoute(path: '/explore', builder: (_, __) => const ExploreTopicsScreen()),
      GoRoute(
        path: '/practice',
        builder: (_, state) => PracticeScreen(affirmation: state.extra as String? ?? 'I am enough.'),
      ),
      GoRoute(path: '/widgets', builder: (_, __) => const WidgetSetupScreen()),
      GoRoute(path: '/watch', builder: (_, __) => const WatchFaceScreen()),
      GoRoute(path: '/wallpaper/search', builder: (_, state) {
        final extra = state.extra;
        return WallpaperSearchScreen(
          affirmationText: extra is String ? extra : null,
        );
      }),
      GoRoute(path: '/canvas/editor', builder: (_, __) => const CanvasEditorScreen()),
      GoRoute(path: '/wallpaper/preview', builder: (_, __) => const WallpaperPreviewScreen()),
      GoRoute(path: '/export', builder: (_, __) => const ExportScreen()),
      GoRoute(path: '/manifest', builder: (_, __) => const ManifestScreen()),
      GoRoute(path: '/affirmations', builder: (_, __) => const AffirmationsScreen()),
      GoRoute(path: '/wallpapers', builder: (_, __) => const SavedLibraryScreen()),
      GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
      GoRoute(
        path: '/notifications/:id',
        builder: (_, state) => ReminderDetailScreen(reminderId: int.parse(state.pathParameters['id']!)),
      ),
    ],
  );
});

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: CelestialPalette.background(brightness),
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: CelestialBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goBranch,
      ),
    );
  }
}

class _SplashScreen extends ConsumerWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(settingsStreamProvider, (_, __) {});
    return CelestialScaffold(
      body: AmbientBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AffirfestingLogo(size: 120),
              const SizedBox(height: AppSpacing.lg),
              Text('Affirfesting', style: CelestialTypography.headlineLg()),
              const SizedBox(height: AppSpacing.md),
              KindledLottie(asset: KindledAssets.loadingDots, width: 72, height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
