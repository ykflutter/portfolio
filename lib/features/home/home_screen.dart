import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../data/content/articles_data.dart';
import '../../shared/layout/page_scaffold.dart';
import 'sections/contact_cta_section.dart';
import 'sections/experience_preview.dart';
import 'sections/featured_work_section.dart';
import 'sections/hero_section.dart';
import 'sections/skills_preview.dart';
import 'sections/stats_strip.dart';
import 'sections/writing_preview.dart';

/// One scroll, the whole story. A recruiter gets everything without a click.
class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final gap = context.sectionGap;

    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.home,
      onNavigate: onNavigate,
      children: [
        HeroSection(onViewWork: () => onNavigate(RoutePaths.work)),
        const Gap(32),
        StatsStrip(onNavigate: onNavigate),
        Gap(gap),
        FeaturedWorkSection(onNavigate: onNavigate),
        Gap(gap),
        ExperiencePreview(onNavigate: onNavigate),
        Gap(gap),
        SkillsPreview(onNavigate: onNavigate),
        if (ArticlesData.hasPublished) ...[
          Gap(gap),
          WritingPreview(onNavigate: onNavigate),
        ],
        Gap(gap),
        ContactCtaSection(onNavigate: onNavigate),
      ],
    );
  }
}
