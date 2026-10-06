import 'package:flutter/rendering.dart';

/// Expands a circle from a point until it covers the screen.
/// Used by the theme switch.
class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;

  const CircularRevealClipper({required this.fraction, required this.center});

  @override
  Path getClip(Size size) {
    // Distance to the furthest corner, so the circle always fills the screen
    // regardless of where the tap landed.
    final dx = center.dx > size.width / 2 ? center.dx : size.width - center.dx;
    final dy =
        center.dy > size.height / 2 ? center.dy : size.height - center.dy;
    final maxRadius = Offset(dx, dy).distance;

    return Path()
      ..addOval(
        Rect.fromCircle(center: center, radius: maxRadius * fraction),
      );
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) =>
      oldClipper.fraction != fraction || oldClipper.center != center;
}
