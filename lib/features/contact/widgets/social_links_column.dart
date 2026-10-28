import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launcher.dart';
import '../../../data/content/socials_data.dart';
import '../../../shared/cards/info_tile.dart';
import '../../../shared/media/social_icon.dart';
import '../../../shared/motion/staggered_reveal.dart';

/// Email → mail app, LinkedIn / GitHub → new tab, Location → display only.
class SocialLinksColumn extends StatelessWidget {
  const SocialLinksColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredReveal(
      spacing: AppSpacing.xs,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final social in SocialsData.all)
          InfoTile(
            icon: SocialIcon(
              social.kind,
              size: 15,
              color: context.ink(AppColors.emphasisBody),
            ),
            label: social.label,
            value: social.value,
            onTap: social.isLive ? () => Launcher.open(social.url) : null,
          ),
      ],
    );
  }
}
