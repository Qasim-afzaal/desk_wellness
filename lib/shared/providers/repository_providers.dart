import 'package:desk_wellness/core/di/injection.dart';
import 'package:desk_wellness/core/services/ai_service.dart';
import 'package:desk_wellness/repositories/affirmation_repository.dart';
import 'package:desk_wellness/repositories/breathing_repository.dart';
import 'package:desk_wellness/repositories/exercise_repository.dart';
import 'package:desk_wellness/repositories/journal_repository.dart';
import 'package:desk_wellness/repositories/mood_repository.dart';
import 'package:desk_wellness/repositories/progress_repository.dart';
import 'package:desk_wellness/repositories/reminder_repository.dart';
import 'package:desk_wellness/repositories/settings_repository.dart';
import 'package:desk_wellness/repositories/water_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider((_) => getIt<SettingsRepository>());
final exerciseRepositoryProvider = Provider((_) => getIt<ExerciseRepository>());
final affirmationRepositoryProvider = Provider((_) => getIt<AffirmationRepository>());
final journalRepositoryProvider = Provider((_) => getIt<JournalRepository>());
final moodRepositoryProvider = Provider((_) => getIt<MoodRepository>());
final breathingRepositoryProvider = Provider((_) => getIt<BreathingRepository>());
final reminderRepositoryProvider = Provider((_) => getIt<ReminderRepository>());
final waterRepositoryProvider = Provider((_) => getIt<WaterRepository>());
final progressRepositoryProvider = Provider((_) => getIt<ProgressRepository>());
final aiServiceProvider = Provider<AIService>((_) => getIt<AIService>());

final settingsStreamProvider = StreamProvider((ref) => ref.watch(settingsRepositoryProvider).watchSettings());

final wellnessScoreProvider = FutureProvider((ref) => ref.watch(progressRepositoryProvider).wellnessScore());
final streakProvider = FutureProvider((ref) => ref.watch(progressRepositoryProvider).streakDays());
final todayAffirmationProvider = FutureProvider((ref) => ref.watch(affirmationRepositoryProvider).todayAffirmation());
final waterTodayProvider = FutureProvider((ref) => ref.watch(waterRepositoryProvider).todayGlasses());
final latestMoodProvider = FutureProvider((ref) => ref.watch(moodRepositoryProvider).latest());
