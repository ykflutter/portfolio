import 'package:flutter/material.dart';

import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/skills_data.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/layout/responsive_grid.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/text/section_header.dart';
import 'widgets/achievement_card.dart';
import 'widgets/skill_group_card.dart';

/// /skills — the resume's skill groups, plus highlights.
///
/// A skill chip links to /work?tech=<skill> when a project uses it.
class SkillsScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const SkillsScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    const groups = SkillsData.groups;
    const achievements = SkillsData.achievements;

    return PageScaffold(
      currentPath: RoutePaths.skills,
      onNavigate: onNavigate,
      children: [
        RevealOnScroll(
          child: SectionHeader(
            label: 'Skills & tools',
            title: 'What I work with.',
            subtitle:
                '${SkillsData.totalSkills} technologies across the mobile '
                'stack. Skills marked with an arrow open the projects that '
                'use them.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xxl),
        ResponsiveGrid(
          itemCount: groups.length,
          itemBuilder: (context, i, _) => SkillGroupCard(
            index: i,
            group: groups[i],
            onSkillTap: (skill) =>
                onNavigate(RoutePaths.workFiltered(tech: skill)),
          ),
        ),
        Gap(context.sectionGap),
        const RevealOnScroll(
          child: SectionHeader(label: 'Highlights', title: 'Proof of work.'),
        ),
        const Gap(AppSpacing.xl),
        ResponsiveGrid(
          itemCount: achievements.length,
          itemBuilder: (context, i, _) {
            final a = achievements[i];
            return AchievementCard(
              achievement: a,
              onTap: a.route == null ? null : () => onNavigate(a.route!),
            );
          },
        ),
      ],
    );
  }
}
