import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/content/projects_data.dart';
import '../../../data/models/skill_group.dart';
import '../../../shared/cards/bordered_card.dart';
import '../../../shared/chips/tag_chip.dart';
import '../../../shared/motion/staggered_reveal.dart';

/// "01 · Framework & languages" and its skills. Chips light up one after
/// another as the card scrolls in, like abilities unlocking.
class SkillGroupCard extends StatelessWidget {
  final int index;
  final SkillGroup group;
  final ValueChanged<String> onSkillTap;

  const SkillGroupCard({
    super.key,
    required this.index,
    required this.group,
    required this.onSkillTap,
  });

  @override
  Widget build(BuildContext context) {
    final chips = [
      for (final skill in group.skills)
        ProjectsData.usesTech(skill)
            ? TagChip(
                skill,
                onTap: () => onSkillTap(skill),
                tooltip: 'See projects built with $skill',
              )
            : TagChip(skill),
    ];

    return BorderedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                (index + 1).toString().padLeft(2, '0'),
                style: AppTypography.micro.copyWith(
                  color: context.ink(AppColors.emphasisFaint),
                ),
              ),
              const Gap.h(AppSpacing.sm),
              Expanded(
                child: Text(
                  group.title.toUpperCase(),
                  style: AppTypography.eyebrow.copyWith(
                    color: context.ink(AppColors.emphasisMuted),
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs - 2,
            runSpacing: AppSpacing.xs - 2,
            children: StaggeredReveal.wrapAll(
              chips,
              interval: const Duration(milliseconds: 45),
            ),
          ),
        ],
      ),
    );
  }
}
