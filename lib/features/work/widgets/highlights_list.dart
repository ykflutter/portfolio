import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/text/section_label.dart';

/// "What it does" — numbered like a mission list.
class HighlightsList extends StatelessWidget {
  final List<String> items;

  const HighlightsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('What it does'),
        const Gap(AppSpacing.md),
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      (i + 1).toString().padLeft(2, '0'),
                      style: AppTypography.micro.copyWith(
                        color: context.ink(AppColors.emphasisFaint),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    items[i],
                    style: AppTypography.bodyMd.copyWith(
                      color: context.ink(AppColors.emphasisBody),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
