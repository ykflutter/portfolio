import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_durations.dart';

/// Four corner brackets that snap in around a child — the game-HUD
/// "target locked" cue used on hover.
///
/// Purely decorative: it ignores pointers and never changes layout.
class HudCorners extends StatelessWidget {
  final bool visible;
  final Widget child;

  /// Length of each bracket arm.
  final double length;

  /// Distance outside the child's edge when fully shown.
  final double gap;

  final double stroke;
  final Color? color;

  const HudCorners({
    super.key,
    required this.visible,
    required this.child,
    this.length = 10,
    this.gap = 5,
    this.stroke = 1.5,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ink = color ?? context.cs.onSurface;
    final reduce = context.reduceMotion;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: visible ? 1 : 0),
              duration: reduce ? Duration.zero : AppDurations.fast,
              curve: AppDurations.ease,
              builder: (context, t, _) {
                if (t == 0) return const SizedBox.shrink();

                return CustomPaint(
                  painter: _CornerPainter(
                    progress: t,
                    color: ink,
                    length: length,
                    gap: gap,
                    stroke: stroke,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CornerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double length;
  final double gap;
  final double stroke;

  const _CornerPainter({
    required this.progress,
    required this.color,
    required this.length,
    required this.gap,
    required this.stroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Brackets start 8px further out and slide in as they fade up.
    final spread = gap + (1 - progress) * 8;
    final r = (Offset.zero & size).inflate(spread);
    final l = length;

    final paint = Paint()
      ..color = color.withValues(alpha: color.a * progress)
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final path = Path()
      // top-left
      ..moveTo(r.left, r.top + l)
      ..lineTo(r.left, r.top)
      ..lineTo(r.left + l, r.top)
      // top-right
      ..moveTo(r.right - l, r.top)
      ..lineTo(r.right, r.top)
      ..lineTo(r.right, r.top + l)
      // bottom-right
      ..moveTo(r.right, r.bottom - l)
      ..lineTo(r.right, r.bottom)
      ..lineTo(r.right - l, r.bottom)
      // bottom-left
      ..moveTo(r.left + l, r.bottom)
      ..lineTo(r.left, r.bottom)
      ..lineTo(r.left, r.bottom - l);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.length != length ||
      old.gap != gap ||
      old.stroke != stroke;
}
