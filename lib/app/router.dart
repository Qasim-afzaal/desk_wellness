import 'package:desk_wellness/features/breathing/breathing_screen.dart';
import 'package:desk_wellness/features/exercise/exercise_library_screen.dart';
import 'package:desk_wellness/features/home/home_screen.dart';
import 'package:desk_wellness/features/journal/journal_screen.dart';
import 'package:desk_wellness/features/onboarding/goals_screen.dart';
import 'package:desk_wellness/features/onboarding/notifications_screen.dart';
import 'package:desk_wellness/features/onboarding/reminder_time_screen.dart';
import 'package:desk_wellness/features/onboarding/welcome_screen.dart';
import 'package:desk_wellness/features/profile/profile_screen.dart';
import 'package:desk_wellness/features/exercise/exercise_detail_screen.dart';
import 'package:desk_wellness/features/journal/journal_editor_screen.dart';
import 'package:desk_wellness/features/mood/mood_tracker_screen.dart';
import 'package:desk_wellness/features/affirmation/affirmations_screen.dart';
import 'package:desk_wellness/features/reminders/reminders_screen.dart';
import 'package:desk_wellness/features/progress/progress_screen.dart';
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
      if (onboarded && (loc.startsWith('/onboarding') || loc == '/splash')) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const _SplashScreen()),
      GoRoute(
        path: '/onboarding/welcome',
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(path: '/onboarding/goals', builder: (_, __) => const GoalsScreen()),
      GoRoute(path: '/onboarding/notifications', builder: (_, __) => const NotificationsScreen()),
      GoRoute(path: '/onboarding/reminder', builder: (_, __) => const ReminderTimeScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (_, __) => const HomeScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/exercises', builder: (_, __) => const ExerciseLibraryScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/breathe', builder: (_, __) => const BreathingScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/journal', builder: (_, __) => const JournalScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen())]),
        ],
      ),
      GoRoute(
        path: '/exercise/:id',
        builder: (_, state) => ExerciseDetailScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(path: '/journal/new', builder: (_, __) => const JournalEditorScreen()),
      GoRoute(path: '/mood', builder: (_, __) => const MoodTrackerScreen()),
      GoRoute(path: '/affirmations', builder: (_, __) => const AffirmationsScreen()),
      GoRoute(path: '/reminders', builder: (_, __) => const RemindersScreen()),
      GoRoute(path: '/progress', builder: (_, __) => const ProgressScreen()),
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
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.directions_run_outlined), selectedIcon: Icon(Icons.directions_run), label: 'Exercises'),
          NavigationDestination(icon: Icon(Icons.air_outlined), selectedIcon: Icon(Icons.air), label: 'Breathe'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Journal'),
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
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
