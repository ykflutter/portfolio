import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/project.dart';

/// Company, period and metrics in a single band under the project title.
class ProjectMetaRow extends StatelessWidget {
  final Project project;

  const ProjectMetaRow({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    // Placeholder metrics ('—') are skipped rather than shown as dashes.
    final metrics =
        project.metrics.where((m) => m.value.trim() != '—').toList();

    return Wrap(
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.md,
      children: [
        _item(context, 'Company', project.company),
        _item(context, 'Period', project.period),
        _item(context, 'Category', project.category),
        for (final metric in metrics)
          _item(context, metric.label, metric.value),
      ],
    );
  }

  Widget _item(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.eyebrow.copyWith(
            color: context.ink(AppColors.emphasisFaint),
          ),
        ),
        const Gap(AppSpacing.xxs),
        Text(
          value,
          style: AppTypography.titleSm.copyWith(color: context.cs.onSurface),
        ),
      ],
    );
  }
}
