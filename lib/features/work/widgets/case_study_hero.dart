import 'package:flutter/material.dart';

import '../../../app/router/route_paths.dart';
import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/content/projects_data.dart';
import '../../../data/models/project.dart';
import '../../../shared/chips/tag_wrap.dart';
import '../../../shared/text/section_label.dart';
import 'project_links_row.dart';

/// Category, title, tagline, tech and store links.
///
/// Tech chips link to /work?tech=<name> when another project shares it.
class CaseStudyHero extends StatelessWidget {
  final Project project;
  final ValueChanged<String> onNavigate;

  const CaseStudyHero({
    super.key,
    required this.project,
    required this.onNavigate,
  });

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
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            project.tagline,
            style: AppTypography.bodyLg.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        TagWrap(
          project.tech,
          // Only link a chip when it leads to more than this project.
          isLinkable: (t) =>
              ProjectsData.all.where((p) => p.usesTech(t)).length > 1,
          onTagTap: (t) => onNavigate(RoutePaths.workFiltered(tech: t)),
          tooltipFor: (t) => 'See all projects built with $t',
        ),
        if (project.liveLinks.isNotEmpty) ...[
          const Gap(AppSpacing.lg),
          ProjectLinksRow(project: project),
        ],
      ],
    );
  }
}
