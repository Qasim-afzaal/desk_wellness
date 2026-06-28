import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodTrackerScreen extends ConsumerStatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  ConsumerState<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends ConsumerState<MoodTrackerScreen> {
  double _mood = 3;
  double _stress = 3;
  double _energy = 3;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final moods = ref.watch(moodRepositoryProvider).watchRecent(limit: 14);

    return Scaffold(
      appBar: AppBar(title: const Text('Mood tracker')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _SliderRow(label: 'Mood', value: _mood, onChanged: (v) => setState(() => _mood = v)),
          _SliderRow(label: 'Stress', value: _stress, onChanged: (v) => setState(() => _stress = v)),
          _SliderRow(label: 'Energy', value: _energy, onChanged: (v) => setState(() => _energy = v)),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: 'Save check-in',
            onPressed: () async {
              await ref.read(moodRepositoryProvider).record(
                    mood: _mood.round(),
                    stress: _stress.round(),
                    energy: _energy.round(),
                  );
              ref.invalidate(latestMoodProvider);
              if (mounted) Navigator.pop(context);
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(title: 'Recent trend'),
          SizedBox(
            height: 180,
            child: StreamBuilder<List<Mood>>(
              stream: moods,
              builder: (context, snap) {
                final list = (snap.data ?? []).reversed.toList();
                if (list.isEmpty) {
                  return Center(child: Text('Log mood to see trends', style: TextStyle(color: c.textSecondary)));
                }
                return LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [for (var i = 0; i < list.length; i++) FlSpot(i.toDouble(), list[i].moodLevel.toDouble())],
                        isCurved: true,
                        color: c.primary,
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.round()}/5', style: const TextStyle(fontWeight: FontWeight.w600)),
        Slider(value: value, min: 1, max: 5, divisions: 4, onChanged: onChanged),
      ],
    );
  }
}
