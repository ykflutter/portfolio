import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/skill_group.dart';
import '../../../shared/cards/bordered_card.dart';

/// One highlight. Cards with a route open the matching case study and say
/// so; the rest are information only.
class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback? onTap;

  const AchievementCard({super.key, required this.achievement, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      onTap: onTap,
      semanticLabel: onTap == null ? null : '${achievement.title}, open project',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.military_tech_outlined,
                size: 18,
                color: context.ink(AppColors.emphasisBody),
              ),
              const Gap.h(AppSpacing.xs),
              Expanded(
                child: Text(
                  achievement.title,
                  style: AppTypography.titleSm.copyWith(
                    color: context.cs.onSurface,
                  ),
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 15,
                  color: context.ink(AppColors.emphasisFaint),
                ),
            ],
          ),
          const Gap(AppSpacing.xs),
          Text(
            achievement.description,
            style: AppTypography.bodySm.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
        ],
      ),
    );
  }
}
