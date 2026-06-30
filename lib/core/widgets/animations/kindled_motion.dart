import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

export 'package:flutter_animate/flutter_animate.dart';

extension KindledAnimateX on Widget {
  Widget fadeSlideIn({Duration delay = Duration.zero, Offset offset = const Offset(0, 0.08)}) {
    return animate(delay: delay)
        .fadeIn(duration: 450.ms, curve: Curves.easeOutCubic)
        .slideY(begin: offset.dy, end: 0, duration: 450.ms, curve: Curves.easeOutCubic);
  }

  Widget staggerIn(int index) => fadeSlideIn(delay: (60 * index).ms);
}
