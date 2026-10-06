import 'package:flutter/material.dart';

/// Every colour in the app. Nothing else may declare a raw Color.
///
/// The palette is deliberately monochrome. Hierarchy comes from type scale and
/// opacity, not hue — which is what keeps an editorial black-and-white layout
/// from reading as "unstyled".
class AppColors {
  AppColors._();

  // ── Light ────────────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFFBFBFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFF2F2F0);
  static const Color lightInk = Color(0xFF0A0A0A);
  static const Color lightOutline = Color(0xFFE2E2DF);

  /// The one accent. Used ONLY for links and active states.
  /// Set this equal to [lightInk] for strict monochrome.
  static const Color lightAccent = Color(0xFF2B2B2B);

  // ── Dark ─────────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkSurfaceAlt = Color(0xFF1A1A1A);
  static const Color darkInk = Color(0xFFF5F3EF);
  static const Color darkOutline = Color(0xFF262626);

  /// Warm bone — reads as light but never pure white, so links separate
  /// from body text without introducing a hue.
  static const Color darkAccent = Color(0xFFE8E0D4);

  // ── Shared ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFD93025);

  // ── Opacity ladder ───────────────────────────────────────────────────────
  // Use these instead of ad-hoc alpha values so every muted tone matches.
  static const double emphasisHigh = 1.0;
  static const double emphasisBody = 0.78;
  static const double emphasisMuted = 0.55;
  static const double emphasisFaint = 0.38;
  static const double emphasisHairline = 0.12;
  static const double emphasisWash = 0.05;
}
