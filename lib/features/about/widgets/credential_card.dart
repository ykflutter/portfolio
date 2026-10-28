import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/skill_group.dart';
import '../../../shared/cards/bordered_card.dart';

/// A degree or certificate. Information only, so it is not tappable.
class CredentialCard extends StatelessWidget {
  final Credential credential;

  const CredentialCard({super.key, required this.credential});

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            credential.kind.toUpperCase(),
            style: AppTypography.eyebrow.copyWith(
              color: context.ink(AppColors.emphasisFaint),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            credential.title,
            style: AppTypography.titleMd.copyWith(color: context.cs.onSurface),
          ),
          const Gap(AppSpacing.xxs),
          Text(
            '${credential.institution}  ·  ${credential.period}',
            style: AppTypography.bodySm.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
        ],
      ),
    );
  }
}
