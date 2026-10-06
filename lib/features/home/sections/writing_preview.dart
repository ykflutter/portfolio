import 'package:flutter/material.dart';

import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/content/articles_data.dart';
import '../../../shared/buttons/icon_text_button.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import '../../../shared/motion/staggered_reveal.dart';
import '../../../shared/text/section_header.dart';
import '../../writing/widgets/article_card.dart';

/// Renders nothing while no article is published. An empty Writing section
/// is worse than no Writing section.
class WritingPreview extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const WritingPreview({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    if (!ArticlesData.hasPublished) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RevealOnScroll(
          child: SectionHeader(label: 'Writing', title: 'Notes.'),
        ),
        const Gap(AppSpacing.xl),
        StaggeredReveal(
          spacing: AppSpacing.xl,
          children: [
            for (final article in ArticlesData.published.take(2))
              ArticleCard(article: article),
          ],
        ),
        const Gap(AppSpacing.lg),
        IconTextButton(
          label: 'All writing',
          onTap: () => onNavigate('/writing'),
        ),
      ],
    );
  }
}
