import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../motion/shimmer.dart';

/// Stands in for a screenshot that has not been added yet: a shimmering
/// surface with the project's initials. Fills whatever box it is given.
class ShotPlaceholder extends StatelessWidget {
  final String initials;
  final String? label;

  /// Scales the initials to the box — small in a card, large in a frame.
  final double initialsSize;

  const ShotPlaceholder({
    super.key,
    required this.initials,
    this.label,
    this.initialsSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              initials,
              style: AppTypography.displaySm.copyWith(
                fontSize: initialsSize,
                color: context.ink(AppColors.emphasisFaint),
              ),
            ),
            if (label != null) ...[
              const Gap(6),
              Text(
                label!.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTypography.eyebrow.copyWith(
                  color: context.ink(AppColors.emphasisFaint),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
