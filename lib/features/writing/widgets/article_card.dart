import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/launcher.dart';
import '../../../data/models/article.dart';
import '../../../shared/buttons/icon_text_button.dart';
import '../../../shared/motion/hover_builder.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) {
        return GestureDetector(
          onTap: () => Launcher.open(
            article.url,
            unavailableMessage: 'This article is not published yet.',
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    article.formattedDate,
                    style: AppTypography.eyebrow.copyWith(
                      color: context.ink(AppColors.emphasisFaint),
                    ),
                  ),
                  const Gap.h(AppSpacing.sm),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.ink(AppColors.emphasisFaint),
                    ),
                  ),
                  const Gap.h(AppSpacing.sm),
                  Text(
                    '${article.readMinutes} MIN',
                    style: AppTypography.eyebrow.copyWith(
                      color: context.ink(AppColors.emphasisFaint),
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.xs),
              Text(
                article.title,
                style: AppTypography.displaySm.copyWith(
                  fontSize: context.isMobile ? 22 : 26,
                  color: context.ink(hovered ? 1.0 : AppColors.emphasisBody),
                ),
              ),
              const Gap(AppSpacing.xs),
              Text(
                article.snippet,
                style: AppTypography.bodySm.copyWith(
                  color: context.ink(AppColors.emphasisMuted),
                ),
              ),
              const Gap(AppSpacing.sm),
              const IconTextButton(label: 'Read article'),
            ],
          ),
        );
      },
    );
  }
}
