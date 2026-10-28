import 'package:flutter/animation.dart';

/// Every animation timing in the app, so motion feels like one system.
class AppDurations {
  AppDurations._();

  /// Hover, focus, colour shifts.
  static const Duration instant = Duration(milliseconds: 160);

  /// Buttons, chips, small state changes.
  static const Duration fast = Duration(milliseconds: 220);

  /// Section reveals, page fades.
  static const Duration medium = Duration(milliseconds: 400);

  /// Theme circular reveal.
  static const Duration slow = Duration(milliseconds: 520);

  /// Stat counters.
  static const Duration counter = Duration(milliseconds: 1100);

  /// Delay between staggered children.
  static const Duration stagger = Duration(milliseconds: 70);

  /// How long each logo frame is held.
  static const Duration logoFrame = Duration(milliseconds: 140);

  /// Letter-by-letter name decode on the home page.
  static const Duration decode = Duration(milliseconds: 900);

  /// Standard easing — decelerating, never bouncy. Bounce reads as toy-like
  /// in an editorial layout.
  static const Curve ease = Curves.easeOutCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
}
