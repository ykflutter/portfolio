import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/animated_counter.dart';
import 'bordered_card.dart';

/// A number + label tile. Tappable ones show an outward arrow so a visitor
/// can tell at a glance which tiles go somewhere.
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;
  final bool animate;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.onTap,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final valueStyle = AppTypography.titleLg.copyWith(
      fontSize: 25,
      color: context.cs.onSurface,
    );

    return BorderedCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md + 4,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              animate
                  ? AnimatedCounter(value: value, style: valueStyle)
                  : Text(value, style: valueStyle),
              Text(
                label.toUpperCase(),
                style: AppTypography.eyebrow.copyWith(
                  color: context.ink(AppColors.emphasisMuted),
                ),
              ),
            ],
          ),
          if (onTap != null) ...[
            const Gap.h(AppSpacing.md),
            Icon(
              Icons.arrow_outward_rounded,
              size: 16,
              color: context.ink(AppColors.emphasisFaint),
            ),
          ],
        ],
      ),
    );
  }
}
