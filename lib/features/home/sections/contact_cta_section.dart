import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/launcher.dart';
import '../../../data/content/profile_data.dart';
import '../../../shared/buttons/outline_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import '../../../shared/text/section_label.dart';

/// The closing block. Every page scroll ends with a way to get in touch —
/// a portfolio that makes a visitor hunt for your email has failed.
class ContactCtaSection extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const ContactCtaSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('Get in touch'),
          const Gap(AppSpacing.sm),
          Text(
            'Building something\nworth shipping?',
            style: (context.isMobile
                    ? AppTypography.displayMd
                    : AppTypography.displayLg)
                .copyWith(color: context.cs.onSurface),
          ),
          const Gap(AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              '${ProfileData.availabilityNote} I usually reply within a day.',
              style: AppTypography.bodyLg.copyWith(
                color: context.ink(AppColors.emphasisMuted),
              ),
            ),
          ),
          const Gap(AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              PrimaryButton(
                label: 'Start a conversation',
                icon: Icons.arrow_forward_rounded,
                onTap: () => onNavigate('/contact'),
              ),
              OutlineActionButton(
                label: 'Email directly',
                icon: Icons.email_outlined,
                onTap: () => Launcher.email(subject: 'Hello Yash'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
