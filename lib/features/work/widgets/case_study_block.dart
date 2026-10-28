import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/text/section_label.dart';

/// A labelled paragraph — "Overview", "My role".
class CaseStudyBlock extends StatelessWidget {
  final String label;
  final String body;

  const CaseStudyBlock({super.key, required this.label, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        const Gap(AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            body,
            style: AppTypography.bodyLg.copyWith(
              color: context.ink(AppColors.emphasisBody),
            ),
          ),
        ),
      ],
    );
  }
}
