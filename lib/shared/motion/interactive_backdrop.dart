import 'dart:ui' show PointMode;

import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';

/// The page background: a faint dot grid, plus a soft glow that follows the
/// cursor on desktop. Sits behind everything and never takes a pointer.
///
/// The pointer is held in a ValueNotifier and painted directly, so moving
/// the mouse repaints one small layer — it never rebuilds the page.
class InteractiveBackdrop extends StatefulWidget {
  final Widget child;

  const InteractiveBackdrop({super.key, required this.child});

  @override
  State<InteractiveBackdrop> createState() => _InteractiveBackdropState();
}

class _InteractiveBackdropState extends State<InteractiveBackdrop> {
  final ValueNotifier<Offset?> _pointer = ValueNotifier<Offset?>(null);

  @override
  void dispose() {
    _pointer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final glow = context.isDesktop && !context.reduceMotion;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: CustomPaint(painter: _DotGridPainter(palette.gridDot)),
            ),
          ),
        ),
        if (glow)
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: _GlowPainter(pointer: _pointer, color: palette.glow),
                ),
              ),
            ),
          ),
        MouseRegion(
          opaque: false,
          onHover: glow ? (e) => _pointer.value = e.localPosition : null,
          onExit: glow ? (_) => _pointer.value = null : null,
          child: widget.child,
        ),
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  final Color color;

  const _DotGridPainter(this.color);

  static const double _spacing = 28;

  @override
  void paint(Canvas canvas, Size size) {
    final points = <Offset>[
      for (var y = _spacing / 2; y < size.height; y += _spacing)
        for (var x = _spacing / 2; x < size.width; x += _spacing) Offset(x, y),
    ];

    canvas.drawPoints(
      PointMode.points,
      points,
      Paint()
        ..color = color
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_DotGridPainter old) => old.color != color;
}

class _GlowPainter extends CustomPainter {
  final ValueNotifier<Offset?> pointer;
  final Color color;

  _GlowPainter({required this.pointer, required this.color})
      : super(repaint: pointer);

  static const double _radius = 320;

  @override
  void paint(Canvas canvas, Size size) {
    final p = pointer.value;
    if (p == null) return;

    final rect = Rect.fromCircle(center: p, radius: _radius);

    canvas.drawCircle(
      p,
      _radius,
      Paint()
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_GlowPainter old) =>
      old.color != color || old.pointer != pointer;
}
