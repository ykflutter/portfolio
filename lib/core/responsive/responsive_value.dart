import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Pick a value per breakpoint without a pile of ternaries in the widget tree.
///
///   final pad = const ResponsiveValue<double>(
///     mobile: 24, tablet: 48, desktop: 80,
///   ).resolve(context);
///
/// Only [mobile] is required; larger sizes fall back downward, so you declare
/// just the breakpoints that actually differ.
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? wide;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  T resolve(BuildContext context) {
    return resolveFor(Breakpoints.of(MediaQuery.sizeOf(context).width));
  }

  T resolveFor(ScreenSize size) {
    switch (size) {
      case ScreenSize.wide:
        return wide ?? desktop ?? tablet ?? mobile;
      case ScreenSize.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.mobile:
        return mobile;
    }
  }
}
