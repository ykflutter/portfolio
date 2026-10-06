import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/project.dart';
import '../../../shared/cards/bordered_card.dart';
import '../../../shared/chips/tag_wrap.dart';
import '../../../shared/media/device_frame.dart';

/// One project. Screenshot on the left where there is room, details on the
/// right. An empty frame renders when no screenshot exists yet, so the layout
/// is already correct before the images land.
class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      onTap: onTap,
      padding: EdgeInsets.all(context.isMobile ? AppSpacing.md : AppSpacing.lg),
      child: context.isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _details(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeviceFrame(
                  width: 118,
                  imagePath:
                      project.hasScreenshots ? project.screenshots.first : null,
                ),
                const Gap.h(AppSpacing.lg),
                Expanded(child: _details(context)),
              ],
            ),
    );
  }

  Widget _details(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(project.icon, size: 20, color: context.cs.onSurface),
            const Gap.h(AppSpacing.xs),
            Expanded(
              child: Text(
                project.category.toUpperCase(),
                style: AppTypography.eyebrow.copyWith(
                  color: context.ink(AppColors.emphasisFaint),
                ),
              ),
            ),
            Icon(
              Icons.arrow_outward_rounded,
              size: 16,
              color: context.ink(AppColors.emphasisFaint),
            ),
          ],
        ),
        const Gap(AppSpacing.sm),
        Text(
          project.title,
          style: AppTypography.titleLg.copyWith(color: context.cs.onSurface),
        ),
        const Gap(AppSpacing.xxs),
        Text(
          '${project.company}  ·  ${project.period}',
          style: AppTypography.micro.copyWith(
            color: context.ink(AppColors.emphasisFaint),
          ),
        ),
        const Gap(AppSpacing.xs),
        Text(
          project.tagline,
          style: AppTypography.bodySm.copyWith(
            color: context.ink(AppColors.emphasisMuted),
          ),
        ),
        const Gap(AppSpacing.md),
        TagWrap(project.tech, maxTags: 4),
      ],
    );
  }
}
