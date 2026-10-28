import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_durations.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/motion/hover_builder.dart';
import '../../../shared/motion/press_scale.dart';

/// One filter chip on /work: "Fintech & Crypto  2". Solid when selected.
class FilterPill extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const FilterPill({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Show $label projects, $count',
      onTap: onTap,
      excludeSemantics: true,
      child: PressScale(
        child: HoverBuilder(
          builder: (context, hovered) {
            final fg = selected ? context.cs.surface : context.cs.onSurface;

            return GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: AppDurations.fast,
                curve: AppDurations.ease,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.brPill,
                  color: selected
                      ? context.cs.onSurface
                      : (hovered ? context.ink(AppColors.emphasisWash) : null),
                  border: Border.all(
                    color: selected
                        ? context.cs.onSurface
                        : context.ink(
                            hovered
                                ? AppColors.emphasisFaint
                                : AppColors.emphasisHairline,
                          ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label, style: AppTypography.label.copyWith(color: fg)),
                    const Gap.h(6),
                    Text(
                      '$count',
                      style: AppTypography.micro.copyWith(
                        color: fg.withValues(alpha: AppColors.emphasisMuted),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
