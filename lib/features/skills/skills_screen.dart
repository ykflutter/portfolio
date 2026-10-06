import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/skills_data.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/motion/staggered_reveal.dart';
import '../../shared/text/section_header.dart';
import '../../shared/text/section_label.dart';
import 'widgets/achievement_card.dart';
import 'widgets/skill_group_block.dart';

class SkillsScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const SkillsScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final groups = [
      for (final group in SkillsData.groups) SkillGroupBlock(group: group),
    ];

    final achievements = [
      for (final a in SkillsData.achievements) AchievementCard(achievement: a),
    ];

    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.skills,
      onNavigate: onNavigate,
      children: [
        RevealOnScroll(
          child: SectionHeader(
            label: 'Tech stack',
            title: 'What I build with.',
            subtitle:
                '${SkillsData.totalSkills} technologies across the mobile '
                'stack, from state management to store release.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xxl),
        if (context.isDesktop)
          Wrap(
            spacing: AppSpacing.xxl,
            runSpacing: AppSpacing.xl,
            children: [
              for (final block in StaggeredReveal.wrapAll(groups))
                SizedBox(width: 300, child: block),
            ],
          )
        else
          StaggeredReveal(spacing: AppSpacing.lg, children: groups),
        const Gap(AppSpacing.xxl),
        const RevealOnScroll(child: SectionLabel('Highlights')),
        const Gap(AppSpacing.md),
        if (context.isDesktop)
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              for (final card in StaggeredReveal.wrapAll(achievements))
                SizedBox(width: 340, child: card),
            ],
          )
        else
          StaggeredReveal(spacing: AppSpacing.md, children: achievements),
      ],
    );
  }
}
