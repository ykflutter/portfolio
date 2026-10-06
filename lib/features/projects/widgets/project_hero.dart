import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/project.dart';
import '../../../shared/chips/tag_wrap.dart';
import '../../../shared/text/section_label.dart';
import 'project_links_row.dart';

class ProjectHero extends StatelessWidget {
  final Project project;

  const ProjectHero({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(project.category),
        const Gap(AppSpacing.sm),
        Text(
          project.title,
          style: (context.isMobile
                  ? AppTypography.displayMd
                  : AppTypography.displayLg)
              .copyWith(color: context.cs.onSurface),
        ),
        const Gap(AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            project.tagline,
            style: AppTypography.bodyLg.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        TagWrap(project.tech),
        const Gap(AppSpacing.lg),
        ProjectLinksRow(project: project),
      ],
    );
  }
}
