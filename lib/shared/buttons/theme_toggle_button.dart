import 'package:flutter/material.dart';

import '../../app/theme_controller.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';
import '../motion/theme_reveal_host.dart';

/// Light/dark switch. Hands its own screen position to [ThemeRevealHost] so
/// the circular reveal starts exactly under the cursor.
///
/// Requires ThemeRevealHost to wrap the app — see app.dart.
class ThemeToggleButton extends StatefulWidget {
  final bool compact;

  const ThemeToggleButton({super.key, this.compact = false});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  // Held in state, not build — a key rebuilt every frame cannot be located.
  final GlobalKey _key = GlobalKey();

  void _handleTap() {
    final box = _key.currentContext?.findRenderObject();

    if (box is! RenderBox) {
      themeController.toggle();
      return;
    }

    final origin = box.localToGlobal(Offset.zero);
    ThemeRevealHost.trigger(
      origin + Offset(box.size.width / 2, box.size.height / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return HoverBuilder(
      builder: (context, hovered) {
        return GestureDetector(
          key: _key,
          onTap: _handleTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? AppSpacing.xs : AppSpacing.xs + 2,
              vertical: AppSpacing.xxs + 2,
            ),
            decoration: BoxDecoration(
              borderRadius: AppRadius.brPill,
              color: hovered ? context.ink(AppColors.emphasisWash) : null,
              border: Border.all(
                color: context.ink(
                  hovered ? AppColors.emphasisFaint : AppColors.emphasisHairline,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.cs.onSurface,
                  ),
                  child: AnimatedSwitcher(
                    duration: AppDurations.fast,
                    child: Icon(
                      isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      key: ValueKey(isDark),
                      size: 14,
                      color: context.cs.surface,
                    ),
                  ),
                ),
                if (!widget.compact) ...[
                  const Gap.h(AppSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: Text(
                      isDark ? 'DARK' : 'LIGHT',
                      style: AppTypography.eyebrow
                          .copyWith(color: context.cs.onSurface),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
