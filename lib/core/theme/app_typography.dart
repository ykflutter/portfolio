import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The type scale.
///
/// Two families on purpose: a geometric display face carries the headlines,
/// a neutral face carries everything you actually read. In a monochrome
/// layout the type scale IS the hierarchy, so the jump from display to body
/// is deliberately large.
class AppTypography {
  AppTypography._();

  static TextStyle _display(double size, {double? height, double? spacing}) {
    return GoogleFonts.baiJamjuree(
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: height ?? 1.04,
      letterSpacing: spacing ?? -size * 0.022,
    );
  }

  static TextStyle _body(
    double size, {
    FontWeight weight = FontWeight.w400,
    double height = 1.6,
    double spacing = 0,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: spacing,
    );
  }

  // ── Display (headlines) ──────────────────────────────────────────────────
  static TextStyle get displayXl => _display(96);
  static TextStyle get displayLg => _display(72);
  static TextStyle get displayMd => _display(48);
  static TextStyle get displaySm => _display(34, height: 1.12);

  // ── Titles ───────────────────────────────────────────────────────────────
  static TextStyle get titleLg =>
      _body(22, weight: FontWeight.w700, height: 1.3);
  static TextStyle get titleMd =>
      _body(17, weight: FontWeight.w600, height: 1.35);
  static TextStyle get titleSm =>
      _body(15, weight: FontWeight.w600, height: 1.4);

  // ── Body ─────────────────────────────────────────────────────────────────
  static TextStyle get bodyLg => _body(17, height: 1.7);
  static TextStyle get bodyMd => _body(15);
  static TextStyle get bodySm => _body(13, height: 1.55);

  // ── Labels ───────────────────────────────────────────────────────────────
  static TextStyle get label =>
      _body(12, weight: FontWeight.w600, height: 1.3, spacing: 0.2);

  /// The small all-caps eyebrow above section titles.
  static TextStyle get eyebrow =>
      _body(10, weight: FontWeight.w700, height: 1.2, spacing: 2.2);

  /// Monospace-feeling micro text for IDs, dates, counters.
  static TextStyle get micro =>
      _body(11, weight: FontWeight.w500, height: 1.3, spacing: 0.8);

  /// Material's TextTheme, so any stock widget inherits the system too.
  static TextTheme textTheme(Color ink) {
    return TextTheme(
      displayLarge: displayXl.copyWith(color: ink),
      displayMedium: displayLg.copyWith(color: ink),
      displaySmall: displayMd.copyWith(color: ink),
      headlineMedium: displaySm.copyWith(color: ink),
      titleLarge: titleLg.copyWith(color: ink),
      titleMedium: titleMd.copyWith(color: ink),
      titleSmall: titleSm.copyWith(color: ink),
      bodyLarge: bodyLg.copyWith(color: ink),
      bodyMedium: bodyMd.copyWith(color: ink),
      bodySmall: bodySm.copyWith(color: ink),
      labelLarge: label.copyWith(color: ink),
      labelMedium: micro.copyWith(color: ink),
      labelSmall: eyebrow.copyWith(color: ink),
    );
  }
}
