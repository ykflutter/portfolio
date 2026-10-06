import 'package:flutter/material.dart';

import '../responsive/breakpoints.dart';
import '../theme/app_spacing.dart';

/// Shorthands that remove the Theme.of / MediaQuery.of noise from every build.
extension ContextTheme on BuildContext {
  ThemeData get theme => Theme.of(this);

  /// Colours.  context.cs.onSurface
  ColorScheme get cs => Theme.of(this).colorScheme;

  /// Text styles.  context.tt.bodyMedium
  TextTheme get tt => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Ink at a given emphasis from the AppColors opacity ladder.
  Color ink([double alpha = 1]) =>
      Theme.of(this).colorScheme.onSurface.withValues(alpha: alpha);
}

extension ContextLayout on BuildContext {
  Size get screen => MediaQuery.sizeOf(this);

  ScreenSize get screenSize => Breakpoints.of(MediaQuery.sizeOf(this).width);

  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;

  /// True for desktop AND wide — the usual "is this a pointer-driven layout"
  /// question.
  bool get isDesktop =>
      screenSize == ScreenSize.desktop || screenSize == ScreenSize.wide;

  /// Horizontal page gutter for the current breakpoint.
  double get gutter {
    switch (screenSize) {
      case ScreenSize.mobile:
        return AppSpacing.gutterMobile;
      case ScreenSize.tablet:
        return AppSpacing.gutterTablet;
      case ScreenSize.desktop:
      case ScreenSize.wide:
        return AppSpacing.gutterDesktop;
    }
  }

  /// Vertical gap between major sections.
  double get sectionGap =>
      isMobile ? AppSpacing.sectionMobile : AppSpacing.sectionDesktop;
}
