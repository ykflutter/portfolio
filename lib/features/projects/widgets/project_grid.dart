import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/project.dart';
import '../../../shared/motion/staggered_reveal.dart';
import 'project_card.dart';

/// Two columns on desktop, one everywhere else.
class ProjectGrid extends StatelessWidget {
  final List<Project> projects;
  final ValueChanged<Project> onOpen;

  const ProjectGrid({
    super.key,
    required this.projects,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final cards = [
      for (final p in projects)
        ProjectCard(project: p, onTap: () => onOpen(p)),
    ];

    if (!context.isDesktop) {
      return StaggeredReveal(spacing: AppSpacing.md, children: cards);
    }

    final revealed = StaggeredReveal.wrapAll(cards);
    final rows = <Widget>[];

    for (var i = 0; i < revealed.length; i += 2) {
      final left = revealed[i];
      final right = i + 1 < revealed.length ? revealed[i + 1] : null;

      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: left),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: right ?? const SizedBox.shrink()),
            ],
          ),
        ),
      );

      if (i + 2 < revealed.length) {
        rows.add(const SizedBox(height: AppSpacing.md));
      }
    }

    return Column(children: rows);
  }
}
