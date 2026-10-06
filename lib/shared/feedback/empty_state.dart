import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../buttons/outline_button.dart';

/// Nothing-here and something-went-wrong share a shape, so they share a
/// widget. An unstyled blank area is the fastest way to look unfinished.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    this.icon = Icons.inbox_rounded,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  /// Preset for failed loads.
  const EmptyState.error({
    super.key,
    required this.title,
    this.message,
    this.actionLabel = 'Try again',
    this.onAction,
  }) : icon = Icons.wifi_off_rounded;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 44,
              color: context.ink(AppColors.emphasisFaint),
            ),
            const Gap(AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.titleMd.copyWith(
                color: context.ink(AppColors.emphasisBody),
              ),
            ),
            if (message != null) ...[
              const Gap(AppSpacing.xs),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppTypography.bodySm.copyWith(
                  color: context.ink(AppColors.emphasisMuted),
                ),
              ),
            ],
            if (onAction != null) ...[
              const Gap(AppSpacing.md),
              OutlineActionButton(
                label: actionLabel ?? 'Retry',
                onTap: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
