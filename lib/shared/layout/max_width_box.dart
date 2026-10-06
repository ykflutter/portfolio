import 'package:flutter/widgets.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_spacing.dart';

/// Centres content, caps its width, and applies the breakpoint's gutter.
/// Every page section sits inside one of these so nothing drifts out of
/// alignment on a wide monitor.
class MaxWidthBox extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final bool applyGutter;

  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = AppSpacing.maxContentWidth,
    this.applyGutter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: applyGutter ? context.gutter : 0,
          ),
          child: child,
        ),
      ),
    );
  }
}
