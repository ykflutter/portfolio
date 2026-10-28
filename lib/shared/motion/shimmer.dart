import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';

/// A slow light sweep across a surface — the "still loading" look used for
/// screenshot placeholders. Static under "reduce motion".
class Shimmer extends StatefulWidget {
  final Widget? child;

  const Shimmer({super.key, this.child});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final reduce = context.reduceMotion;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (reduce)
          ColoredBox(color: palette.shimmerBase)
        else
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      palette.shimmerBase,
                      palette.shimmerHighlight,
                      palette.shimmerBase,
                    ],
                    stops: const [0.35, 0.5, 0.65],
                    transform: _SweepTransform(_controller.value),
                  ),
                ),
              );
            },
          ),
        ?widget.child,
      ],
    );
  }
}

/// Slides the gradient from fully left of the box to fully right.
class _SweepTransform extends GradientTransform {
  final double t;

  const _SweepTransform(this.t);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (t * 2 - 1), 0, 0);
  }
}
