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
import 'package:desk_wellness/features/wallpaper/wallpaper_screen.dart';
import 'package:desk_wellness/features/widgets/widget_setup_screen.dart';
import 'package:desk_wellness/features/watch/watch_face_screen.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsStreamProvider);
  final onboarded = settings.maybeWhen(data: (s) => s.onboardingComplete, orElse: () => false);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    redirect: (context, state) {
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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.format_quote_outlined), selectedIcon: Icon(Icons.format_quote), label: 'Affirmations'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Themes'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _SplashScreen extends ConsumerWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(settingsStreamProvider, (_, __) {});
    return Scaffold(
      body: AmbientBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KindledLottie(asset: KindledAssets.sunrise, width: 160, height: 160),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Affirmly',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.md),
              KindledLottie(asset: KindledAssets.loadingDots, width: 72, height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
