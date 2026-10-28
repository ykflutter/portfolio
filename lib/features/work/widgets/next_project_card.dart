import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_durations.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/project.dart';
import '../../../shared/motion/hud_corners.dart';
import '../../../shared/motion/tilt_card.dart';

/// "Next project →" at the end of every case study. Opens /work/<next-slug>,
/// so a visitor can move through all the work without going back.
class NextProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const NextProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      onTap: onTap,
      maxTilt: 2,
      semanticLabel: 'Next project: ${project.title}',
      builder: (context, hovered) => HudCorners(
        visible: hovered,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: EdgeInsets.all(
            context.isMobile ? AppSpacing.lg : AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            color: context.palette.card,
            borderRadius: AppRadius.brMd,
            border: Border.all(
              color: context.ink(
                hovered ? AppColors.emphasisFaint : AppColors.emphasisHairline,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEXT PROJECT',
                      style: AppTypography.eyebrow.copyWith(
                        color: context.ink(AppColors.emphasisFaint),
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      project.title,
                      style: AppTypography.displaySm.copyWith(
                        fontSize: context.isMobile ? 26 : 34,
                        color: context.cs.onSurface,
                      ),
                    ),
                    const Gap(AppSpacing.xxs),
                    Text(
                      project.tagline,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySm.copyWith(
                        color: context.ink(AppColors.emphasisMuted),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap.h(AppSpacing.lg),
              AnimatedSlide(
                offset: hovered ? const Offset(0.25, 0) : Offset.zero,
                duration: AppDurations.fast,
                curve: AppDurations.ease,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 28,
                  color: context.cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
