import 'package:flutter/material.dart';

import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/content/projects_data.dart';
import '../../../shared/buttons/icon_text_button.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import '../../../shared/text/section_header.dart';
import '../../projects/widgets/project_grid.dart';

class FeaturedWorkSection extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const FeaturedWorkSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Selected work',
            title: 'Things I shipped.',
            subtitle:
                'Production apps across fintech, productivity and real-time '
                'data.',
          ),
        ),
        const Gap(AppSpacing.xl),
        ProjectGrid(
          projects: ProjectsData.featured,
          onOpen: (p) => onNavigate('/work/${p.slug}'),
        ),
        const Gap(AppSpacing.lg),
        IconTextButton(
          label: 'All projects',
          onTap: () => onNavigate('/work'),
        ),
      ],
    );
  }
}
