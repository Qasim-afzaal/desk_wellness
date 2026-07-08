import 'dart:ui';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:desk_wellness/core/theme/celestial_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Full-screen celestial gradient backdrop used across the app.
class CelestialScaffold extends StatelessWidget {
  const CelestialScaffold({
    super.key,
    this.backgroundImageUrl,
    this.backgroundImageFile,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
  });

  final String? backgroundImageUrl;
  final String? backgroundImageFile;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: CelestialPalette.background(brightness),
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _CelestialBackdrop(
            brightness: brightness,
            imageUrl: backgroundImageUrl,
            imageFile: backgroundImageFile,
          ),
          body,
        ],
      ),
    );
  }
}

class _CelestialBackdrop extends StatelessWidget {
  const _CelestialBackdrop({required this.brightness, this.imageUrl, this.imageFile});

  final Brightness brightness;
  final String? imageUrl;
  final String? imageFile;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: CelestialPalette.backdrop(brightness),
        color: CelestialPalette.background(brightness),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null)
            CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.45),
              colorBlendMode: BlendMode.darken,
            )
          else if (imageFile != null && File(imageFile!).existsSync())
            Image.file(File(imageFile!), fit: BoxFit.cover),
          // Soft accent orb — top left
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CelestialPalette.accent(brightness).withValues(alpha: brightness == Brightness.dark ? 0.12 : 0.22),
              ),
            ),
          ),
          // Second orb — bottom right
          Positioned(
            bottom: -100,
            right: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CelestialPalette.tertiary(brightness).withValues(alpha: brightness == Brightness.dark ? 0.08 : 0.14),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CelestialPalette.background(brightness).withValues(alpha: brightness == Brightness.dark ? 0.2 : 0.0),
                  CelestialPalette.background(brightness).withValues(alpha: brightness == Brightness.dark ? 0.7 : 0.35),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Frosted glass panel — Stitch edit_set_wallpaper reference.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding,
    this.radius = AppRadius.xl,
    this.glow = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final c = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: CelestialPalette.glassFill(brightness),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: CelestialPalette.glassBorder(brightness)),
            boxShadow: [
              if (brightness == Brightness.light)
                BoxShadow(
                  color: c.buttonPrimary.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              if (glow)
                BoxShadow(
                  color: CelestialPalette.accent(brightness).withValues(alpha: 0.2),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class CelestialPillChip extends StatelessWidget {
  const CelestialPillChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Material(
      color: selected ? c.buttonPrimary : c.surface.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text(
            label.toUpperCase(),
            style: CelestialTypography.labelCaps(
              color: selected ? c.onPrimary : c.textSecondary,
              brightness: Theme.of(context).brightness,
            ),
          ),
        ),
      ),
    );
  }
}

class CelestialPrimaryButton extends StatelessWidget {
  const CelestialPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final btn = DecoratedBox(
      decoration: BoxDecoration(
        gradient: CelestialGradients.button(brightness),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: CelestialPalette.accent(brightness).withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 8)],
                Text(
                  label,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class CelestialGlassSearchBar extends StatelessWidget {
  const CelestialGlassSearchBar({
    super.key,
    required this.controller,
    this.hint = 'Search wallpapers…',
    this.onSubmitted,
    this.onSearch,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brightness = Theme.of(context).brightness;

    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: c.border),
        boxShadow: [
          BoxShadow(
            color: c.buttonPrimary.withValues(alpha: brightness == Brightness.dark ? 0.15 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          Icon(Icons.image_search_outlined, color: c.buttonPrimary, size: 22),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              style: TextStyle(color: c.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: c.textMuted, fontSize: 15),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSearch,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: CelestialGradients.button(brightness),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom nav with frosted glass and lavender active dot — Stitch home reference.
class CelestialBottomNav extends StatelessWidget {
  const CelestialBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (Icons.auto_awesome_outlined, Icons.auto_awesome, 'Affirmations'),
    (Icons.image_search_outlined, Icons.image_search, 'Visual Breath'),
    (Icons.grid_view_outlined, Icons.grid_view, 'Themes'),
    (Icons.favorite_outline, Icons.favorite, 'Favorites'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final c = context.colors;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            color: CelestialPalette.surface(brightness).withValues(alpha: brightness == Brightness.dark ? 0.75 : 0.85),
            border: Border(top: BorderSide(color: c.border.withValues(alpha: 0.6))),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_items.length, (i) {
                  final (outline, filled, _) = _items[i];
                  final active = i == currentIndex;
                  return InkWell(
                    onTap: () => onTap(i),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            active ? filled : outline,
                            color: active ? c.buttonPrimary : c.textMuted,
                            size: 26,
                          ),
                          const SizedBox(height: 4),
                          if (active)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(color: c.buttonPrimary, shape: BoxShape.circle),
                            )
                          else
                            const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CelestialAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CelestialAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.actions,
    this.subtitle,
  });

  final String title;
  final bool showBack;
  final List<Widget>? actions;
  final String? subtitle;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final c = context.colors;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: AppBar(
          backgroundColor: CelestialPalette.surface(brightness).withValues(alpha: brightness == Brightness.dark ? 0.5 : 0.8),
          elevation: 0,
          leading: showBack
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: c.textPrimary),
                  onPressed: () => Navigator.of(context).maybePop(),
                )
              : null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: CelestialTypography.headlineLg(brightness: brightness).copyWith(fontSize: 20)),
              if (subtitle != null) Text(subtitle!, style: CelestialTypography.labelCaps(brightness: brightness)),
            ],
          ),
          actions: actions,
        ),
      ),
    );
  }
}
