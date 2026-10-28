import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/content/profile_data.dart';
import '../buttons/theme_toggle_button.dart';
import '../media/animated_logo.dart';
import '../motion/hover_builder.dart';
import 'max_width_box.dart';
import 'nav_bar_item.dart';

/// Sticky, blurred top bar.
///
/// Desktop shows the links inline; smaller screens show a menu button.
/// The home page passes `minimal: true` — no brand, no links, just the theme
/// toggle and the menu — so the hero stays the only thing on the page.
class NavBar extends StatelessWidget {
  final List<NavDestination> destinations;
  final String currentPath;
  final ValueChanged<String> onNavigate;
  final VoidCallback onMenuTap;
  final bool minimal;

  const NavBar({
    super.key,
    required this.destinations,
    required this.currentPath,
    required this.onNavigate,
    required this.onMenuTap,
    this.minimal = false,
  });

  bool _isActive(NavDestination d) =>
      currentPath == d.path || currentPath.startsWith('${d.path}/');

  @override
  Widget build(BuildContext context) {
    final showLinks = context.isDesktop && !minimal;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: context.cs.surface.withValues(alpha: minimal ? 0 : 0.72),
            border: Border(
              bottom: BorderSide(
                color: minimal
                    ? AppColors.transparent
                    : context.ink(AppColors.emphasisHairline),
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: MaxWidthBox(
              child: SizedBox(
                height: 64,
                child: Row(
                  children: [
                    if (!minimal)
                      _Brand(onTap: () => onNavigate(RoutePaths.home)),
                    const Spacer(),
                    if (showLinks) ...[
                      for (final d in destinations)
                        NavBarItem(
                          label: d.label,
                          active: _isActive(d),
                          onTap: () => onNavigate(d.path),
                        ),
                      const Gap.h(AppSpacing.md),
                      const ThemeToggleButton(),
                    ] else ...[
                      ThemeToggleButton(compact: context.isMobile),
                      const Gap.h(AppSpacing.xs),
                      _MenuButton(onTap: onMenuTap),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Logo + name. Goes home; the logo replays its animation on hover.
class _Brand extends StatelessWidget {
  final VoidCallback onTap;

  const _Brand({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Home',
      onTap: onTap,
      excludeSemantics: true,
      child: HoverBuilder(
        builder: (context, hovered) => GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedLogo(size: 30, onTap: onTap, borderRadius: AppRadius.brSm),
              if (!context.isMobile) ...[
                const Gap.h(AppSpacing.sm),
                Text(
                  ProfileData.name.toUpperCase(),
                  style: AppTypography.eyebrow.copyWith(
                    fontSize: 11,
                    color: context.ink(hovered ? 1.0 : AppColors.emphasisBody),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MenuButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Menu',
      child: Semantics(
        button: true,
        label: 'Open menu',
        onTap: onTap,
        excludeSemantics: true,
        child: HoverBuilder(
          builder: (context, hovered) => GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hovered ? context.ink(AppColors.emphasisWash) : null,
              ),
              child: Icon(Icons.menu_rounded, color: context.cs.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
