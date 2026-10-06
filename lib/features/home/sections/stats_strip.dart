import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/cards/stat_card.dart';
import '../../../shared/motion/staggered_reveal.dart';

/// The four number tiles. Values are derived in ProfileData, so they can
/// never contradict the pages they link to.
class StatsStrip extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const StatsStrip({super.key, required this.onNavigate});

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
