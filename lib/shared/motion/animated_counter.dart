import 'package:flutter/material.dart';

import '../../core/theme/app_durations.dart';
import 'reveal_on_scroll.dart';

/// Counts up to a number when it scrolls into view.
///
/// Takes the display string ("4+", "20+", "3") and animates only the numeric
/// part, so the suffix stays put instead of flickering.
class AnimatedCounter extends StatefulWidget {
  final String value;
  final TextStyle? style;

  const AnimatedCounter({super.key, required this.value, this.style});

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.counter,
  );

  late final int _target = _parseNumber(widget.value);
  late final String _suffix = _parseSuffix(widget.value);

  static int _parseNumber(String raw) {
    final match = RegExp(r'\d+').firstMatch(raw);
    return match == null ? 0 : int.parse(match.group(0)!);
  }

  static String _parseSuffix(String raw) =>
      raw.replaceFirst(RegExp(r'^\D*\d+'), '');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context) || _target == 0) {
      return Text(widget.value, style: widget.style);
    }

    // The count starts only once the number is actually on screen.
    return RevealOnScroll(
      offsetY: 0,
      onReveal: () {
        if (mounted) _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final curved = Curves.easeOutExpo.transform(_controller.value);
          final current = (_target * curved).round();

          return Text('$current$_suffix', style: widget.style);
        },
      ),
    );
  }
}
