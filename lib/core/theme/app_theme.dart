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

  static const light = AppColors(
    background: Color(0xFFF7F8FC),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFF0F3FA),
    primary: Color(0xFF6B7FD7),
    primarySoft: Color(0xFFE8ECFA),
    secondary: Color(0xFF9B8FD9),
    textPrimary: Color(0xFF1A1D26),
    textSecondary: Color(0xFF5C6370),
    textMuted: Color(0xFF9AA3B2),
    border: Color(0xFFE6EAF2),
    success: Color(0xFF4CB894),
    warning: Color(0xFFE8A84C),
    accentBlue: Color(0xFF7EB8DA),
    accentLavender: Color(0xFFC4B5FD),
  );

  static const dark = AppColors(
    background: Color(0xFF0E1117),
    surface: Color(0xFF171B24),
    surfaceElevated: Color(0xFF1F2430),
    primary: Color(0xFF8B9AE8),
    primarySoft: Color(0xFF2A3150),
    secondary: Color(0xFFB8AAEE),
    textPrimary: Color(0xFFF3F5FA),
    textSecondary: Color(0xFFA8B0C0),
    textMuted: Color(0xFF6B7385),
    border: Color(0xFF2A3140),
    success: Color(0xFF5FD4A4),
    warning: Color(0xFFF0B86A),
    accentBlue: Color(0xFF8ECAE6),
    accentLavender: Color(0xFFD4C4FF),
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
  static const pill = 999.0;
}
