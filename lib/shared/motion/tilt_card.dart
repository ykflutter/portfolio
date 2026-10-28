import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';

/// A tappable card that tilts a few degrees toward the cursor, with a soft
/// spotlight following the pointer. On touch it simply presses in.
///
/// [builder] receives the hover state, so the card can show HUD corners,
/// zoom its image, and so on.
class TiltCard extends StatefulWidget {
  final Widget Function(BuildContext context, bool hovered) builder;
  final VoidCallback? onTap;

  /// Peak rotation, in degrees.
  final double maxTilt;
  final BorderRadius radius;

  /// Read by screen readers — "Open Crypto Exchange case study".
  final String? semanticLabel;

  const TiltCard({
    super.key,
    required this.builder,
    this.onTap,
    this.maxTilt = 4,
    this.radius = AppRadius.brMd,
    this.semanticLabel,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  /// Pointer position normalised to -1…1 on each axis. Null when outside.
  Offset? _pointer;
  bool _pressed = false;

  bool get _hovered => _pointer != null;

  void _onHover(Offset local) {
    final size = context.size;
    if (size == null || size.isEmpty) return;

    setState(() {
      _pointer = Offset(
        (local.dx / size.width) * 2 - 1,
        (local.dy / size.height) * 2 - 1,
      );
    });
  }

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final reduce = context.reduceMotion;
    final p = _pointer ?? Offset.zero;
    final rad = widget.maxTilt * math.pi / 180;

    // Rotate around X by vertical position and Y by horizontal, so the edge
    // nearest the cursor dips toward it.
    final tilt = reduce ? Offset.zero : Offset(-p.dy * rad, p.dx * rad);

    return Semantics(
      button: widget.onTap != null,
      label: widget.semanticLabel,
      child: MouseRegion(
        cursor: widget.onTap == null
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        onHover: (e) => _onHover(e.localPosition),
        onExit: (_) => setState(() => _pointer = null),
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          child: TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(begin: Offset.zero, end: tilt),
            duration: AppDurations.instant,
            curve: AppDurations.ease,
            builder: (context, t, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0012)
                  ..rotateX(t.dx)
                  ..rotateY(t.dy),
                child: child,
              );
            },
            child: AnimatedScale(
              scale: _pressed ? 0.98 : 1,
              duration: AppDurations.instant,
              curve: AppDurations.ease,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  widget.builder(context, _hovered),
                  if (!reduce)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          opacity: _hovered ? 1 : 0,
                          duration: AppDurations.fast,
                          child: ClipRRect(
                            borderRadius: widget.radius,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  center: Alignment(p.dx, p.dy),
                                  radius: 0.9,
                                  colors: [
                                    context.palette.glow,
                                    context.palette.glow.withValues(alpha: 0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
