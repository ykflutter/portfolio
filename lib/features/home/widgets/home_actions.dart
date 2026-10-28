import 'package:flutter/material.dart';

import '../../../app/router/route_paths.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launcher.dart';
import '../../../shared/buttons/outline_button.dart';
import '../../../shared/buttons/primary_button.dart';

/// The only two actions on the home page.
///
///  · See my work      → /work
///  · Download Resume  → opens AppLinks.resume in a new tab
class HomeActions extends StatelessWidget {
  final ValueChanged<String> onNavigate;
  final bool centered;

  const HomeActions({
    super.key,
    required this.onNavigate,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: centered ? WrapAlignment.center : WrapAlignment.start,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        PrimaryButton(
          label: 'See my work',
          icon: Icons.arrow_forward_rounded,
          onTap: () => onNavigate(RoutePaths.work),
        ),
        OutlineActionButton(
          label: 'Download Resume',
          icon: Icons.download_rounded,
          onTap: () => Launcher.document(
            AppLinks.resume,
            unavailableMessage: 'Resume is not available yet.',
          ),
        ),
      ],
    );
  }
}
