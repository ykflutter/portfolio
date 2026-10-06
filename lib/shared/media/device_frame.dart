import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';

/// Wraps a screenshot in a phone bezel.
///
/// A raw screenshot floating on a page reads as a stray image; the same shot
/// inside a device reads as a shipped product. For a mobile developer's
/// portfolio that difference matters more than almost anything else.
class DeviceFrame extends StatelessWidget {
  final String? imagePath;
  final double width;
  final Widget? child;

  const DeviceFrame({
    super.key,
    this.imagePath,
    this.width = 240,
    this.child,
  });

  /// iPhone-ish aspect. Screenshots are nearly always this shape.
  static const double _aspect = 19.5 / 9;

  @override
  Widget build(BuildContext context) {
    final height = width * _aspect;
    final radius = width * 0.12;
    final bezel = width * 0.022;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(bezel),
      decoration: BoxDecoration(
        color: context.cs.onSurface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: context.ink(AppColors.emphasisHairline),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - bezel),
        child: child ?? _image(context),
      ),
    );
  }

  Widget _image(BuildContext context) {
    if (imagePath == null) return _fallback(context);

    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => _fallback(context),
    );
  }

  Widget _fallback(BuildContext context) {
    return ColoredBox(
      color: context.cs.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.phone_iphone_rounded,
          size: width * 0.2,
          color: context.ink(AppColors.emphasisFaint),
        ),
      ),
    );
  }
}
