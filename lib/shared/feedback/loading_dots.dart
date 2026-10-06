import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';

/// Three pulsing dots. Lighter than a spinner, and it doesn't imply a
/// percentage the page can't actually report.
class LoadingDots extends StatefulWidget {
  final double size;

  const LoadingDots({super.key, this.size = 6});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final phase = (_controller.value - i * 0.18) % 1.0;
            final opacity = 0.25 + 0.75 * (1 - (phase * 2 - 1).abs());

            return Padding(
              padding: EdgeInsets.only(right: i == 2 ? 0 : widget.size * 0.8),
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.ink(
                    opacity.clamp(AppColors.emphasisHairline, 1.0),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
