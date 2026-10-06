import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../motion/hover_builder.dart';

/// The base surface every card in the app is built on.
///
/// One border colour, one radius, one hover behaviour — so cards across
/// Projects, Skills and Contact can never drift apart.
class BorderedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool interactive;
  final BorderRadius radius;

  const BorderedCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.interactive = false,
    this.radius = AppRadius.brMd,
  });

  @override
  Widget build(BuildContext context) {
    final isInteractive = interactive || onTap != null;

    if (!isInteractive) return _surface(context, hovered: false);

    return HoverBuilder(
      builder: (context, hovered) => GestureDetector(
        onTap: onTap,
        child: _surface(context, hovered: hovered),
      ),
    );
  }

  Widget _surface(BuildContext context, {required bool hovered}) {
    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppDurations.ease,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: radius,
        color: hovered ? context.ink(AppColors.emphasisWash) : null,
        border: Border.all(
          color: context.ink(
            hovered ? AppColors.emphasisFaint : AppColors.emphasisHairline,
          ),
        ),
      ),
      child: child,
    );
  }
}
