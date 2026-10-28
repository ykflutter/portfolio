import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';
import '../motion/hud_corners.dart';
import '../motion/magnetic_hover.dart';
import '../motion/press_scale.dart';

/// Secondary action. Fills with a faint wash on hover rather than changing
/// colour, which keeps the monochrome palette intact.
class OutlineActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool expand;

  const OutlineActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    final button = HoverBuilder(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      builder: (context, hovered) {
        final active = hovered && enabled;

        return GestureDetector(
          onTap: onTap,
          child: HudCorners(
            visible: active,
            child: AnimatedContainer(
              duration: AppDurations.fast,
              curve: AppDurations.ease,
              width: expand ? double.infinity : null,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm + 2,
              ),
              decoration: BoxDecoration(
                borderRadius: AppRadius.brSm,
                color: active ? context.ink(AppColors.emphasisWash) : null,
                border: Border.all(
                  color: context.ink(
                    active ? AppColors.emphasisBody : AppColors.emphasisFaint,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    AnimatedSlide(
                      offset: active ? const Offset(0, 0.12) : Offset.zero,
                      duration: AppDurations.fast,
                      curve: AppDurations.ease,
                      child: Icon(icon, size: 17, color: context.cs.onSurface),
                    ),
                    const Gap.h(AppSpacing.xs + 2),
                  ],
                  Text(
                    label,
                    style: AppTypography.label
                        .copyWith(color: context.cs.onSurface),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: PressScale(
        enabled: enabled,
        child: enabled ? MagneticHover(child: button) : button,
      ),
    );
  }
}
