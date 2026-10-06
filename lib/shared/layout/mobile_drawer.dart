import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'nav_bar.dart';

/// Full-height mobile menu. Links are set in display type rather than list
/// rows — on a portfolio the menu is a moment, not a settings screen.
class MobileDrawer extends StatelessWidget {
  final List<NavDestination> destinations;
  final String currentPath;
  final ValueChanged<String> onNavigate;

  const MobileDrawer({
    super.key,
    required this.destinations,
    required this.currentPath,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.cs.surface,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: context.cs.onSurface,
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              for (final d in destinations)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).maybePop();
                      onNavigate(d.path);
                    },
                    child: Text(
                      d.label,
                      style: AppTypography.displaySm.copyWith(
                        color: context.ink(
                          currentPath == d.path
                              ? 1.0
                              : AppColors.emphasisMuted,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
