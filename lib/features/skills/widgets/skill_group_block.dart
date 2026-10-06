import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/skill_group.dart';
import '../../../shared/chips/tag_wrap.dart';

class SkillGroupBlock extends StatelessWidget {
  final SkillGroup group;

  const SkillGroupBlock({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.title.toUpperCase(),
          style: AppTypography.eyebrow.copyWith(
            color: context.ink(AppColors.emphasisFaint),
          ),
        ),
        const Gap(AppSpacing.xs),
        TagWrap(group.skills),
      ],
    );
  }
}
