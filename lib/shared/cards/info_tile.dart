import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'bordered_card.dart';

/// icon + label + value row. Used for contact details.
/// Tappable tiles show an outward arrow; display-only ones do not.
class InfoTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      onTap: onTap,
      semanticLabel: onTap == null ? null : '$label: $value',
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: AppRadius.brSm,
              color: context.ink(AppColors.emphasisWash),
            ),
            child: icon,
          ),
          const Gap.h(AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: AppTypography.eyebrow.copyWith(
                    color: context.ink(AppColors.emphasisFaint),
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.titleSm.copyWith(
                    color: context.cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            Icon(
              Icons.arrow_outward_rounded,
              size: 14,
              color: context.ink(AppColors.emphasisFaint),
            ),
        ],
      ),
    );
  }
}
