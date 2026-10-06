import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/skill_group.dart';
import '../../../shared/cards/bordered_card.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 16,
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
