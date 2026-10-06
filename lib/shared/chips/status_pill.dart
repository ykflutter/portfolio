import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// "Open to opportunities" with a slow pulsing dot.
class StatusPill extends StatefulWidget {
  final String label;
  final Color dotColor;

  const StatusPill({
    super.key,
    required this.label,
    this.dotColor = AppColors.success,
  });

  @override
  State<StatusPill> createState() => _StatusPillState();
}

class _StatusPillState extends State<StatusPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: AppRadius.brPill,
        border: Border.all(color: context.ink(AppColors.emphasisHairline)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 8,
            height: 8,
            child: reduced
                ? _dot(1)
                : FadeTransition(
                    opacity: Tween<double>(begin: 1, end: 0.25)
                        .animate(_controller),
                    child: _dot(1),
                  ),
          ),
          const Gap.h(AppSpacing.xs),
          Text(
            widget.label,
            style: AppTypography.label.copyWith(color: context.cs.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _dot(double opacity) => DecoratedBox(
        decoration: BoxDecoration(
          color: widget.dotColor.withValues(alpha: opacity),
          shape: BoxShape.circle,
        ),
      );
}
