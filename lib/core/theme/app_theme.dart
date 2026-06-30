import 'package:flutter/material.dart';

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
  final Color cardPink;
  final Color cardSage;
  final Color cardYellow;
  final Color cardForest;

  static const light = AppColors(
    background: Color(0xFFF5F0E8),
    surface: Color(0xFFFFFBF7),
    surfaceElevated: Color(0xFFEDE8DF),
    primary: Color(0xFF3D5A45),
    primarySoft: Color(0xFFD4E2D0),
    secondary: Color(0xFFE8C4C4),
    textPrimary: Color(0xFF1C1C1C),
    textSecondary: Color(0xFF5C5C5C),
    textMuted: Color(0xFF9A9488),
    border: Color(0xFFE5DDD2),
    success: Color(0xFF6B8F71),
    warning: Color(0xFFE8A84C),
    accentBlue: Color(0xFFD8DCE8),
    accentLavender: Color(0xFFE8C4C4),
    cardPink: Color(0xFFF2D4D4),
    cardSage: Color(0xFFD4E2D0),
    cardYellow: Color(0xFFF5E6A8),
    cardForest: Color(0xFF3D5A45),
  );

  static const dark = AppColors(
    background: Color(0xFF1A1A18),
    surface: Color(0xFF242420),
    surfaceElevated: Color(0xFF2E2E28),
    primary: Color(0xFF8FB396),
    primarySoft: Color(0xFF3D5A45),
    secondary: Color(0xFFC9A0A0),
    textPrimary: Color(0xFFF5F0E8),
    textSecondary: Color(0xFFB8B2A8),
    textMuted: Color(0xFF7A756C),
    border: Color(0xFF3A3A34),
    success: Color(0xFF8FB396),
    warning: Color(0xFFE8A84C),
    accentBlue: Color(0xFF5A6078),
    accentLavender: Color(0xFF8A7070),
    cardPink: Color(0xFF5A4040),
    cardSage: Color(0xFF3D5A45),
    cardYellow: Color(0xFF5A5230),
    cardForest: Color(0xFF2A3D30),
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
