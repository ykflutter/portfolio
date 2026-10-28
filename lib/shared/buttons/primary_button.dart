import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';
import '../motion/hud_corners.dart';
import '../motion/magnetic_hover.dart';
import '../motion/press_scale.dart';

/// Solid button — the single strongest call to action on a page.
///
/// Hover: HUD corners snap in, the icon nudges forward, and the button
/// leans a few pixels toward the cursor. Press: it shrinks slightly.
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

    final button = HoverBuilder(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      builder: (context, hovered) {
        final active = hovered && enabled;

        return GestureDetector(
          onTap: enabled ? onTap : null,
          child: HudCorners(
            visible: active,
            child: AnimatedOpacity(
              opacity: enabled ? 1 : 0.5,
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
                    Text(label, style: AppTypography.label.copyWith(color: fg)),
                    if (busy || icon != null) const Gap.h(AppSpacing.xs + 2),
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
                      AnimatedSlide(
                        offset: active ? const Offset(0.2, 0) : Offset.zero,
                        duration: AppDurations.fast,
                        curve: AppDurations.ease,
                        child: Icon(icon, size: 17, color: fg),
                      ),
                  ],
                ),
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
      onTap: enabled ? onTap : null,
      excludeSemantics: true,
      child: PressScale(
        enabled: enabled,
        child: enabled ? MagneticHover(child: button) : button,
      ),
    );
  }
}
