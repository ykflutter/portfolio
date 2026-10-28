import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../core/constants/app_links.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/launcher.dart';
import '../../data/content/profile_data.dart';
import '../buttons/icon_text_button.dart';
import 'max_width_box.dart';

/// Every page ends here: who, the page links, the socials, back to top.
class AppFooter extends StatelessWidget {
  final ValueChanged<String> onNavigate;
  final VoidCallback onBackToTop;

  const AppFooter({
    super.key,
    required this.onNavigate,
    required this.onBackToTop,
  });

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final stacked = context.isMobile;

    final identity = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          ProfileData.name,
          style: AppTypography.titleSm.copyWith(color: context.cs.onSurface),
        ),
        const Gap(2),
        Text(
          '${ProfileData.role}  ·  ${ProfileData.location}',
          style: AppTypography.bodySm.copyWith(
            color: context.ink(AppColors.emphasisMuted),
          ),
        ),
      ],
    );

    final pages = Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.xs,
      children: [
        for (final d in NavDestinations.all)
          IconTextButton(
            label: d.label,
            icon: Icons.arrow_forward_rounded,
            onTap: () => onNavigate(d.path),
          ),
      ],
    );

    final socials = Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.xs,
      children: [
        IconTextButton(
          label: 'Email',
          icon: Icons.arrow_outward_rounded,
          onTap: () => Launcher.email(),
        ),
        IconTextButton(
          label: 'LinkedIn',
          icon: Icons.arrow_outward_rounded,
          onTap: () => Launcher.open(AppLinks.linkedin),
        ),
        IconTextButton(
          label: 'GitHub',
          icon: Icons.arrow_outward_rounded,
          onTap: () => Launcher.open(AppLinks.github),
        ),
        IconTextButton(
          label: 'Back to top',
          icon: Icons.arrow_upward_rounded,
          onTap: onBackToTop,
        ),
      ],
    );

    final copyright = Text(
      '© $year ${ProfileData.name}',
      style: AppTypography.bodySm.copyWith(
        color: context.ink(AppColors.emphasisFaint),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.ink(AppColors.emphasisHairline)),
        ),
      ),
      padding: EdgeInsets.only(
        top: AppSpacing.xl,
        bottom: AppSpacing.xl + MediaQuery.paddingOf(context).bottom,
      ),
      child: MaxWidthBox(
        child: stacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  identity,
                  const Gap(AppSpacing.lg),
                  pages,
                  const Gap(AppSpacing.lg),
                  socials,
                  const Gap(AppSpacing.lg),
                  copyright,
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      identity,
                      const Gap.h(AppSpacing.xl),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: pages,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.lg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      copyright,
                      const Gap.h(AppSpacing.xl),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: socials,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
