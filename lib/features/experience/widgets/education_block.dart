import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/content/experience_data.dart';
import '../../../shared/cards/bordered_card.dart';

class EducationBlock extends StatelessWidget {
  const EducationBlock({super.key});

  @override
  Widget build(BuildContext context) {
    const education = ExperienceData.education;

    return BorderedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EDUCATION',
            style: AppTypography.eyebrow.copyWith(
              color: context.ink(AppColors.emphasisFaint),
            ),
          ),
          const Gap(AppSpacing.xs),
          Text(
            education.degree,
            style: AppTypography.titleSm.copyWith(
              color: context.cs.onSurface,
            ),
          ),
          const Gap(2),
          Text(
            '${education.institution}  ·  ${education.year}',
            style: AppTypography.bodySm.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
        ],
      ),
    );
  }
}
