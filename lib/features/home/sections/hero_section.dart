import 'package:flutter/material.dart';

import '../../../core/constants/app_links.dart';
import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/launcher.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/buttons/outline_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/chips/status_pill.dart';
import '../../../shared/media/avatar_mark.dart';
import '../../../shared/motion/reveal_on_scroll.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;

  const HeroSection({super.key, required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    final text = _text(context);

    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text,
          const Gap(AppSpacing.xl),
          Center(
            child: AvatarMark(
              initials: ProfileData.initials,
              imagePath: ProfileData.portraitPath,
              size: 180,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: text),
        const Gap.h(AppSpacing.xl),
        Expanded(
          flex: 2,
          child: Center(
            child: AvatarMark(
              initials: ProfileData.initials,
              imagePath: ProfileData.portraitPath,
              size: context.isTablet ? 200 : 260,
            ),
          ),
        ),
      ],
    );
  }

  Widget _text(BuildContext context) {
    final nameStyle = context.isMobile
        ? AppTypography.displayMd
        : (context.isTablet
            ? AppTypography.displayLg
            : AppTypography.displayXl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RevealOnScroll(
          child: StatusPill(label: ProfileData.availability),
        ),
        const Gap(AppSpacing.md),
        RevealOnScroll(
          delay: const Duration(milliseconds: 60),
          child: Text(
            ProfileData.name,
            style: nameStyle.copyWith(color: context.cs.onSurface),
          ),
        ),
        const Gap(AppSpacing.xs),
        RevealOnScroll(
          delay: const Duration(milliseconds: 110),
          child: Text(
            ProfileData.role,
            style: AppTypography.titleMd.copyWith(
              color: context.ink(AppColors.emphasisBody),
              letterSpacing: 0.6,
            ),
          ),
        ),
        const Gap(AppSpacing.lg),
        RevealOnScroll(
          delay: const Duration(milliseconds: 160),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              ProfileData.bio,
              style: AppTypography.bodyLg.copyWith(
                color: context.ink(AppColors.emphasisMuted),
              ),
            ),
          ),
        ),
        const Gap(AppSpacing.lg),
        RevealOnScroll(
          delay: const Duration(milliseconds: 210),
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              PrimaryButton(
                label: 'View my work',
                icon: Icons.arrow_forward_rounded,
                onTap: onViewWork,
              ),
                           OutlineActionButton(
                label: 'Download resume',
                icon: Icons.download_outlined,
                onTap: () => Launcher.document(
                  AppLinks.resume,
                  unavailableMessage: 'Resume is not available yet.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
