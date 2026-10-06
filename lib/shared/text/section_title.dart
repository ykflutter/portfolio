import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_typography.dart';

/// A section headline. Scales itself by breakpoint, so no caller does
/// `isMobile ? 36 : 48` ever again.
class SectionTitle extends StatelessWidget {
  final String text;
  final bool large;
  final TextAlign? align;

  const SectionTitle(this.text, {super.key, this.large = false, this.align});

  @override
  Widget build(BuildContext context) {
    final TextStyle style;

    if (large) {
      style = context.isMobile
          ? AppTypography.displayMd
          : (context.isTablet
              ? AppTypography.displayLg
              : AppTypography.displayXl);
    } else {
      style = context.isMobile
          ? AppTypography.displaySm
          : AppTypography.displayMd;
    }

    return Text(
      text,
      textAlign: align,
      style: style.copyWith(color: context.cs.onSurface),
    );
  }
}
