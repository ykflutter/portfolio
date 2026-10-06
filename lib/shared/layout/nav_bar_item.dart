import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';

/// A nav link with an underline that grows from the left on hover and stays
/// put when the route is active.
class NavBarItem extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) {
        final show = hovered || active;

        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: AppDurations.fast,
                  style: AppTypography.label.copyWith(
                    color: context.ink(
                      show ? 1.0 : AppColors.emphasisMuted,
                    ),
                  ),
                  child: Text(label),
                ),
                const SizedBox(height: 3),
                AnimatedContainer(
                  duration: AppDurations.fast,
                  curve: AppDurations.ease,
                  height: 1.5,
                  width: show ? _measure(context) : 0,
                  color: context.cs.onSurface,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Underline matches the label's painted width rather than the full box.
  double _measure(BuildContext context) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: AppTypography.label),
      textDirection: Directionality.of(context),
    )..layout();

    return painter.width;
  }
}
