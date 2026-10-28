import 'package:flutter/material.dart';

import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/projects_data.dart';
import '../../data/models/project.dart';
import '../../shared/buttons/icon_text_button.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/media/screenshot_strip.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../not_found/not_found_screen.dart';
import 'widgets/case_study_block.dart';
import 'widgets/case_study_hero.dart';
import 'widgets/highlights_list.dart';
import 'widgets/next_project_card.dart';
import 'widgets/project_meta_row.dart';

/// /work/<slug> — one project in full. An unknown slug shows the 404.
class CaseStudyScreen extends StatelessWidget {
  final String slug;
  final ValueChanged<String> onNavigate;

  const CaseStudyScreen({
    super.key,
    required this.slug,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final project = ProjectsData.bySlug(slug);

    if (project == null) {
      return NotFoundScreen(
        onNavigate: onNavigate,
        message: 'There is no project at this address. It may have been '
            'renamed.',
      );
    }

    return PageScaffold(
      currentPath: RoutePaths.workDetailFor(project.slug),
      onNavigate: onNavigate,
      children: _body(context, project),
    );
  }

  List<Widget> _body(BuildContext context, Project project) {
    final next = ProjectsData.nextAfter(project);

    final overview = CaseStudyBlock(label: 'Overview', body: project.description);
    final role = CaseStudyBlock(label: 'My role', body: project.role);

    return [
      IconTextButton(
        label: 'All work',
        icon: Icons.arrow_back_rounded,
        leadingIcon: true,
        onTap: () => onNavigate(RoutePaths.work),
      ),
      const Gap(AppSpacing.lg),
      RevealOnScroll(
        child: CaseStudyHero(project: project, onNavigate: onNavigate),
      ),
      const Gap(AppSpacing.xl),
      RevealOnScroll(child: ScreenshotStrip(project: project)),
      const Gap(AppSpacing.xl),
      RevealOnScroll(child: ProjectMetaRow(project: project)),
      const Gap(AppSpacing.xxl),
      if (context.isMobile) ...[
        RevealOnScroll(child: overview),
        const Gap(AppSpacing.xl),
        RevealOnScroll(child: role),
      ] else
        RevealOnScroll(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: overview),
              const Gap.h(AppSpacing.xxl),
              Expanded(child: role),
            ],
          ),
        ),
      if (project.highlights.isNotEmpty) ...[
        const Gap(AppSpacing.xl),
        RevealOnScroll(child: HighlightsList(items: project.highlights)),
      ],
      Gap(context.sectionGap),
      if (next.slug != project.slug)
        RevealOnScroll(
          child: NextProjectCard(
            project: next,
            onTap: () => onNavigate(RoutePaths.workDetailFor(next.slug)),
          ),
        ),
    ];
  }
}
