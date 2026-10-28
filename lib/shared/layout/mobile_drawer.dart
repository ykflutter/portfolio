import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../core/constants/app_links.dart';
import '../../core/extensions/animate_ext.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/launcher.dart';
import '../../data/content/socials_data.dart';
import '../buttons/primary_button.dart';
import '../media/social_icon.dart';
import '../motion/hover_builder.dart';

/// The site menu: every page, the resume, and the social links.
///
/// Links are set in display type rather than list rows and slide in one by
/// one — on a portfolio the menu is a moment, not a settings screen.
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

  bool _isActive(NavDestination d) {
    if (d.path == '/') return currentPath == '/';
    return currentPath == d.path || currentPath.startsWith('${d.path}/');
  }

  void _go(BuildContext context, String path) {
    Navigator.of(context).maybePop();
    onNavigate(path);
  }

  @override
  Widget build(BuildContext context) {
    final links = [NavDestinations.home, ...destinations];

    return Drawer(
      backgroundColor: context.cs.surface,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'MENU',
                    style: AppTypography.eyebrow.copyWith(
                      color: context.ink(AppColors.emphasisFaint),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Close menu',
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.cs.onSurface,
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.lg),
              for (var i = 0; i < links.length; i++)
                _MenuLink(
                  index: i,
                  label: links[i].label,
                  active: _isActive(links[i]),
                  onTap: () => _go(context, links[i].path),
                ).entrance(
                  context,
                  delay: AppDurations.stagger * i,
                  dx: 0.12,
                  dy: 0,
                ),
              const Gap(AppSpacing.xl),
              PrimaryButton(
                label: 'Download Resume',
                icon: Icons.download_rounded,
                expand: true,
                onTap: () => Launcher.document(
                  AppLinks.resume,
                  unavailableMessage: 'Resume is not available yet.',
                ),
              ),
              const Gap(AppSpacing.lg),
              Row(
                children: [
                  for (final social in SocialsData.clickable) ...[
                    IconButton(
                      tooltip: social.label,
                      onPressed: () => Launcher.open(social.url),
                      icon: SocialIcon(
                        social.kind,
                        size: 18,
                        color: context.ink(AppColors.emphasisBody),
                      ),
                    ),
                    const Gap.h(AppSpacing.xxs),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "01  My Work" — numbered like a level select.
class _MenuLink extends StatelessWidget {
  final int index;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _MenuLink({
    required this.index,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: active,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: HoverBuilder(
        builder: (context, hovered) {
          final lit = hovered || active;

          return GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: AnimatedSlide(
                offset: hovered ? const Offset(0.03, 0) : Offset.zero,
                duration: AppDurations.fast,
                curve: AppDurations.ease,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    SizedBox(
                      width: 32,
                      child: Text(
                        (index + 1).toString().padLeft(2, '0'),
                        style: AppTypography.micro.copyWith(
                          color: context.ink(AppColors.emphasisFaint),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        label,
                        style: AppTypography.displaySm.copyWith(
                          fontSize: 28,
                          color: context.ink(
                            lit ? 1.0 : AppColors.emphasisMuted,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
