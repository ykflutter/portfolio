import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/content/projects_data.dart';
import '../../data/models/project.dart';
import '../../shared/buttons/icon_text_button.dart';
import '../../shared/feedback/empty_state.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/media/screenshot_gallery.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/text/section_label.dart';
import 'widgets/project_hero.dart';
import 'widgets/project_meta_row.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String slug;
  final ValueChanged<String> onNavigate;

  const ProjectDetailScreen({
    super.key,
    required this.slug,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final project = ProjectsData.bySlug(slug);

    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.work,
      onNavigate: onNavigate,
      children: project == null
          ? [
              SizedBox(
                height: 320,
                child: EmptyState(
                  icon: Icons.search_off_rounded,
                  title: 'No project called "$slug"',
                  actionLabel: 'Back to work',
                  onAction: () => onNavigate(RoutePaths.work),
                ),
              ),
            ]
          : _body(context, project),
    );
  }

  List<Widget> _body(BuildContext context, Project project) {
    return [
      IconTextButton(
        label: 'All work',
        icon: Icons.arrow_back_rounded,
        leadingIcon: true,
        onTap: () => onNavigate(RoutePaths.work),
      ),
      const Gap(AppSpacing.lg),
      RevealOnScroll(child: ProjectHero(project: project)),
      const Gap(AppSpacing.xxl),
      if (project.hasScreenshots) ...[
        ScreenshotGallery(imagePaths: project.screenshots),
        const Gap(AppSpacing.xxl),
      ],
      RevealOnScroll(child: ProjectMetaRow(project: project)),
      const Gap(AppSpacing.xxl),
      _block(context, 'Overview', project.description),
      const Gap(AppSpacing.xl),
      _block(context, 'My role', project.role),
      if (project.highlights.isNotEmpty) ...[
        const Gap(AppSpacing.xl),
        RevealOnScroll(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel('What it does'),
              const Gap(AppSpacing.sm),
              for (final line in project.highlights)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          right: AppSpacing.xs,
                        ),
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
                          line,
                          style: AppTypography.bodyMd.copyWith(
                            color: context.ink(AppColors.emphasisBody),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ];
  }

  Widget _block(BuildContext context, String label, String body) {
    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label),
          const Gap(AppSpacing.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              body,
              style: AppTypography.bodyLg.copyWith(
                color: context.ink(AppColors.emphasisBody),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
