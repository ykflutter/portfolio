import 'package:flutter/widgets.dart';

import '../../core/theme/app_durations.dart';
import 'hover_builder.dart';

/// Lifts and slightly scales a child on hover.
///
/// Kept deliberately small — 1.02 and a 2px lift. Anything larger reads as a
/// toy on a text-heavy page.
class HoverScale extends StatelessWidget {
  final Widget child;
  final double scale;
  final double lift;
  final VoidCallback? onTap;

  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.02,
    this.lift = 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      builder: (context, hovered) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedScale(
            scale: hovered ? scale : 1,
            duration: AppDurations.fast,
            curve: AppDurations.ease,
            child: AnimatedSlide(
              offset: hovered ? Offset(0, -lift / 100) : Offset.zero,
              duration: AppDurations.fast,
              curve: AppDurations.ease,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
