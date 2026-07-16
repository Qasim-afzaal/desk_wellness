import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.onTap, this.padding});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Material(
      color: c.surface,
      elevation: 0,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: c.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.expanded = true});

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final btn = FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      ),
      child: Text(label),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, required this.subtitle, this.action});

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(color: c.primarySoft, shape: BoxShape.circle),
              child: Icon(icon, size: 40, color: c.primary),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.sm),
            Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: c.textSecondary)),
            if (action != null) ...[const SizedBox(height: AppSpacing.lg), action!],
          ],
        ),
      ),
    );
  }
}

ThemeData buildAppTheme({required Brightness brightness}) {
  final colors = brightness == Brightness.dark ? AppColors.dark : AppColors.light;
  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: colors.buttonPrimary,
    onPrimary: colors.onPrimary,
    primaryContainer: colors.primarySoft,
    onPrimaryContainer: colors.textPrimary,
    secondary: colors.secondary,
    onSecondary: colors.onPrimary,
    surface: colors.surface,
    onSurface: colors.textPrimary,
    onSurfaceVariant: colors.textSecondary,
    outline: colors.border,
    error: const Color(0xFFE57373),
    onError: Colors.white,
  );

  TextTheme textTheme;
  try {
    final displayFont = brightness == Brightness.dark
        ? GoogleFonts.playfairDisplayTextTheme()
        : GoogleFonts.interTextTheme();
    textTheme = displayFont.apply(bodyColor: colors.textPrimary, displayColor: colors.textPrimary).copyWith(
          titleLarge: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700, color: colors.textPrimary, fontSize: 24),
          titleMedium: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600, color: colors.textPrimary, fontSize: 18),
          bodyLarge: GoogleFonts.inter(color: colors.textSecondary, fontSize: 16),
          bodyMedium: GoogleFonts.inter(color: colors.textSecondary, fontSize: 14),
          labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: colors.textPrimary),
        );
  } catch (_) {
    textTheme = ThemeData(brightness: brightness).textTheme.apply(
          bodyColor: colors.textPrimary,
          displayColor: colors.textPrimary,
        );
  }

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.background,
    extensions: [colors],
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colors.surface.withValues(alpha: brightness == Brightness.dark ? 0.6 : 0.9),
      foregroundColor: colors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: colors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: colors.border.withValues(alpha: 0.5)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      hintStyle: TextStyle(color: colors.textMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        borderSide: BorderSide(color: colors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        borderSide: BorderSide(color: colors.buttonPrimary, width: 2),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: colors.primary,
      textColor: colors.textPrimary,
    ),
    iconTheme: IconThemeData(color: colors.primary),
    dividerColor: colors.border,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surface,
      indicatorColor: colors.primarySoft,
      labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 12, color: colors.textSecondary)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colors.buttonPrimary,
        foregroundColor: colors.onPrimary,
        disabledBackgroundColor: colors.buttonPrimary.withValues(alpha: 0.35),
        disabledForegroundColor: colors.onPrimary.withValues(alpha: 0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
        minimumSize: const Size(0, 54),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.textPrimary,
        side: BorderSide(color: colors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
        minimumSize: const Size(0, 54),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: colors.surface,
      selectedColor: colors.buttonPrimary,
      checkmarkColor: colors.onPrimary,
      deleteIconColor: colors.onPrimary,
      labelStyle: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600),
      secondarySelectedColor: colors.buttonPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      side: BorderSide(color: colors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colors.surfaceElevated,
      contentTextStyle: TextStyle(color: colors.textPrimary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.buttonPrimary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colors.buttonPrimary,
      foregroundColor: colors.onPrimary,
    ),
  );
}
