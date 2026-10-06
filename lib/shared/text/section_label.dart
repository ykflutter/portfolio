import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// The small all-caps eyebrow above a section title — "WORK HISTORY".
class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.eyebrow.copyWith(
        color: context.ink(AppColors.emphasisFaint),
      ),
    );
  }
}
