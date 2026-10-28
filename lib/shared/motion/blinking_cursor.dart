import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';

/// A terminal-style caret that blinks after a line of text.
class BlinkingCursor extends StatefulWidget {
  final double height;
  final double width;

  const BlinkingCursor({super.key, this.height = 18, this.width = 2});

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1060),
  )..repeat();

  // Hard on/off rather than a fade — that is what reads as a caret.
  late final Animation<double> _blink = CurvedAnimation(
    parent: _controller,
    curve: const Threshold(0.5),
  ).drive(Tween<double>(begin: 1, end: 0));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final caret = Container(
      width: widget.width,
      height: widget.height,
      color: context.cs.onSurface,
    );

    if (context.reduceMotion) return caret;

    return FadeTransition(opacity: _blink, child: caret);
  }
}
