import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'section_label.dart';
import 'section_title.dart';

/// eyebrow + title + optional subtitle. The standard opener for every
/// section, so they all align to the same rhythm.
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final bool large;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.large = false,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        SectionLabel(label),
        const Gap(AppSpacing.sm),
        SectionTitle(
          title,
          large: large,
          align: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : null,
        ),
        if (subtitle != null) ...[
          const Gap(AppSpacing.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              textAlign: alignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : null,
              style: AppTypography.bodyLg.copyWith(
                color: context.ink(AppColors.emphasisMuted),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
