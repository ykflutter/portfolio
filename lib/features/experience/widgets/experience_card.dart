import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/experience.dart';
import '../../../shared/chips/tag_wrap.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded inside a Column would be unbounded here (the page is
        // inside a scroll view), so mobile stacks instead of flexing.
        if (context.isMobile) ...[
          _titleBlock(context),
          const Gap(AppSpacing.xs),
          _periodChip(context),
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _titleBlock(context)),
              const Gap.h(AppSpacing.md),
              _periodChip(context),
            ],
          ),
        const Gap(AppSpacing.sm),
        for (final point in experience.points)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: AppSpacing.xs),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.ink(AppColors.emphasisFaint),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: AppTypography.bodySm.copyWith(
                      color: context.ink(AppColors.emphasisBody),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const Gap(AppSpacing.sm),
        TagWrap(experience.tech),
      ],
    );
  }

  Widget _titleBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          experience.title,
          style: AppTypography.titleMd.copyWith(color: context.cs.onSurface),
        ),
        const Gap(2),
        Text(
          experience.company,
          style: AppTypography.bodySm.copyWith(
            color: context.ink(AppColors.emphasisMuted),
          ),
        ),
      ],
    );
  }

  Widget _periodChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: context.ink(AppColors.emphasisHairline)),
      ),
      child: Text(
        experience.period,
        style: AppTypography.micro.copyWith(
          color: context.ink(AppColors.emphasisMuted),
        ),
      ),
    );
  }
}
