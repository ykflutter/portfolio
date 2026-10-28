import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_durations.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/project.dart';
import '../../../shared/chips/tag_wrap.dart';
import '../../../shared/media/project_media.dart';
import '../../../shared/motion/hud_corners.dart';
import '../../../shared/motion/tilt_card.dart';
import 'case_study_cue.dart';

/// One project on /work. The whole card is the link to its case study.
///
/// Hover: tilts toward the cursor, HUD corners lock on, the screenshot zooms
/// and "View case study" nudges forward.
class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  /// True when the grid gives the card a fixed height — the cue is then
  /// pinned to the bottom so every card in a row lines up.
  final bool fill;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.fill = false,
  });

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      onTap: onTap,
      semanticLabel: 'Open ${project.title} case study',
      builder: (context, hovered) {
        final details = Padding(
          padding: EdgeInsets.all(
            context.isMobile ? AppSpacing.md : AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    project.icon,
                    size: 15,
                    color: context.ink(AppColors.emphasisMuted),
                  ),
                  const Gap.h(AppSpacing.xs),
                  Expanded(
                    child: Text(
                      project.category.toUpperCase(),
                      style: AppTypography.eyebrow.copyWith(
                        color: context.ink(AppColors.emphasisFaint),
                      ),
                    ),
                  ),
                  if (project.featured)
                    Text(
                      'FEATURED',
                      style: AppTypography.eyebrow.copyWith(
                        color: context.ink(AppColors.emphasisBody),
                      ),
                    ),
                ],
              ),
              const Gap(AppSpacing.sm),
              Text(
                project.title,
                style: AppTypography.titleLg.copyWith(
                  color: context.cs.onSurface,
                ),
              ),
              if (project.metaLine != null) ...[
                const Gap(AppSpacing.xxs),
                Text(
                  project.metaLine!,
                  style: AppTypography.micro.copyWith(
                    color: context.ink(AppColors.emphasisFaint),
                  ),
                ),
              ],
              const Gap(AppSpacing.xs),
              Text(
                project.tagline,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySm.copyWith(
                  color: context.ink(AppColors.emphasisMuted),
                ),
              ),
              const Gap(AppSpacing.md),
              TagWrap(project.tech, maxTags: 3),
              if (fill) const Spacer() else const Gap(AppSpacing.md),
              if (fill) const Gap(AppSpacing.md),
              CaseStudyCue(active: hovered),
            ],
          ),
        );

        return HudCorners(
          visible: hovered,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: AppDurations.ease,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.palette.card,
              borderRadius: AppRadius.brMd,
              border: Border.all(
                color: context.ink(
                  hovered ? AppColors.emphasisFaint : AppColors.emphasisHairline,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProjectMedia(
                  project: project,
                  hovered: hovered,
                  height: context.isMobile ? 200 : 220,
                ),
                if (fill) Expanded(child: details) else details,
              ],
            ),
          ),
        );
      },
    );
  }
}
