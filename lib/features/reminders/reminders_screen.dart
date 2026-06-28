import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(reminderRepositoryProvider).watchAll();
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: StreamBuilder<List<Reminder>>(
        stream: stream,
        builder: (context, snap) {
          final list = snap.data ?? [];
          if (list.isEmpty) {
            return const Center(child: Text('No reminders configured'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final r = list[i];
              return SwitchListTile(
                title: Text(r.title),
                subtitle: Text('${r.type} · ${r.timeOfDay}'),
                value: r.enabled,
                onChanged: (v) => ref.read(reminderRepositoryProvider).toggle(r.id, v),
              );
            },
          );
        },
      ),
    );
  }
}
