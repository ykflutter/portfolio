import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/content/skills_data.dart';
import '../../../shared/buttons/icon_text_button.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import '../../../shared/motion/staggered_reveal.dart';
import '../../../shared/text/section_header.dart';
import '../../skills/widgets/skill_group_block.dart';

class SkillsPreview extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const SkillsPreview({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final blocks = [
      for (final group in SkillsData.groups)
        SkillGroupBlock(group: group),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'What I work with',
            title: 'Stack.',
          ),
        ),
        const Gap(AppSpacing.xl),
        if (context.isDesktop)
          Wrap(
            spacing: AppSpacing.xxl,
            runSpacing: AppSpacing.lg,
            children: [
              for (final block in StaggeredReveal.wrapAll(blocks))
                SizedBox(width: 300, child: block),
            ],
          )
        else
          StaggeredReveal(spacing: AppSpacing.lg, children: blocks),
        const Gap(AppSpacing.lg),
        IconTextButton(
          label: 'Skills and highlights',
          onTap: () => onNavigate('/skills'),
        ),
      ],
    );
  }
}
