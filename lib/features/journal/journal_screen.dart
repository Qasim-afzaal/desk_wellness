import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(journalRepositoryProvider).watchAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        actions: [IconButton(onPressed: () => context.push('/journal/new'), icon: const Icon(Icons.add))],
      ),
      body: StreamBuilder<List<JournalEntry>>(
        stream: stream,
        builder: (context, snap) {
          final entries = snap.data ?? [];
          if (entries.isEmpty) {
            return EmptyState(
              icon: Icons.edit_note,
              title: 'Start reflecting',
              subtitle: 'Capture thoughts, wins, and lessons from your work day.',
              action: PrimaryButton(label: 'Write entry', expanded: false, onPressed: () => context.push('/journal/new')),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) {
              final e = entries[i];
              return AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.title.isEmpty ? 'Untitled' : e.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(e.body, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: context.colors.textSecondary)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
