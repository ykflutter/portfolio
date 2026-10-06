import 'package:flutter/widgets.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launcher.dart';
import '../../../data/models/project.dart';
import '../../../shared/buttons/outline_button.dart';

/// Renders only links that actually exist — a dead "Play Store" button does
/// more damage than a missing one.
class ProjectLinksRow extends StatelessWidget {
  final Project project;

  const ProjectLinksRow({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final links = project.liveLinks;

    if (links.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final link in links)
          OutlineActionButton(
            label: link.label,
            icon: link.icon,
            onTap: () => Launcher.open(link.url),
          ),
      ],
    );
  }
}
