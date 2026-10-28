import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/buttons/icon_text_button.dart';

/// "Showing projects built with Flutter   ✕ Clear filter"
///
/// Shown for the tech and company filters, which arrive from other pages
/// and have no chip of their own.
class ActiveFilterNote extends StatelessWidget {
  final String text;
  final VoidCallback onClear;

  const ActiveFilterNote({
    super.key,
    required this.text,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_alt_outlined,
              size: 15,
              color: context.ink(AppColors.emphasisMuted),
            ),
            const Gap.h(6),
            Flexible(
              child: Text(
                text,
                style: AppTypography.bodySm.copyWith(
                  color: context.ink(AppColors.emphasisBody),
                ),
              ),
            ),
          ],
        ),
        IconTextButton(
          label: 'Clear filter',
          icon: Icons.close_rounded,
          leadingIcon: true,
          onTap: onClear,
        ),
      ],
    );
  }
}
