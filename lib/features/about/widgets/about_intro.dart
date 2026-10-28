import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/chips/status_pill.dart';
import '../../../shared/media/avatar_mark.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import '../../../shared/text/section_header.dart';

/// Greeting, bio and portrait. Side by side on wide screens; portrait first
/// on phones.
class AboutIntro extends StatelessWidget {
  const AboutIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: 'About me',
          title: "Hi, I'm Yash.",
          large: true,
        ),
        const Gap(AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            ProfileData.bio,
            style: AppTypography.bodyLg.copyWith(
              color: context.ink(AppColors.emphasisBody),
            ),
          ),
        ),
        const Gap(AppSpacing.lg),
        const StatusPill(label: ProfileData.availability),
      ],
    );

    // Wide enough for two columns — includes a phone held sideways.
    final sideBySide = !context.isMobile;
    final portraitSize = context.isDesktop
        ? 280.0
        : (context.isShortHeight ? 180.0 : 220.0);

    final portrait = AvatarMark(
      initials: ProfileData.initials,
      imagePath: ProfileData.portraitPath,
      size: context.isMobile ? 160 : portraitSize,
    );

    if (!sideBySide) {
      return RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [portrait, const Gap(AppSpacing.xl), text],
        ),
      );
    }

    return RevealOnScroll(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: text),
          const Gap.h(AppSpacing.xl),
          Expanded(flex: 2, child: Center(child: portrait)),
        ],
      ),
    );
  }
}
