import 'package:desk_wellness/core/services/ai_service.dart';
import 'package:desk_wellness/core/services/notification_service.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/repositories/affirmation_repository.dart';
import 'package:desk_wellness/repositories/breathing_repository.dart';
import 'package:desk_wellness/repositories/exercise_repository.dart';
import 'package:desk_wellness/repositories/journal_repository.dart';
import 'package:desk_wellness/repositories/mood_repository.dart';
import 'package:desk_wellness/repositories/progress_repository.dart';
import 'package:desk_wellness/repositories/reminder_repository.dart';
import 'package:desk_wellness/repositories/settings_repository.dart';
import 'package:desk_wellness/repositories/water_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final db = await AppDatabase.open();
  getIt.registerSingleton<AppDatabase>(db);

  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository(db));
  getIt.registerLazySingleton<ExerciseRepository>(() => ExerciseRepository(db));
  getIt.registerLazySingleton<AffirmationRepository>(() => AffirmationRepository(db));
  getIt.registerLazySingleton<JournalRepository>(() => JournalRepository(db));
  getIt.registerLazySingleton<MoodRepository>(() => MoodRepository(db));
  getIt.registerLazySingleton<BreathingRepository>(() => BreathingRepository(db));
  getIt.registerLazySingleton<ReminderRepository>(() => ReminderRepository(db));
  getIt.registerLazySingleton<WaterRepository>(() => WaterRepository(db));
  getIt.registerLazySingleton<ProgressRepository>(() => ProgressRepository(db));

  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  await getIt<NotificationService>().init();

  getIt.registerLazySingleton<AIService>(() => MockAIService());
}
