import 'package:flutter/material.dart';

import '../../../app/router/route_paths.dart';
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
import '../../../shared/cards/bordered_card.dart';
import '../../../shared/text/section_label.dart';

/// Closes the About page with the two things a visitor wants next.
///
///  · Get in touch     → /contact
///  · Download Resume  → AppLinks.resume
class AboutCta extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const AboutCta({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      padding: EdgeInsets.all(context.isMobile ? AppSpacing.lg : AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('Next step'),
          const Gap(AppSpacing.sm),
          Text(
            'Have a role or a project in mind?',
            style: (context.isMobile
                    ? AppTypography.displaySm
                    : AppTypography.displayMd)
                .copyWith(color: context.cs.onSurface),
          ),
          const Gap(AppSpacing.sm),
          Text(
            ProfileData.availabilityNote,
            style: AppTypography.bodyLg.copyWith(
              color: context.ink(AppColors.emphasisMuted),
            ),
          ),
          const Gap(AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              PrimaryButton(
                label: 'Get in touch',
                icon: Icons.arrow_forward_rounded,
                onTap: () => onNavigate(RoutePaths.contact),
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
          ),
        ],
      ),
    );
  }
}
