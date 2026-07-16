import 'dart:io';

import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:desk_wellness/core/widgets/celestial_widgets.dart';
import 'package:desk_wellness/core/widgets/animations/kindled_animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AffirmationCard extends StatelessWidget {
  const AffirmationCard({
    super.key,
    required this.text,
    required this.background,
    required this.accent,
    this.fontStyle = 'calm',
    this.textAlign = 'center',
    this.compact = false,
    this.showAccent = true,
    this.pulseAccent = false,
    this.backgroundImagePath,
    this.backgroundImageUrl,
  });

  final String text;
  final Color background;
  final Color accent;
  final String fontStyle;
  final String textAlign;
  final bool compact;
  final bool showAccent;
  final bool pulseAccent;
  final String? backgroundImagePath;
  final String? backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    final hasImage = (backgroundImagePath != null && File(backgroundImagePath!).existsSync()) ||
        (backgroundImageUrl != null && backgroundImageUrl!.isNotEmpty);
    final onDark = hasImage || background.computeLuminance() < 0.45;
    final textColor = onDark ? Colors.white : const Color(0xFF1C1C1C);

    Alignment alignment;
    switch (textAlign) {
      case 'top':
        alignment = Alignment.topCenter;
      case 'bottom':
        alignment = Alignment.bottomCenter;
      default:
        alignment = Alignment.center;
    }

    final padding = compact ? AppSpacing.sm + 4 : AppSpacing.xl;
    final accentSize = compact ? 28.0 : 48.0;
    final accentGap = compact ? AppSpacing.sm : AppSpacing.lg;
    final radius = BorderRadius.circular(compact ? AppRadius.md : AppRadius.xl);

    final textWidget = compact
        ? Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _fontStyle(fontStyle, compact).copyWith(
              color: textColor,
              height: 1.3,
              fontSize: 15,
              shadows: hasImage
                  ? const [Shadow(blurRadius: 10, color: Colors.black54, offset: Offset(0, 1))]
                  : null,
            ),
          )
        : Align(
            alignment: alignment,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: _fontStyle(fontStyle, compact).copyWith(
                color: textColor,
                height: 1.35,
                fontSize: 24,
                shadows: hasImage
                    ? const [
                        Shadow(blurRadius: 12, color: Colors.black54, offset: Offset(0, 2)),
                        Shadow(blurRadius: 24, color: Colors.black38, offset: Offset(0, 4)),
                      ]
                    : null,
              ),
            ),
          );

    final content = Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (showAccent) ...[
            pulseAccent
                ? PulsingAccentDot(color: accent, size: accentSize)
                : Container(
                    width: accentSize,
                    height: accentSize,
                    decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                  ),
            SizedBox(height: accentGap),
          ],
          if (compact) textWidget else Expanded(child: textWidget),
        ],
      ),
    );

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: background,
          borderRadius: radius,
          image: backgroundImagePath != null && File(backgroundImagePath!).existsSync()
              ? DecorationImage(
                  image: FileImage(File(backgroundImagePath!)),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: hasImage ? 0.32 : 0),
                    BlendMode.darken,
                  ),
                )
              : backgroundImageUrl != null && backgroundImageUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(backgroundImageUrl!),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.32),
                        BlendMode.darken,
                      ),
                    )
                  : null,
        ),
        child: content,
      ),
    );
  }

  static TextStyle _fontStyle(String style, bool compact) {
    switch (style) {
      case 'spirit':
        return GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: compact ? 17 : 22);
      case 'bold':
        return GoogleFonts.oswald(fontWeight: FontWeight.w700, fontSize: compact ? 20 : 26);
      default:
        return GoogleFonts.cormorantGaramond(fontWeight: FontWeight.w600, fontSize: compact ? 22 : 28);
    }
  }
}

class AffirmationCardFromDraft extends StatelessWidget {
  const AffirmationCardFromDraft({
    super.key,
    required this.draft,
    this.compact = false,
    this.showAccent = true,
  });

  final AffirmationDraft draft;
  final bool compact;
  final bool showAccent;

  @override
  Widget build(BuildContext context) {
    return AffirmationCard(
      text: draft.text,
      background: draft.background,
      accent: draft.template.accent,
      fontStyle: draft.fontStyle,
      textAlign: draft.textAlign,
      compact: compact,
      showAccent: showAccent,
      backgroundImagePath: draft.backgroundImagePath,
      backgroundImageUrl: draft.backgroundImageUrl,
    );
  }
}

class AffirmationCardFromTemplate extends StatelessWidget {
  const AffirmationCardFromTemplate({
    super.key,
    required this.template,
    this.text,
    this.compact = false,
  });

  final AffirmationTemplate template;
  final String? text;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AffirmationCard(
      text: text ?? template.sampleText,
      background: template.background,
      accent: template.accent,
      compact: compact,
    );
  }
}

class KindledScreen extends StatelessWidget {
  const KindledScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.bottom,
    this.showBack = false,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? bottom;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;

    return CelestialScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
              child: Row(
                children: [
                  if (showBack)
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: c.textPrimary),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: CelestialTypography.labelCaps(
                        color: c.primary,
                        brightness: brightness,
                      ),
                    ),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            Expanded(child: child),
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key, required this.tabs, required this.selected, required this.onSelected});

  final List<String> tabs;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final active = tab == selected;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ChoiceChip(
              label: Text(tab[0].toUpperCase() + tab.substring(1)),
              selected: active,
              onSelected: (_) => onSelected(tab),
              selectedColor: c.buttonPrimary,
              labelStyle: TextStyle(
                color: active ? c.onPrimary : c.textSecondary,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: c.surface,
              side: BorderSide(color: active ? c.primary : c.border),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class KindledPrimaryButton extends StatelessWidget {
  const KindledPrimaryButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: c.buttonPrimary,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.buttonPrimary.withValues(alpha: 0.35),
          disabledForegroundColor: c.onPrimary.withValues(alpha: 0.6),
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: AppSpacing.sm)],
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class KindledSecondaryButton extends StatelessWidget {
  const KindledSecondaryButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: c.textPrimary,
          minimumSize: const Size(0, 54),
          side: BorderSide(color: c.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: AppSpacing.sm)],
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class StatPill extends StatelessWidget {
  const StatPill({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: c.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: TextStyle(color: c.textMuted, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
