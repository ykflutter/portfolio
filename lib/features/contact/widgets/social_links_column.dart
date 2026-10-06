import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launcher.dart';
import '../../../data/content/socials_data.dart';
import '../../../shared/cards/info_tile.dart';
import '../../../shared/motion/staggered_reveal.dart';

class SocialLinksColumn extends StatelessWidget {
  const SocialLinksColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredReveal(
      spacing: AppSpacing.xs,
      children: [
        for (final social in SocialsData.all)
          InfoTile(
            icon: social.icon,
            label: social.label,
            value: social.value,
            onTap: social.isLive ? () => Launcher.open(social.url) : null,
          ),
      ],
    );
  }
}
