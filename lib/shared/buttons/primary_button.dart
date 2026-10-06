import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';

/// Solid button — the single strongest call to action on a page.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool busy;
  final bool expand;

  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.busy = false,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null && !busy;
    final fg = context.cs.surface;

    return HoverBuilder(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      builder: (context, hovered) {
        return GestureDetector(
          onTap: enabled ? onTap : null,
          child: AnimatedOpacity(
            opacity: enabled ? (hovered ? 0.86 : 1) : 0.5,
            duration: AppDurations.fast,
            child: AnimatedContainer(
              duration: AppDurations.fast,
              curve: AppDurations.ease,
              width: expand ? double.infinity : null,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm + 2,
              ),
              decoration: BoxDecoration(
                color: context.cs.onSurface,
                borderRadius: AppRadius.brSm,
              ),
              child: Row(
                mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (busy)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: fg,
                      ),
                    )
                  else if (icon != null)
                    Icon(icon, size: 17, color: fg),
                  if (busy || icon != null) const Gap.h(AppSpacing.xs + 2),
                  Text(
                    label,
                    style: AppTypography.label.copyWith(color: fg),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
