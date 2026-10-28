import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../motion/hover_builder.dart';
import '../motion/hud_corners.dart';
import '../motion/press_scale.dart';

/// The base surface every card in the app is built on.
///
/// One border colour, one radius, one hover behaviour — so cards across
/// pages can never drift apart. Tappable cards get HUD corners on hover and
/// press in on tap.
class BorderedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final BorderRadius radius;
  final String? semanticLabel;

  const BorderedCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.radius = AppRadius.brMd,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return _surface(context, hovered: false);

    return Semantics(
      button: true,
      label: semanticLabel,
      child: PressScale(
        scale: 0.985,
        child: HoverBuilder(
          builder: (context, hovered) => GestureDetector(
            onTap: onTap,
            child: HudCorners(
              visible: hovered,
              child: _surface(context, hovered: hovered),
            ),
          ),
        ),
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
        color: hovered
            ? Color.alphaBlend(
                context.ink(AppColors.emphasisWash),
                context.palette.card,
              )
            : context.palette.card,
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
