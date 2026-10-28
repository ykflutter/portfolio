import 'package:flutter/material.dart';

import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/experience_data.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/text/section_header.dart';
import 'widgets/about_cta.dart';
import 'widgets/about_intro.dart';
import 'widgets/about_stats.dart';
import 'widgets/credentials_row.dart';
import 'widgets/timeline_column.dart';

/// /about — who I am, where I have worked, what I studied.
class AboutScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const AboutScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final gap = context.sectionGap;

    return PageScaffold(
      currentPath: RoutePaths.about,
      onNavigate: onNavigate,
      children: [
        const AboutIntro(),
        const Gap(AppSpacing.xl),
        AboutStats(onNavigate: onNavigate),
        Gap(gap),
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Experience',
            title: 'Where I have worked.',
          ),
        ),
        const Gap(AppSpacing.xl),
        TimelineColumn(entries: ExperienceData.all, onNavigate: onNavigate),
        Gap(gap),
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Education',
            title: 'What I studied.',
          ),
        ),
        const Gap(AppSpacing.xl),
        const CredentialsRow(),
        Gap(gap),
        RevealOnScroll(child: AboutCta(onNavigate: onNavigate)),
      ],
    );
  }
}
