import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/content/articles_data.dart';
import '../../shared/feedback/empty_state.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/motion/staggered_reveal.dart';
import '../../shared/text/section_header.dart';
import 'widgets/article_card.dart';

class WritingScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const WritingScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final articles = ArticlesData.published;

    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.writing,
      onNavigate: onNavigate,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Writing',
            title: 'Notes.',
            subtitle:
                'Mobile architecture, state management and the things that '
                'only show up in production.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xxl),
        if (articles.isEmpty)
          SizedBox(
            height: 260,
            child: EmptyState(
              icon: Icons.edit_note_rounded,
              title: 'Nothing published yet',
              message:
                  'Drafts exist. They go live here once they are posted.',
              actionLabel: 'See the work instead',
              onAction: () => onNavigate(RoutePaths.work),
            ),
          )
        else
          StaggeredReveal(
            spacing: AppSpacing.xxl,
            children: [
              for (final article in articles) ArticleCard(article: article),
            ],
          ),
      ],
    );
  }
}
