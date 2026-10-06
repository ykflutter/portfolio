import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// A small tech / category tag.
class TagChip extends StatelessWidget {
  final String label;
  final bool filled;

  const TagChip(this.label, {super.key, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs + 2,
        vertical: AppSpacing.xxs + 1,
      ),
      decoration: BoxDecoration(
        borderRadius: AppRadius.brXs,
        color: filled ? context.ink(AppColors.emphasisWash) : null,
        border: filled
            ? null
            : Border.all(color: context.ink(AppColors.emphasisHairline)),
      ),
      child: Text(
        label,
        style: AppTypography.micro.copyWith(
          color: context.ink(AppColors.emphasisMuted),
        ),
      ),
    );
  }
}
