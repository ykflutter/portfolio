import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';

/// Borderless text link with a trailing arrow. For "Read article",
/// "View all", "Back" — anything that is a link rather than a button.
class IconTextButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool leadingIcon;

  const IconTextButton({
    super.key,
    required this.label,
    this.icon = Icons.arrow_forward_rounded,
    this.onTap,
    this.leadingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) {
        final iconWidget = AnimatedSlide(
          offset: hovered
              ? Offset(leadingIcon ? -0.18 : 0.18, 0)
              : Offset.zero,
          duration: AppDurations.fast,
          curve: AppDurations.ease,
          child: Icon(icon, size: 15, color: context.cs.secondary),
        );

        return GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon) ...[
                iconWidget,
                const Gap.h(AppSpacing.xs - 2),
              ],
              Text(
                label,
                style: AppTypography.label.copyWith(
                  color: context.cs.secondary,
                  decoration:
                      hovered ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: context.ink(AppColors.emphasisFaint),
                ),
              ),
              if (!leadingIcon) ...[
                const Gap.h(AppSpacing.xs - 2),
                iconWidget,
              ],
            ],
          ),
        );
      },
    );
  }
}
