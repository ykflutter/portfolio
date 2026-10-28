import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/theme/app_durations.dart';

/// Fades and lifts a child the first time it scrolls into view.
///
/// Uses VisibilityDetector, so it works inside horizontal lists, after
/// rotation and after a window resize. Fires once, then stays revealed.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offsetY;

  /// Fraction of the child that must be visible before it reveals.
  final double threshold;

  /// Fires once, the moment the child is revealed. Used by widgets that
  /// start their own animation on entry (counters, for example).
  final VoidCallback? onReveal;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 24,
    this.threshold = 0.1,
    this.onReveal,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.medium,
  );

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _controller,
    curve: AppDurations.ease,
  );

  /// VisibilityDetector needs a key that is unique and stable.
  final Key _detectorKey = UniqueKey();

  bool _revealed = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_revealed || !mounted) return;

    // Very tall children never reach a fraction threshold, so a solid
    // 120px on screen counts too.
    final enough = info.visibleFraction >= widget.threshold ||
        info.visibleBounds.height >= 120;

    if (enough) _reveal();
  }

  Future<void> _reveal() async {
    _revealed = true;

    if (widget.delay > Duration.zero) {
      await Future<void>.delayed(widget.delay);
    }

    if (!mounted) return;

    _controller.forward();
    widget.onReveal?.call();
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect the OS "reduce motion" setting.
    if (MediaQuery.disableAnimationsOf(context)) {
      if (!_revealed) {
        _revealed = true;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.onReveal?.call(),
        );
      }
      return widget.child;
    }

    // The detector sits OUTSIDE the Opacity: a fully transparent subtree is
    // not painted, and an unpainted detector never reports visible.
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, child) {
          return Opacity(
            opacity: _curve.value,
            child: Transform.translate(
              offset: Offset(0, widget.offsetY * (1 - _curve.value)),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
