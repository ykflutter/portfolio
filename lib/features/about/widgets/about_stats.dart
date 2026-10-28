import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/cards/stat_card.dart';
import '../../../shared/motion/staggered_reveal.dart';

/// The number tiles. Only "Projects" is a link (to /work) — the others have
/// nowhere more useful to go.
class AboutStats extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const AboutStats({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: StaggeredReveal.wrapAll([
        for (final stat in ProfileData.stats)
          StatCard(
            value: stat.value,
            label: stat.label,
            onTap: stat.route == null ? null : () => onNavigate(stat.route!),
          ),
      ]),
    );
  }
}
