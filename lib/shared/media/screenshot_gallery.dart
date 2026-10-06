import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_spacing.dart';
import 'device_frame.dart';

/// A row of phone mockups. Scrolls horizontally on narrow screens, and the
/// frames overlap slightly on wide ones so a set of three reads as one object
/// rather than three loose images.
class ScreenshotGallery extends StatelessWidget {
  final List<String> imagePaths;
  final double frameWidth;
  final bool overlap;

  const ScreenshotGallery({
    super.key,
    required this.imagePaths,
    this.frameWidth = 200,
    this.overlap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) return const SizedBox.shrink();

    final useOverlap = overlap && context.isDesktop && imagePaths.length > 1;

    if (useOverlap) {
      return SizedBox(
        height: frameWidth * (19.5 / 9) + 24,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(imagePaths.length, (i) {
            final offset = (i - (imagePaths.length - 1) / 2) * frameWidth * 0.62;
            final depth = (i - (imagePaths.length - 1) / 2).abs();

            return Transform.translate(
              offset: Offset(offset, depth * 14),
              child: Transform.scale(
                scale: 1 - depth * 0.06,
                child: DeviceFrame(
                  imagePath: imagePaths[i],
                  width: frameWidth,
                ),
              ),
            );
          }),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: context.gutter),
      child: Row(
        children: [
          for (var i = 0; i < imagePaths.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.md),
            DeviceFrame(imagePath: imagePaths[i], width: frameWidth),
          ],
        ],
      ),
    );
  }
}
