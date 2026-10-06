import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Builds different widget trees per breakpoint.
///
/// Prefer [ResponsiveValue] when only a number changes — reach for this only
/// when the LAYOUT genuinely differs (a column becoming a row, say).
/// Larger breakpoints fall back downward.
class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? wide;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (Breakpoints.of(constraints.maxWidth)) {
          case ScreenSize.wide:
            return (wide ?? desktop ?? tablet ?? mobile)(context);
          case ScreenSize.desktop:
            return (desktop ?? tablet ?? mobile)(context);
          case ScreenSize.tablet:
            return (tablet ?? mobile)(context);
          case ScreenSize.mobile:
            return mobile(context);
        }
      },
    );
  }
}
