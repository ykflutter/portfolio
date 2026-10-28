import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_durations.dart';

/// One entrance animation for anything that appears on load rather than on
/// scroll (home hero, menu links, 404). Skipped under "reduce motion".
extension EntranceAnimation on Widget {
  Widget entrance(
    BuildContext context, {
    Duration delay = Duration.zero,
    double dy = 0.18,
    double dx = 0,
  }) {
    if (MediaQuery.disableAnimationsOf(context)) return this;

    return animate(delay: delay)
        .fadeIn(duration: AppDurations.medium, curve: AppDurations.ease)
        .slide(
          begin: Offset(dx, dy),
          end: Offset.zero,
          duration: AppDurations.medium,
          curve: AppDurations.ease,
        );
  }
}
