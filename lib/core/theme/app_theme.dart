import 'package:flutter/material.dart';

import 'celestial_theme.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.primary,
    required this.primarySoft,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.success,
    required this.warning,
    required this.accentBlue,
    required this.accentLavender,
    required this.onPrimary,
    required this.buttonPrimary,
    required this.cardPink,
    required this.cardSage,
    required this.cardYellow,
    required this.cardForest,
  });

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color primary;
  final Color primarySoft;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color success;
  final Color warning;
  final Color accentBlue;
  final Color accentLavender;
  final Color onPrimary;
  final Color buttonPrimary;
  final Color cardPink;
  final Color cardSage;
  final Color cardYellow;
  final Color cardForest;

  static const light = AppColors(
    background: CelestialColorsLight.background,
    surface: CelestialColorsLight.surface,
    surfaceElevated: CelestialColorsLight.surfaceContainer,
    primary: CelestialColorsLight.accent,
    primarySoft: CelestialColorsLight.selectedFill,
    secondary: CelestialColorsLight.secondary,
    textPrimary: CelestialColorsLight.onSurface,
    textSecondary: CelestialColorsLight.onSurfaceVariant,
    textMuted: Color(0xFF8A7A9A),
    border: CelestialColorsLight.outlineVariant,
    success: Color(0xFF5A9E6E),
    warning: CelestialColorsLight.tertiary,
    accentBlue: Color(0xFFD8DCE8),
    accentLavender: CelestialColorsLight.accent,
    onPrimary: CelestialColorsLight.onButton,
    buttonPrimary: CelestialColorsLight.button,
    cardPink: Color(0xFFF2E0F5),
    cardSage: Color(0xFFE8F0E4),
    cardYellow: Color(0xFFFFF3CC),
    cardForest: Color(0xFF2D6B52),
  );

  static const dark = AppColors(
    background: CelestialColors.background,
    surface: CelestialColors.surface,
    surfaceElevated: CelestialColors.surfaceContainerHigh,
    primary: CelestialColors.accent,
    primarySoft: CelestialColors.selectedFill,
    secondary: CelestialColors.secondary,
    textPrimary: CelestialColors.onSurface,
    textSecondary: CelestialColors.onSurfaceVariant,
    textMuted: CelestialColors.outline,
    border: CelestialColors.outlineVariant,
    success: Color(0xFF8FB396),
    warning: CelestialColors.tertiary,
    accentBlue: Color(0xFF5A6078),
    accentLavender: CelestialColors.accent,
    onPrimary: CelestialColors.onButton,
    buttonPrimary: CelestialColors.button,
    cardPink: Color(0xFF1F4D3A),
    cardSage: CelestialColors.surfaceContainer,
    cardYellow: Color(0xFF5A5230),
    cardForest: CelestialColors.surfaceContainerHighest,
  );

  @override
  AppColors copyWith({Color? background, Color? surface}) => this;

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) => this;
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

abstract final class AppRadius {
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 28.0;
  static const pill = 999.0;
}
