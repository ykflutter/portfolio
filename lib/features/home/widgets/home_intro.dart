import 'package:flutter/material.dart';

import '../../../core/extensions/animate_ext.dart';
import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/motion/blinking_cursor.dart';
import '../../../shared/motion/decode_text.dart';
import 'home_actions.dart';

/// Name (decodes in), role line with a blinking caret, and the two actions.
class HomeIntro extends StatelessWidget {
  final ValueChanged<String> onNavigate;
  final bool centered;

  /// Smaller type for a phone held sideways.
  final bool compact;

  const HomeIntro({
    super.key,
    required this.onNavigate,
    this.centered = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final nameStyle = compact || context.isMobile
        ? AppTypography.displayMd
        : (context.isTablet ? AppTypography.displayLg : AppTypography.displayXl);

    final align = centered ? TextAlign.center : TextAlign.start;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        DecodeText(
          ProfileData.name,
          style: nameStyle.copyWith(color: context.cs.onSurface),
          textAlign: align,
          delay: const Duration(milliseconds: 250),
        ),
        const Gap(AppSpacing.xs),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                ProfileData.homeRole,
                textAlign: align,
                style: AppTypography.titleMd.copyWith(
                  color: context.ink(AppColors.emphasisMuted),
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const Gap.h(6),
            const BlinkingCursor(height: 18),
          ],
        ).entrance(context, delay: const Duration(milliseconds: 900)),
        Gap(compact ? AppSpacing.lg : AppSpacing.xl),
        HomeActions(onNavigate: onNavigate, centered: centered)
            .entrance(context, delay: const Duration(milliseconds: 1100)),
      ],
    );
  }
}
