import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/experience_data.dart';
import '../../data/content/profile_data.dart';
import '../../shared/cards/stat_card.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/motion/staggered_reveal.dart';
import '../../shared/text/section_header.dart';
import 'widgets/education_block.dart';
import 'widgets/timeline_column.dart';

class ExperienceScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const ExperienceScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.experience,
      onNavigate: onNavigate,
      children: [
        RevealOnScroll(
          child: SectionHeader(
            label: 'Work history',
            title: '${ProfileData.yearsExperience} years of Flutter.',
            subtitle:
                'Cross-platform apps shipped to the Play Store and the App '
                'Store.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: StaggeredReveal.wrapAll([
            StatCard(
              value: '${ProfileData.yearsExperience}+',
              label: 'Years',
            ),
            StatCard(value: '${ProfileData.companyCount}', label: 'Companies'),
            StatCard(value: '${ProfileData.projectCount}', label: 'Projects'),
            StatCard(
              value: '${ProfileData.skillCount}+',
              label: 'Technologies',
            ),
          ]),
        ),
        const Gap(AppSpacing.xxl),
        TimelineColumn(entries: ExperienceData.all),
        const Gap(AppSpacing.xxl),
        const RevealOnScroll(child: EducationBlock()),
      ],
    );
  }
}
