import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';

/// The 4-frame logo. Plays frame 1 → 4 once, then rests on the last frame.
///
/// Frames come from [AppAssets.logoFrames] (or [AppAssets.logoFramesDark] in
/// dark mode), so swapping the images never touches this file.
class AnimatedLogo extends StatefulWidget {
  final double size;

  /// Play the sequence once when the logo first appears.
  final bool playOnMount;

  /// Replay whenever the pointer enters.
  final bool playOnHover;

  /// Tap action. When null, a tap replays the animation.
  final VoidCallback? onTap;

  final BorderRadius borderRadius;

  const AnimatedLogo({
    super.key,
    required this.size,
    this.playOnMount = false,
    this.playOnHover = true,
    this.onTap,
    this.borderRadius = AppRadius.brMd,
  });

  @override
  State<AnimatedLogo> createState() => AnimatedLogoState();
}

class AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.logoFrame * AppAssets.logoFrames.length,
  );

  bool _precached = false;

  @override
  void initState() {
    super.initState();

    if (widget.playOnMount) {
      Future<void>.delayed(const Duration(milliseconds: 200), play);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load every frame up front so the sequence never flickers on first play.
    if (!_precached) {
      _precached = true;
      for (final path in {
        ...AppAssets.logoFrames,
        ...AppAssets.logoFramesDark,
      }) {
        precacheImage(AssetImage(path), context, onError: (_, _) {});
      }
    }
  }

  /// Plays the sequence from frame 1. Safe to call at any time.
  void play() {
    if (!mounted || context.reduceMotion) return;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final frames =
        context.isDark ? AppAssets.logoFramesDark : AppAssets.logoFrames;

    return Semantics(
      label: 'Yash Khade logo',
      image: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: widget.playOnHover ? (_) => play() : null,
        child: GestureDetector(
          onTap: widget.onTap ?? play,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value;
              final playing = _controller.isAnimating;

              // Resting state is the last frame.
              final index = playing
                  ? (t * frames.length).floor().clamp(0, frames.length - 1).toInt()
                  : frames.length - 1;

              // A small pulse while playing, so the sequence reads as motion
              // even while all four frames are the same placeholder.
              final scale = playing ? 1 + 0.05 * math.sin(math.pi * t) : 1.0;

              return Transform.scale(
                scale: scale,
                child: SizedBox.square(
                  dimension: widget.size,
                  child: ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: Image.asset(
                      frames[index],
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      errorBuilder: (context, _, _) => _fallback(context),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _fallback(BuildContext context) {
    return ColoredBox(
      color: context.cs.surfaceContainerHighest,
      child: Center(
        child: Text(
          'YK',
          style: AppTypography.titleLg.copyWith(
            fontSize: widget.size * 0.36,
            color: context.ink(AppColors.emphasisBody),
          ),
        ),
      ),
    );
  }
}
