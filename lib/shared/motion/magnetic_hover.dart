import 'package:flutter/widgets.dart';

import '../../core/theme/app_durations.dart';

/// Pulls a child a few pixels toward the cursor while hovered, then lets it
/// spring back. Desktop only by nature — touch never hovers.
class MagneticHover extends StatefulWidget {
  final Widget child;

  /// Maximum pull in logical pixels.
  final double strength;

  const MagneticHover({super.key, required this.child, this.strength = 4});

  @override
  State<MagneticHover> createState() => _MagneticHoverState();
}

class _MagneticHoverState extends State<MagneticHover> {
  Offset _offset = Offset.zero;

  void _onHover(Offset local) {
    final size = context.size;
    if (size == null || size.isEmpty) return;

    final dx = (local.dx / size.width - 0.5) * 2;
    final dy = (local.dy / size.height - 0.5) * 2;

    setState(() => _offset = Offset(dx, dy) * widget.strength);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;

    return MouseRegion(
      opaque: false,
      onHover: (e) => _onHover(e.localPosition),
      onExit: (_) => setState(() => _offset = Offset.zero),
      child: TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(begin: Offset.zero, end: _offset),
        duration: AppDurations.fast,
        curve: AppDurations.ease,
        builder: (context, offset, child) =>
            Transform.translate(offset: offset, child: child),
        child: widget.child,
      ),
    );
  }
}
