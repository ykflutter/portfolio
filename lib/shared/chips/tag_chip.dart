import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../motion/hover_builder.dart';

/// A small tech / category tag.
///
/// With [onTap] it becomes a link — it gains a hover state, an arrow, and a
/// tooltip saying where it goes. Without, it is plain text with a border.
class TagChip extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback? onTap;
  final String? tooltip;

  const TagChip(
    this.label, {
    super.key,
    this.filled = false,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return _chip(context, hovered: false);

    final chip = Semantics(
      button: true,
      label: tooltip ?? label,
      onTap: onTap,
      excludeSemantics: true,
      child: HoverBuilder(
        builder: (context, hovered) => GestureDetector(
          onTap: onTap,
          child: _chip(context, hovered: hovered),
        ),
      ),
    );

    return tooltip == null ? chip : Tooltip(message: tooltip!, child: chip);
  }

  Widget _chip(BuildContext context, {required bool hovered}) {
    final linked = onTap != null;

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppDurations.ease,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs + 2,
        vertical: AppSpacing.xxs + 1,
      ),
      decoration: BoxDecoration(
        borderRadius: AppRadius.brXs,
        color: hovered
            ? context.cs.onSurface
            : (filled ? context.ink(AppColors.emphasisWash) : null),
        border: filled && !hovered
            ? null
            : Border.all(
                color: hovered
                    ? context.cs.onSurface
                    : context.ink(
                        linked
                            ? AppColors.emphasisFaint
                            : AppColors.emphasisHairline,
                      ),
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.micro.copyWith(
              color: hovered
                  ? context.cs.surface
                  : context.ink(
                      linked ? AppColors.emphasisBody : AppColors.emphasisMuted,
                    ),
            ),
          ),
          if (linked) ...[
            const Gap.h(4),
            Icon(
              Icons.arrow_outward_rounded,
              size: 11,
              color: hovered
                  ? context.cs.surface
                  : context.ink(AppColors.emphasisFaint),
            ),
          ],
        ],
      ),
    );
  }
}
