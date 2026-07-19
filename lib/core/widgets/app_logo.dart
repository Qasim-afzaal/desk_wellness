import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:flutter/material.dart';

/// Affirmation logo from `assets/branding/app_logo.png`.
class AffirmationLogo extends StatelessWidget {
  const AffirmationLogo({
    super.key,
    this.size = 120,
    this.showShadow = true,
    this.borderRadius,
  });

  final double size;
  final bool showShadow;
  final BorderRadius? borderRadius;

  static const assetPath = 'assets/branding/app_logo.png';
  static const appName = 'Affirmation';

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(size * 0.22);

    return Container(
      width: size,
      height: size,
      decoration: showShadow
          ? BoxDecoration(
              borderRadius: radius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: size * 0.2,
                  offset: Offset(0, size * 0.06),
                ),
              ],
            )
          : null,
      child: ClipRRect(
        borderRadius: radius,
        child: Image.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(Icons.auto_awesome, size: size * 0.5),
        ),
      ),
    );
  }
}

/// Logo + wordmark row for headers.
class AffirmationBrandMark extends StatelessWidget {
  const AffirmationBrandMark({
    super.key,
    this.logoSize = 36,
    this.titleStyle,
    this.subtitle,
  });

  final double logoSize;
  final TextStyle? titleStyle;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AffirmationLogo(size: logoSize, showShadow: false, borderRadius: BorderRadius.circular(logoSize * 0.22)),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AffirmationLogo.appName, style: titleStyle ?? title),
            if (subtitle != null)
              Text(
                subtitle!,
                style: CelestialTypography.labelCaps(
                  color: Theme.of(context).extension<AppColors>()?.textMuted,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
