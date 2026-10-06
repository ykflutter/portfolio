import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Portrait, or initials if no photo is set.
///
/// A real face converts better than initials — but a confident typographic
/// mark beats a stretched or low-quality photo, so both paths are supported.
class AvatarMark extends StatelessWidget {
  final String initials;
  final String? imagePath;
  final double size;

  const AvatarMark({
    super.key,
    required this.initials,
    this.imagePath,
    this.size = 260,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.cs.surfaceContainerHighest,
        border: Border.all(
          color: context.cs.onSurface,
          width: size * 0.027,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: imagePath == null
          ? _initials(context)
          : Image.asset(
              imagePath!,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (_, __, ___) => _initials(context),
            ),
    );
  }

  Widget _initials(BuildContext context) {
    return Text(
      initials,
      style: AppTypography.displayXl.copyWith(
        fontSize: size * 0.33,
        color: context.ink(AppColors.emphasisBody),
      ),
    );
  }
}
