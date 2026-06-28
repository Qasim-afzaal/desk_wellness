/// AI-ready abstraction. Replace [MockAIService] with a cloud provider later.
abstract class AIService {
  Future<String> dailyInsight({
    required int wellnessScore,
    required int streakDays,
    required String goals,
  });

  Future<String> moodInsight({required List<int> recentMoodLevels});

  Future<String> journalPrompt({required String moodLabel});
}

class MockAIService implements AIService {
  @override
  Future<String> dailyInsight({
    required int wellnessScore,
    required int streakDays,
    required String goals,
  }) async {
    if (streakDays >= 7) {
      return 'Your $streakDays-day streak shows real commitment. A short neck release would complement your goals today.';
    }
    if (wellnessScore < 50) {
      return 'Start with a 90-second breathing reset, then one desk stretch. Small wins build momentum.';
    }
    return 'You are on track. Keep your next break under five minutes and stay hydrated.';
  }

  @override
  Future<String> moodInsight({required List<int> recentMoodLevels}) async {
    if (recentMoodLevels.isEmpty) {
      return 'Log your mood today to unlock personalized insights.';
    }
    final avg = recentMoodLevels.reduce((a, b) => a + b) / recentMoodLevels.length;
    if (avg < 3) {
      return 'Stress may be building. Try box breathing before your next meeting.';
    }
    return 'Your mood trend is stable. A focus reset could help you finish strong.';
  }

  @override
  Future<String> journalPrompt({required String moodLabel}) async {
    return 'What helped you feel $moodLabel at work today? What would you do differently tomorrow?';
  }
}
