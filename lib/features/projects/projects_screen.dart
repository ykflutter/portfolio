import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/projects_data.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/text/section_header.dart';
import 'widgets/project_grid.dart';

class ProjectsScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const ProjectsScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.work,
      onNavigate: onNavigate,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Selected work',
            title: 'Things I shipped.',
            subtitle:
                'Production apps across fintech, productivity and real-time '
                'data. Open one for the full story.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xxl),
        ProjectGrid(
          projects: ProjectsData.all,
          onOpen: (p) => onNavigate('${RoutePaths.work}/${p.slug}'),
        ),
      ],
    );
  }
}
