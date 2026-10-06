import 'package:flutter/material.dart';

import '../../core/constants/app_links.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/launcher.dart';
import '../buttons/icon_text_button.dart';
import 'max_width_box.dart';

class AppFooter extends StatelessWidget {
  final String name;

  const AppFooter({super.key, this.name = 'Yash Khade'});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.ink(AppColors.emphasisHairline)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: MaxWidthBox(
        child: Flex(
          direction: context.isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '© $year $name',
              style: AppTypography.bodySm.copyWith(
                color: context.ink(AppColors.emphasisMuted),
              ),
            ),
            if (context.isMobile)
              const Gap(AppSpacing.md)
            else
              const Spacer(),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.xs,
              children: [
                IconTextButton(
                  label: 'Email',
                  icon: Icons.arrow_outward_rounded,
                  onTap: () => Launcher.email(),
                ),
                IconTextButton(
                  label: 'GitHub',
                  icon: Icons.arrow_outward_rounded,
                  onTap: () => Launcher.open(AppLinks.github),
                ),
                IconTextButton(
                  label: 'LinkedIn',
                  icon: Icons.arrow_outward_rounded,
                  onTap: () => Launcher.open(AppLinks.linkedin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
