import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/cards/bordered_card.dart';
import '../../../shared/chips/status_pill.dart';
import '../../../shared/chips/tag_wrap.dart';

class AvailabilityCard extends StatelessWidget {
  const AvailabilityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatusPill(label: ProfileData.availability),
          const Gap(AppSpacing.sm),
          Text(
            ProfileData.availabilityNote,
            style: AppTypography.bodySm.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
          const Gap(AppSpacing.sm),
          const TagWrap(['Flutter', 'Mobile', 'Remote', 'Full-time']),
        ],
      ),
    );
  }
}
