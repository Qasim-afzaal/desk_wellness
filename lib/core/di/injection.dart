import 'package:desk_wellness/core/services/engagement_service.dart';
import 'package:desk_wellness/core/services/image_search_service.dart';
import 'package:desk_wellness/core/services/notification_service.dart';
import 'package:desk_wellness/core/services/theme_selection_service.dart';
import 'package:desk_wellness/core/services/topic_mix_service.dart';
import 'package:desk_wellness/core/services/tts_service.dart';
import 'package:desk_wellness/core/services/watch_sync_service.dart';
import 'package:desk_wellness/core/services/widget_service.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/repositories/affirmation_repository.dart';
import 'package:desk_wellness/repositories/creation_repository.dart';
import 'package:desk_wellness/repositories/manifest_repository.dart';
import 'package:desk_wellness/repositories/reminder_repository.dart';
import 'package:desk_wellness/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final db = await AppDatabase.open();
  getIt.registerSingleton<AppDatabase>(db);

  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository(db));
  getIt.registerLazySingleton<AffirmationRepository>(() => AffirmationRepository(db));
  getIt.registerLazySingleton<CreationRepository>(() => CreationRepository(db));
  getIt.registerLazySingleton<ManifestRepository>(() => ManifestRepository(db));

  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<TtsService>(() => TtsService());
  getIt.registerLazySingleton<EngagementService>(() => EngagementService());
  getIt.registerLazySingleton<ImageSearchService>(() => ImageSearchService());
  getIt.registerLazySingleton<TopicMixService>(() => TopicMixService());
  getIt.registerLazySingleton<ThemeSelectionService>(() => ThemeSelectionService());
  getIt.registerLazySingleton<WidgetService>(() => WidgetService());
  getIt.registerLazySingleton<WatchSyncService>(() => WatchSyncService());

  await getIt<NotificationService>().init();
  await getIt<WidgetService>().init();

  getIt.registerLazySingleton<ReminderRepository>(
    () => ReminderRepository(
      db,
      getIt<NotificationService>(),
      getIt<AffirmationRepository>(),
    ),
  );
}
