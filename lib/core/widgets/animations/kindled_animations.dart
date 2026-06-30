import 'package:desk_wellness/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

abstract final class KindledAssets {
  static const sunrise = 'assets/lottie/sunrise.json';
  static const successSparkle = 'assets/lottie/success_sparkle.json';
  static const emptyLibrary = 'assets/lottie/empty_library.json';
  static const loadingDots = 'assets/lottie/loading_dots.json';
}

class KindledLottie extends StatelessWidget {
  const KindledLottie({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.repeat = true,
  });

  final String asset;
  final double? width;
  final double? height;
  final bool repeat;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      asset,
      width: width,
      height: height,
      repeat: repeat,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(Icons.auto_awesome, size: height ?? 48, color: context.colors.primary),
    );
  }
}

class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Stack(
      children: [
        Positioned(
          top: -40,
          right: -30,
          child: _Orb(color: c.cardPink.withValues(alpha: 0.45), size: 180),
        ),
        Positioned(
          top: 120,
          left: -50,
          child: _Orb(color: c.cardSage.withValues(alpha: 0.35), size: 140),
        ),
        Positioned(
          bottom: 80,
          right: -20,
          child: _Orb(color: c.cardYellow.withValues(alpha: 0.3), size: 120),
        ),
        child,
      ],
    );
  }
}

class _Orb extends StatefulWidget {
  const _Orb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  State<_Orb> createState() => _OrbState();
}

class _OrbState extends State<_Orb> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 12 * _controller.value),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
          ),
        );
      },
    );
  }
}

class ShimmerCardPlaceholder extends StatefulWidget {
  const ShimmerCardPlaceholder({super.key, this.height = 220});

  final double height;

  @override
  State<ShimmerCardPlaceholder> createState() => _ShimmerCardPlaceholderState();
}

class _ShimmerCardPlaceholderState extends State<ShimmerCardPlaceholder> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * _controller.value, 0),
              end: Alignment(-0.5 + 2 * _controller.value, 0),
              colors: [c.surfaceElevated, c.surface, c.surfaceElevated],
            ),
          ),
          alignment: Alignment.center,
          child: KindledLottie(asset: KindledAssets.loadingDots, width: 80, height: 32),
        );
      },
    );
  }
}

class PulsingAccentDot extends StatefulWidget {
  const PulsingAccentDot({super.key, required this.color, this.size = 48});

  final Color color;
  final double size;

  @override
  State<PulsingAccentDot> createState() => _PulsingAccentDotState();
}

class _PulsingAccentDotState extends State<PulsingAccentDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 0.92 + (_controller.value * 0.12);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
          ),
        );
      },
    );
  }
}

class FloatingPhoneFrame extends StatefulWidget {
  const FloatingPhoneFrame({super.key, required this.child});

  final Widget child;

  @override
  State<FloatingPhoneFrame> createState() => _FloatingPhoneFrameState();
}

class _FloatingPhoneFrameState extends State<FloatingPhoneFrame> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -4 + 8 * _controller.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class SuccessBurstOverlay extends StatefulWidget {
  const SuccessBurstOverlay({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<SuccessBurstOverlay> createState() => _SuccessBurstOverlayState();
}

class _SuccessBurstOverlayState extends State<SuccessBurstOverlay> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) widget.onFinished();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.35),
      child: Center(
        child: KindledLottie(
          asset: KindledAssets.successSparkle,
          width: 180,
          height: 180,
          repeat: false,
        ),
      ),
    );
  }
}

class AnimatedCountText extends StatelessWidget {
  const AnimatedCountText({super.key, required this.value, required this.style});

  final int value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, animated, _) => Text('$animated', style: style),
    );
  }
}
