import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import 'home_intro.dart';
import 'home_logo.dart';

/// Centres the logo and intro in whatever space is left under the nav bar.
///
/// Portrait: stacked and centred. A phone turned sideways (wide but short):
/// logo on the left, text on the right, so nothing needs scrolling. If the
/// window is smaller still, it scrolls rather than overflowing.
class HomeHero extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const HomeHero({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sideways =
            constraints.maxWidth > constraints.maxHeight &&
            constraints.maxHeight < 520;

        final double logoSize = sideways
            ? (constraints.maxHeight * 0.48).clamp(96.0, 180.0).toDouble()
            : switch (context.screenSize) {
                ScreenSize.mobile => 132.0,
                ScreenSize.tablet => 168.0,
                ScreenSize.desktop || ScreenSize.wide => 196.0,
              };

        final content = sideways
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeLogo(size: logoSize),
                  const Gap.h(AppSpacing.xl),
                  Flexible(
                    child: HomeIntro(onNavigate: onNavigate, compact: true),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeLogo(size: logoSize),
                  const Gap(AppSpacing.lg),
                  HomeIntro(onNavigate: onNavigate, centered: true),
                ],
              );

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.gutter,
                  AppSpacing.lg,
                  context.gutter,
                  // Optical centre sits a little above true centre.
                  AppSpacing.xxl,
                ),
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}
