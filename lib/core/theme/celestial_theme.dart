import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Sage Dawn palette — calm forest green + warm gold (replaces purple Celestial).
abstract final class CelestialColors {
  static const background = Color(0xFF0D1410);
  static const surface = Color(0xFF152019);
  static const surfaceContainer = Color(0xFF1C2B22);
  static const surfaceContainerHigh = Color(0xFF243528);
  static const surfaceContainerHighest = Color(0xFF2D4034);
  static const onSurface = Color(0xFFEEF4EF);
  static const onSurfaceVariant = Color(0xFFB8C9BE);
  static const accent = Color(0xFF7EC8A8);
  static const button = Color(0xFF3D8B6E);
  static const onButton = Color(0xFFFFFFFF);
  static const primary = button;
  static const onPrimary = onButton;
  static const primaryContainer = Color(0xFF1F4D3A);
  static const secondary = Color(0xFF5BA88C);
  static const tertiary = Color(0xFFE8B84A);
  static const outline = Color(0xFF6B7F72);
  static const outlineVariant = Color(0xFF2E3F34);
  static const glassBorder = Color(0x33FFFFFF);
  static const glassFill = Color(0x1AFFFFFF);
  static const selectedFill = Color(0x333D8B6E);
  static const selectedBorder = Color(0xFF7EC8A8);
}

abstract final class CelestialColorsLight {
  static const background = Color(0xFFF0F5F1);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceContainer = Color(0xFFE6EFE9);
  static const surfaceContainerHigh = Color(0xFFD8E8DE);
  static const onSurface = Color(0xFF142019);
  static const onSurfaceVariant = Color(0xFF4A5F52);
  static const accent = Color(0xFF2D6B52);
  static const button = Color(0xFF2D6B52);
  static const onButton = Color(0xFFFFFFFF);
  static const primary = button;
  static const onPrimary = onButton;
  static const primaryContainer = Color(0xFFC8E6D4);
  static const secondary = Color(0xFF4A9B7A);
  static const tertiary = Color(0xFFC9860A);
  static const outline = Color(0xFF9BB5A6);
  static const outlineVariant = Color(0xFFD0DDD4);
  static const glassBorder = Color(0x402D6B52);
  static const glassFill = Color(0xE6FFFFFF);
  static const selectedFill = Color(0xFFC8E6D4);
  static const selectedBorder = Color(0xFF2D6B52);
}

abstract final class CelestialPalette {
  static Color background(Brightness b) =>
      b == Brightness.dark ? CelestialColors.background : CelestialColorsLight.background;

  static Color surface(Brightness b) =>
      b == Brightness.dark ? CelestialColors.surface : CelestialColorsLight.surface;

  static Color onSurface(Brightness b) =>
      b == Brightness.dark ? CelestialColors.onSurface : CelestialColorsLight.onSurface;

  static Color onSurfaceVariant(Brightness b) =>
      b == Brightness.dark ? CelestialColors.onSurfaceVariant : CelestialColorsLight.onSurfaceVariant;

  static Color accent(Brightness b) =>
      b == Brightness.dark ? CelestialColors.accent : CelestialColorsLight.accent;

  static Color button(Brightness b) =>
      b == Brightness.dark ? CelestialColors.button : CelestialColorsLight.button;

  static Color tertiary(Brightness b) =>
      b == Brightness.dark ? CelestialColors.tertiary : CelestialColorsLight.tertiary;

  static Color glassFill(Brightness b) =>
      b == Brightness.dark ? CelestialColors.glassFill : CelestialColorsLight.glassFill;

  static Color glassBorder(Brightness b) =>
      b == Brightness.dark ? CelestialColors.glassBorder : CelestialColorsLight.glassBorder;

  static Color selectedFill(Brightness b) =>
      b == Brightness.dark ? CelestialColors.selectedFill : CelestialColorsLight.selectedFill;

  static Color selectedBorder(Brightness b) =>
      b == Brightness.dark ? CelestialColors.selectedBorder : CelestialColorsLight.selectedBorder;

  static RadialGradient backdrop(Brightness b) => b == Brightness.dark
      ? const RadialGradient(
          center: Alignment(-0.6, -0.8),
          radius: 1.6,
          colors: [Color(0x553D8B6E), Color(0x221F4D3A), Color(0xFF0D1410)],
          stops: [0.0, 0.45, 1.0],
        )
      : const RadialGradient(
          center: Alignment(-0.5, -0.7),
          radius: 1.5,
          colors: [Color(0x88C8E6D4), Color(0x44E6EFE9), Color(0xFFF0F5F1)],
          stops: [0.0, 0.5, 1.0],
        );
}

abstract final class CelestialGradients {
  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A9B7A), Color(0xFF2D6B52)],
  );

  static const primaryLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5BA88C), Color(0xFF2D6B52)],
  );

  static const cardGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1A7EC8A8), Color(0x0D3D8B6E)],
  );

  static const shimmer = LinearGradient(
    colors: [Color(0xFF7EC8A8), Color(0xFFE8B84A), Color(0xFF5BA88C)],
  );

  static LinearGradient button(Brightness b) => b == Brightness.dark ? primary : primaryLight;
}

abstract final class CelestialTypography {
  static TextStyle displayAffirmation({Color? color, bool italic = true, Brightness? brightness}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.35,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        letterSpacing: -0.02,
        color: color ?? CelestialPalette.onSurface(brightness ?? Brightness.dark),
      );

  static TextStyle headlineLg({Color? color, Brightness? brightness}) => GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color ?? CelestialPalette.onSurface(brightness ?? Brightness.dark),
      );

  static TextStyle labelCaps({Color? color, Brightness? brightness}) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: color ?? CelestialPalette.onSurfaceVariant(brightness ?? Brightness.dark),
      );

  static TextStyle bodyMd({Color? color, Brightness? brightness}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color ?? CelestialPalette.onSurfaceVariant(brightness ?? Brightness.dark),
      );
}
