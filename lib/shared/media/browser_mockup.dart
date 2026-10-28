import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';

/// Wraps a landscape web screenshot in a minimal browser window.
///
/// Takes the width it is given; height follows from the screenshot aspect.
class BrowserMockup extends StatelessWidget {
  final String? imagePath;

  /// Null means "fill the parent's width".
  final double? width;

  final Widget? placeholder;

  const BrowserMockup({
    super.key,
    this.imagePath,
    this.width,
    this.placeholder,
  });

  /// Matches the 2704 × 1756 screenshots.
  static const double aspect = 2704 / 1756;

  static const double barHeight = 24;

  static double heightFor(double width) => barHeight + width / aspect;

  @override
  Widget build(BuildContext context) {
    final fallback = placeholder ??
        ColoredBox(color: context.cs.surfaceContainerHighest);

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: context.palette.card,
        borderRadius: AppRadius.brSm,
        border: Border.all(color: context.ink(AppColors.emphasisHairline)),
        boxShadow: [
          BoxShadow(
            color: context.ink(AppColors.emphasisHairline),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: barHeight,
            child: Row(
              children: [
                const Gap.h(10),
                for (var i = 0; i < 3; i++) ...[
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.ink(AppColors.emphasisHairline),
                    ),
                  ),
                  const Gap.h(5),
                ],
                const Gap.h(8),
                Expanded(
                  child: Container(
                    height: 12,
                    margin: const EdgeInsets.only(right: 40),
                    decoration: BoxDecoration(
                      color: context.ink(AppColors.emphasisWash),
                      borderRadius: AppRadius.brPill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: aspect,
            child: imagePath == null
                ? fallback
                : Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (_, _, _) => fallback,
                  ),
          ),
        ],
      ),
    );
  }
}
