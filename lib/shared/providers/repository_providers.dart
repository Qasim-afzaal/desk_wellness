import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/services/engagement_service.dart';
import 'package:desk_wellness/core/services/tts_service.dart';
import 'package:desk_wellness/core/constants/affirmation_topics.dart';
import 'package:desk_wellness/core/constants/app_goals.dart';
import 'package:desk_wellness/core/services/theme_selection_service.dart';
import 'package:desk_wellness/core/services/topic_mix_service.dart';
import 'package:desk_wellness/core/services/watch_sync_service.dart';
import 'package:desk_wellness/core/services/widget_service.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/repositories/affirmation_repository.dart';
import 'package:desk_wellness/repositories/creation_repository.dart';
import 'package:desk_wellness/repositories/manifest_repository.dart';
import 'package:desk_wellness/repositories/reminder_repository.dart';
import 'package:desk_wellness/repositories/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider((_) => getIt<SettingsRepository>());
final affirmationRepositoryProvider = Provider((_) => getIt<AffirmationRepository>());
final reminderRepositoryProvider = Provider((_) => getIt<ReminderRepository>());
final creationRepositoryProvider = Provider((_) => getIt<CreationRepository>());
final manifestRepositoryProvider = Provider((_) => getIt<ManifestRepository>());
final ttsServiceProvider = Provider((_) => getIt<TtsService>());
final engagementServiceProvider = Provider((_) => getIt<EngagementService>());
final topicMixServiceProvider = Provider((_) => getIt<TopicMixService>());
final themeSelectionServiceProvider = Provider((_) => getIt<ThemeSelectionService>());
final widgetServiceProvider = Provider((_) => getIt<WidgetService>());
final watchSyncServiceProvider = Provider((_) => getIt<WatchSyncService>());

final topicMixProvider = FutureProvider<List<String>>((ref) async {
  return ref.watch(topicMixServiceProvider).getSelectedTopicIds();
});

final selectedThemeIdProvider = FutureProvider<String>((ref) async {
  return ref.watch(themeSelectionServiceProvider).getSelectedThemeId();
});

final watchStatusProvider = FutureProvider<(bool supported, bool paired)>((ref) async {
  final watch = ref.watch(watchSyncServiceProvider);
  return (await watch.isSupported, await watch.isPaired);
});

final settingsStreamProvider = StreamProvider((ref) => ref.watch(settingsRepositoryProvider).watchSettings());

final userGoalsProvider = Provider<List<AppGoal>>((ref) {
  final settings = ref.watch(settingsStreamProvider);
  return settings.maybeWhen(
    data: (s) => AppGoals.fromCsv(s.goals),
    orElse: () => [],
  );
});

final todayAffirmationProvider = FutureProvider((ref) async {
  final goals = ref.watch(userGoalsProvider);
  return ref.watch(affirmationRepositoryProvider).todayAffirmation(
        goalIds: goals.map((g) => g.id).toList(),
      );
});

final affirmationFeedProvider = FutureProvider.family<List<Affirmation>, String>((ref, category) async {
  if (category == 'favorites') {
    return ref.watch(affirmationRepositoryProvider).watchFavorites().first;
  }
  final topicIds = await ref.watch(topicMixProvider.future);
  final topicCategories = AffirmationTopics.categoriesForTopics(topicIds);
  return ref.watch(affirmationRepositoryProvider).getFeed(
        category: category,
        topicCategories: category == 'all' ? topicCategories : const [],
      );
});

final affirmationsStreamProvider = StreamProvider.family<List<Affirmation>, String>((ref, category) {
  if (category == 'favorites') {
    return ref.watch(affirmationRepositoryProvider).watchFavorites();
  }
  return ref.watch(affirmationRepositoryProvider).watchAll(category: category);
});

final favoritesStreamProvider = StreamProvider((ref) {
  return ref.watch(affirmationRepositoryProvider).watchFavorites();
});

final engagementStreakProvider = FutureProvider((ref) async {
  await ref.watch(engagementServiceProvider).recordDailyEngagement();
  return ref.watch(engagementServiceProvider).streakDays();
});

final manifestSessionsProvider = StreamProvider((ref) {
  return ref.watch(manifestRepositoryProvider).watchRecent();
});

final manifestCountProvider = FutureProvider((ref) => ref.watch(manifestRepositoryProvider).count());

final streakProvider = FutureProvider((ref) => ref.watch(creationRepositoryProvider).streakDays());

final wallpaperCountProvider = FutureProvider((ref) => ref.watch(creationRepositoryProvider).wallpaperCount());

final weeklyActivityProvider = FutureProvider((ref) => ref.watch(creationRepositoryProvider).weeklyActivity());

final remindersStreamProvider = StreamProvider((ref) => ref.watch(reminderRepositoryProvider).watchAll());

final reminderByIdProvider = FutureProvider.family<Reminder?, int>((ref, id) async {
  return ref.watch(reminderRepositoryProvider).getById(id);
});

final savedCreationsProvider = StreamProvider.family<List<SavedCreation>, String>((ref, query) {
  return ref.watch(creationRepositoryProvider).watchSaved(query: query);
});
