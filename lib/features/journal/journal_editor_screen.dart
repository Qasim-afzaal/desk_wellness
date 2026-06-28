import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JournalEditorScreen extends ConsumerStatefulWidget {
  const JournalEditorScreen({super.key});

  @override
  ConsumerState<JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends ConsumerState<JournalEditorScreen> {
  final _title = TextEditingController();
  final _body = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New entry'),
        actions: [
          TextButton(
            onPressed: () async {
              if (_body.text.trim().isEmpty) return;
              await ref.read(journalRepositoryProvider).save(title: _title.text, body: _body.text);
              await ref.read(progressRepositoryProvider).unlockAchievement('journal_start');
              if (context.mounted) context.pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            TextField(controller: _title, decoration: const InputDecoration(hintText: 'Title')),
            const SizedBox(height: AppSpacing.md),
            Expanded(child: TextField(controller: _body, maxLines: null, expands: true, decoration: const InputDecoration(hintText: 'How was your day?'))),
          ],
        ),
      ),
    );
  }
}
