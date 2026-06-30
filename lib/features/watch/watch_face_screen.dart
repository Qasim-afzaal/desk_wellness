import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/database/app_database.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// In-app watch face preview + sync hub (mirrors I Am Wear OS experience).
class WatchFaceScreen extends ConsumerStatefulWidget {
  const WatchFaceScreen({super.key});

  @override
  ConsumerState<WatchFaceScreen> createState() => _WatchFaceScreenState();
}

class _WatchFaceScreenState extends ConsumerState<WatchFaceScreen> {
  final _pageController = PageController(viewportFraction: 0.88);
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _sync(Affirmation item) async {
    await ref.read(watchSyncServiceProvider).syncAffirmation(
          text: item.content,
          backgroundHex: '#000000',
          index: _index,
        );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final feedAsync = ref.watch(affirmationFeedProvider('all'));
    final watchAsync = ref.watch(watchStatusProvider);
    final time = DateFormat('H:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Watch face'),
        centerTitle: true,
      ),
      body: feedAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No affirmations available'));
          }
          if (_index < items.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _sync(items[_index]));
          }
          return Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              Text(
                'Swipe on your watch — or preview here',
                style: TextStyle(color: c.textMuted),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: items.length,
                  onPageChanged: (i) {
                    HapticFeedback.selectionClick();
                    setState(() => _index = i);
                    _sync(items[i]);
                  },
                  itemBuilder: (context, i) {
                    final item = items[i];
                    final active = i == _index;
                    return AnimatedScale(
                      scale: active ? 1.0 : 0.92,
                      duration: const Duration(milliseconds: 220),
                      child: _WatchFace(
                        text: item.content,
                        time: time,
                        dimmed: !active,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: watchAsync.when(
                  data: (status) {
                    final (supported, paired) = status;
                    return Column(
                      children: [
                        Text(
                          supported
                              ? paired
                                  ? 'Apple Watch paired — affirmations sync as you swipe'
                                  : 'Pair Apple Watch in the Watch app to sync affirmations'
                              : 'Watch sync works on iOS with a paired Apple Watch',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: c.textMuted, height: 1.4),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        FilledButton.icon(
                          onPressed: () => _sync(items[_index]),
                          icon: const Icon(Icons.sync),
                          label: const Text('Send to watch now'),
                        ),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Could not load affirmations')),
      ),
    );
  }
}

class _WatchFace extends StatelessWidget {
  const _WatchFace({required this.text, required this.time, this.dimmed = false});

  final String text;
  final String time;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: dimmed ? 0.55 : 1,
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            border: Border.all(color: Colors.white12, width: 6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              const Spacer(),
              Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cormorantGaramond(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.favorite_border, color: Colors.white24, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
