import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../buttons/theme_toggle_button.dart';
import '../motion/hover_builder.dart';
import 'max_width_box.dart';
import 'nav_bar_item.dart';

class NavDestination {
  final String label;
  final String path;

  const NavDestination({required this.label, required this.path});
}

/// Sticky, blurred top bar. Desktop shows links inline; mobile shows a menu
/// button and hands the links to the drawer.
class NavBar extends StatelessWidget {
  final List<NavDestination> destinations;
  final String currentPath;
  final ValueChanged<String> onNavigate;
  final VoidCallback? onMenuTap;
  final String brand;

  const NavBar({
    super.key,
    required this.destinations,
    required this.currentPath,
    required this.onNavigate,
    this.onMenuTap,
    this.brand = 'YK',
  });

  bool _isActive(NavDestination d) {
    if (d.path == '/') return currentPath == '/';
    return currentPath == d.path || currentPath.startsWith('${d.path}/');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: context.cs.surface.withValues(alpha: 0.72),
            border: Border(
              bottom: BorderSide(
                color: context.ink(AppColors.emphasisHairline),
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
                    _Brand(brand: brand, onTap: () => onNavigate('/')),
                    const Spacer(),
                    if (context.isDesktop) ...[
                      for (final d in destinations)
                        NavBarItem(
                          label: d.label,
                          active: _isActive(d),
                          onTap: () => onNavigate(d.path),
                        ),
                      const Gap.h(AppSpacing.md),
                      const ThemeToggleButton(),
                    ] else ...[
                      const ThemeToggleButton(compact: true),
                      const Gap.h(AppSpacing.xxs),
                      IconButton(
                        onPressed: onMenuTap,
                        icon: Icon(
                          Icons.menu_rounded,
                          color: context.cs.onSurface,
                        ),
                      ),
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

class _Brand extends StatelessWidget {
  final String brand;
  final VoidCallback onTap;

  const _Brand({required this.brand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) => GestureDetector(
        onTap: onTap,
        child: Text(
          brand,
          style: AppTypography.titleMd.copyWith(
            color: context.ink(hovered ? 1.0 : AppColors.emphasisBody),
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
