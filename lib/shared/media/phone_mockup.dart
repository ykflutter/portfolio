import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';

/// Wraps a portrait screenshot in a phone bezel.
///
/// Renamed from DeviceFrame so it never clashes with the device_frame
/// package's class of the same name.
class PhoneMockup extends StatelessWidget {
  final String? imagePath;
  final double width;

  /// Shown when there is no image, or the image fails to load.
  final Widget? placeholder;

  const PhoneMockup({
    super.key,
    this.imagePath,
    this.width = 240,
    this.placeholder,
  });

  /// Matches the 1206 × 2622 screenshots.
  static const double aspect = 2622 / 1206;

  static double heightFor(double width) => width * aspect;

  @override
  Widget build(BuildContext context) {
    final height = heightFor(width);
    final radius = width * 0.12;
    final bezel = width * 0.028;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(bezel),
      decoration: BoxDecoration(
        color: context.palette.bezel,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: context.ink(AppColors.emphasisHairline)),
        boxShadow: [
          BoxShadow(
            color: context.ink(AppColors.emphasisHairline),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - bezel),
        child: _screen(context),
      ),
    );
  }

  Widget _screen(BuildContext context) {
    final fallback = placeholder ??
        ColoredBox(color: context.cs.surfaceContainerHighest);

    if (imagePath == null) return fallback;

    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, _, _) => fallback,
    );
  }
}
