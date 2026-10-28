import 'package:flutter/widgets.dart';

import '../../core/theme/app_durations.dart';

/// Shrinks a child slightly while a pointer is down on it. Gives touch
/// screens — which never hover — the same "it responded" feel as desktop.
class PressScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final bool enabled;

  const PressScale({
    super.key,
    required this.child,
    this.scale = 0.96,
    this.enabled = true,
  });

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _pressed = false;

  void _set(bool value) {
    if (!widget.enabled || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1,
        duration: AppDurations.instant,
        curve: AppDurations.ease,
        child: widget.child,
      ),
    );
  }
}
