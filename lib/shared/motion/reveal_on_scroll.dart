import 'package:flutter/material.dart';

import '../../core/theme/app_durations.dart';

/// Fades and lifts a child the first time it scrolls into view.
///
/// No package dependency: it watches the enclosing Scrollable's position and
/// compares the child's global offset against the viewport. Fires once, then
/// detaches its listener so it costs nothing afterwards.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offsetY;

  /// How far into the viewport the child must come before it triggers,
  /// as a fraction of screen height.
  final double threshold;

  /// Fires once, the moment the child becomes visible. Used by widgets that
  /// need to start their own animation on entry (counters, for example).
  final VoidCallback? onReveal;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 28,
    this.threshold = 0.9,
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

  ScrollPosition? _position;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _attach();
      _check();
    });
  }

  void _attach() {
    _position = Scrollable.maybeOf(context)?.position;
    _position?.addListener(_check);
  }

  void _detach() {
    _position?.removeListener(_check);
    _position = null;
  }

  void _check() {
    if (_revealed || !mounted) return;

    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;

    final top = box.localToGlobal(Offset.zero).dy;
    final limit = MediaQuery.sizeOf(context).height * widget.threshold;

    if (top < limit) _reveal();
  }

  Future<void> _reveal() async {
    _revealed = true;
    _detach();

    if (widget.delay > Duration.zero) {
      await Future<void>.delayed(widget.delay);
    }

    if (!mounted) return;

    _controller.forward();
    widget.onReveal?.call();
  }

  @override
  void dispose() {
    _detach();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect the OS "reduce motion" setting — required for accessibility,
    // and some people get motion sick from scroll animation.
    if (MediaQuery.disableAnimationsOf(context)) {
      if (!_revealed) {
        _revealed = true;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.onReveal?.call(),
        );
      }
      return widget.child;
    }

    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppDurations.ease,
    );

    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, widget.offsetY * (1 - curved.value)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
