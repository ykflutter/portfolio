import 'package:flutter/material.dart';

import '../../app/router/route_paths.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/projects_data.dart';
import '../../shared/feedback/empty_state.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/layout/responsive_grid.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/text/section_header.dart';
import 'widgets/project_card.dart';
import 'widgets/work_filter_bar.dart';
import 'work_filter.dart';

/// /work — every project, filterable. Each card opens /work/<slug>.
class WorkScreen extends StatelessWidget {
  final WorkFilter filter;
  final ValueChanged<String> onNavigate;

  const WorkScreen({
    super.key,
    required this.filter,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final projects = ProjectsData.all.where(filter.matches).toList();

    return PageScaffold(
      currentPath: RoutePaths.work,
      onNavigate: onNavigate,
      children: [
        RevealOnScroll(
          child: SectionHeader(
            label: 'Selected work',
            title: 'Apps I have built and shipped.',
            subtitle:
                '${ProjectsData.all.length} projects across fintech, '
                'marketplaces, education and the web. Open any card for the '
                'full case study.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xl),
        WorkFilterBar(
          filter: filter,
          onChanged: (f) => onNavigate(f.toLocation()),
        ),
        const Gap(AppSpacing.xl),
        if (projects.isEmpty)
          SizedBox(
            height: 280,
            child: EmptyState(
              icon: Icons.search_off_rounded,
              title: 'No projects match this filter',
              message: 'Try another category, or see everything.',
              actionLabel: 'Show all work',
              onAction: () => onNavigate(RoutePaths.work),
            ),
          )
        else
          ResponsiveGrid(
            // A new key per filter re-runs the reveal, so the grid visibly
            // responds to the chip that was tapped.
            key: ValueKey(filter.toLocation()),
            itemCount: projects.length,
            itemBuilder: (context, i, fill) => ProjectCard(
              project: projects[i],
              fill: fill,
              onTap: () =>
                  onNavigate(RoutePaths.workDetailFor(projects[i].slug)),
            ),
          ),
      ],
    );
  }
}
