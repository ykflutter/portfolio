import 'package:flutter/material.dart';

import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/content/experience_data.dart';
import '../../../shared/buttons/icon_text_button.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import '../../../shared/text/section_header.dart';
import '../../experience/widgets/timeline_column.dart';

/// Two most recent roles. The full history lives on /experience.
class ExperiencePreview extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const ExperiencePreview({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Where I have worked',
            title: 'Experience.',
          ),
        ),
        const Gap(AppSpacing.xl),
        TimelineColumn(entries: ExperienceData.all.take(2).toList()),
        const Gap(AppSpacing.md),
        IconTextButton(
          label: 'Full history',
          onTap: () => onNavigate('/experience'),
        ),
      ],
    );
  }
}
