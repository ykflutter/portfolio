import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic colours that Material's ColorScheme has no slot for.
///
/// Widgets read `context.palette.card` instead of asking "am I dark?" — so
/// light and dark mode can never drift apart, and the theme switch animates
/// them through [lerp].
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  /// Card and panel fill.
  final Color card;

  /// Backdrop behind phone and browser mockups.
  final Color stage;

  /// Phone bezel.
  final Color bezel;

  /// Cursor spotlight and hover glow.
  final Color glow;

  /// The faint dot grid behind every page.
  final Color gridDot;

  /// Placeholder shimmer.
  final Color shimmerBase;
  final Color shimmerHighlight;

  const AppPalette({
    required this.card,
    required this.stage,
    required this.bezel,
    required this.glow,
    required this.gridDot,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  static final AppPalette light = AppPalette(
    card: AppColors.lightSurface,
    stage: AppColors.lightSurfaceAlt,
    bezel: AppColors.lightInk,
    glow: AppColors.lightInk.withValues(alpha: 0.06),
    gridDot: AppColors.lightInk.withValues(alpha: 0.09),
    shimmerBase: AppColors.lightSurfaceAlt,
    shimmerHighlight: AppColors.lightSurface,
  );

  static final AppPalette dark = AppPalette(
    card: AppColors.darkSurface,
    stage: AppColors.darkSurfaceAlt,
    bezel: AppColors.darkBezel,
    glow: AppColors.darkInk.withValues(alpha: 0.07),
    gridDot: AppColors.darkInk.withValues(alpha: 0.07),
    shimmerBase: AppColors.darkSurfaceAlt,
    shimmerHighlight: AppColors.darkShimmer,
  );

  @override
  AppPalette copyWith({
    Color? card,
    Color? stage,
    Color? bezel,
    Color? glow,
    Color? gridDot,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return AppPalette(
      card: card ?? this.card,
      stage: stage ?? this.stage,
      bezel: bezel ?? this.bezel,
      glow: glow ?? this.glow,
      gridDot: gridDot ?? this.gridDot,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;

    return AppPalette(
      card: Color.lerp(card, other.card, t)!,
      stage: Color.lerp(stage, other.stage, t)!,
      bezel: Color.lerp(bezel, other.bezel, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      gridDot: Color.lerp(gridDot, other.gridDot, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight:
          Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }
}
