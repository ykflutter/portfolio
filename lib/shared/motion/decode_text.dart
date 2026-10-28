import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_durations.dart';

/// Text that "decodes" letter by letter from random glyphs, like a game boot
/// screen. Space is reserved for the final text from the first frame, so the
/// layout never jumps while it resolves.
class DecodeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final Duration delay;
  final TextAlign textAlign;

  const DecodeText(
    this.text, {
    super.key,
    required this.style,
    this.duration = AppDurations.decode,
    this.delay = Duration.zero,
    this.textAlign = TextAlign.start,
  });

  @override
  State<DecodeText> createState() => _DecodeTextState();
}

class _DecodeTextState extends State<DecodeText>
    with SingleTickerProviderStateMixin {
  static const String _glyphs = 'ABCDEFGHJKLMNPQRSTUVWXYZ#%&@*+<>/=';

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _frame(double t) {
    final text = widget.text;
    final resolved = (t * text.length).floor();
    final buffer = StringBuffer();

    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ' || i < resolved) {
        buffer.write(char);
      } else {
        buffer.write(_glyphs[_random.nextInt(_glyphs.length)]);
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return Text(widget.text, style: widget.style, textAlign: widget.textAlign);
    }

    return Semantics(
      label: widget.text,
      child: ExcludeSemantics(
        child: Stack(
          children: [
            // Invisible final text holds the size.
            Opacity(
              opacity: 0,
              child: Text(
                widget.text,
                style: widget.style,
                textAlign: widget.textAlign,
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final done = _controller.isCompleted;
                  // Before the delay elapses, show nothing rather than noise.
                  if (_controller.value == 0 && !done) {
                    return const SizedBox.shrink();
                  }

                  return Text(
                    done ? widget.text : _frame(_controller.value),
                    style: widget.style,
                    textAlign: widget.textAlign,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
