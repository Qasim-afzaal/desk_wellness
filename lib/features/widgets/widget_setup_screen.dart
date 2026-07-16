import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/widgets/kindled_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WidgetSetupScreen extends ConsumerStatefulWidget {
  const WidgetSetupScreen({super.key});

  @override
  ConsumerState<WidgetSetupScreen> createState() => _WidgetSetupScreenState();
}

class _WidgetSetupScreenState extends ConsumerState<WidgetSetupScreen> {
  static const _styles = [
    _WidgetStyle(
      id: 'sage',
      name: 'Sage',
      background: Color(0xFFD4E2D0),
      text: Color(0xFF17372A),
      accent: Color(0xFF2F7D64),
      backgroundHex: '#D4E2D0',
      textHex: '#17372A',
      accentHex: '#2F7D64',
    ),
    _WidgetStyle(
      id: 'forest',
      name: 'Forest',
      background: Color(0xFF17372A),
      text: Color(0xFFF7F3E8),
      accent: Color(0xFFF2C96D),
      backgroundHex: '#17372A',
      textHex: '#F7F3E8',
      accentHex: '#F2C96D',
    ),
    _WidgetStyle(
      id: 'dawn',
      name: 'Dawn',
      background: Color(0xFFF3E7CE),
      text: Color(0xFF493B2E),
      accent: Color(0xFFD89B54),
      backgroundHex: '#F3E7CE',
      textHex: '#493B2E',
      accentHex: '#D89B54',
    ),
    _WidgetStyle(
      id: 'rose',
      name: 'Rose',
      background: Color(0xFFE9D7DB),
      text: Color(0xFF4E3038),
      accent: Color(0xFFB56A7A),
      backgroundHex: '#E9D7DB',
      textHex: '#4E3038',
      accentHex: '#B56A7A',
    ),
  ];

  late final TextEditingController _textController;
  int _selectedStyle = 0;
  bool _showBrand = true;
  bool _saving = false;
  bool _seededFromToday = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: 'I am enough.');
    _textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _seedFromTodayIfNeeded(String? todayText) {
    if (_seededFromToday || todayText == null || todayText.trim().isEmpty) return;
    _seededFromToday = true;
    _textController.text = todayText;
  }

  Future<void> _saveWidget({required bool pin}) async {
    if (_saving) return;
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter an affirmation for your widget')),
      );
      return;
    }

    setState(() => _saving = true);
    final style = _styles[_selectedStyle];
    await ref.read(widgetServiceProvider).updateAffirmation(
          text: text,
          templateId: style.id,
          backgroundHex: style.backgroundHex,
          textColorHex: style.textHex,
          accentHex: style.accentHex,
          showBrand: _showBrand,
        );

    var pinned = false;
    if (pin) {
      pinned = await ref.read(widgetServiceProvider).requestPinWidget();
    }

    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          pin
              ? (pinned
                  ? 'Widget ready — confirm placement on your home screen'
                  : 'Widget saved — add Affirfesting from your widget gallery')
              : 'Widget text updated',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final affirmationAsync = ref.watch(todayAffirmationProvider);
    final watchAsync = ref.watch(watchStatusProvider);
    final todayText = affirmationAsync.valueOrNull?.content;
    _seedFromTodayIfNeeded(todayText);
    final style = _styles[_selectedStyle];
    final previewText =
        _textController.text.trim().isEmpty ? 'Write your affirmation…' : _textController.text.trim();

    return KindledScreen(
      title: 'Widgets & Watch',
      showBack: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customizable widgets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Edit the affirmation, choose a look, then save it to your home screen.',
              style: TextStyle(color: c.textMuted, height: 1.4),
            ),
            const SizedBox(height: AppSpacing.lg),
            _PreviewCard(
              text: previewText,
              style: style,
              showBrand: _showBrand,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Widget text',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _textController,
              maxLines: 4,
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Type the affirmation for your home widget',
                filled: true,
                fillColor: c.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide(color: c.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide(color: c.border),
                ),
              ),
            ),
            if (todayText != null && todayText.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => setState(() => _textController.text = todayText),
                  icon: const Icon(Icons.auto_awesome, size: 18),
                  label: const Text('Use today’s affirmation'),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Text(
              'Widget style',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_styles.length, (index) {
                  final option = _styles[index];
                  final selected = index == _selectedStyle;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedStyle = index),
                      avatar: CircleAvatar(backgroundColor: option.background),
                      label: Text(option.name),
                    ),
                  );
                }),
              ),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _showBrand,
              onChanged: (value) => setState(() => _showBrand = value),
              title: const Text('Show Affirfesting name'),
              subtitle: const Text('Display the brand above the affirmation'),
            ),
            const SizedBox(height: AppSpacing.sm),
            KindledPrimaryButton(
              label: _saving ? 'Saving…' : 'Save & add home widget',
              icon: Icons.widgets_outlined,
              onPressed: _saving ? null : () => _saveWidget(pin: true),
            ),
            const SizedBox(height: AppSpacing.sm),
            KindledSecondaryButton(
              label: 'Update widget text only',
              icon: Icons.save_outlined,
              onPressed: _saving ? null : () => _saveWidget(pin: false),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Watch support',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            watchAsync.when(
              data: (status) {
                final (supported, paired) = status;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supported
                          ? paired
                              ? 'Apple Watch paired — affirmations sync when you swipe'
                              : 'Watch supported — pair a watch to sync affirmations'
                          : 'Watch sync works on iPhone with a paired Apple Watch',
                      style: TextStyle(color: c.textMuted, height: 1.4),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    KindledSecondaryButton(
                      label: 'Preview watch face',
                      icon: Icons.watch_outlined,
                      onPressed: () => context.push('/watch'),
                    ),
                    if (supported && paired) ...[
                      const SizedBox(height: AppSpacing.sm),
                      KindledSecondaryButton(
                        label: 'Sync now',
                        onPressed: () async {
                          final text = _textController.text.trim().isEmpty
                              ? (todayText ?? 'I am enough.')
                              : _textController.text.trim();
                          await ref.read(watchSyncServiceProvider).syncAffirmation(
                                text: text,
                                backgroundHex: '#000000',
                              );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sent to watch')),
                            );
                          }
                        },
                      ),
                    ],
                  ],
                );
              },
              loading: () => Text('Checking watch…', style: TextStyle(color: c.textMuted)),
              error: (_, __) => Text('Watch status unavailable', style: TextStyle(color: c.textMuted)),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Native Apple Watch app included. Swipe affirmations on iPhone — they appear on your watch automatically.',
              style: TextStyle(color: c.textMuted, fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.text,
    required this.style,
    required this.showBrand,
  });

  final String text;
  final _WidgetStyle style;
  final bool showBrand;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          if (showBrand) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_awesome, color: style.accent, size: 16),
                const SizedBox(width: 6),
                Text(
                  'AFFIRFESTING',
                  style: TextStyle(
                    color: style.text.withValues(alpha: 0.72),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: style.text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetStyle {
  const _WidgetStyle({
    required this.id,
    required this.name,
    required this.background,
    required this.text,
    required this.accent,
    required this.backgroundHex,
    required this.textHex,
    required this.accentHex,
  });

  final String id;
  final String name;
  final Color background;
  final Color text;
  final Color accent;
  final String backgroundHex;
  final String textHex;
  final String accentHex;
}
