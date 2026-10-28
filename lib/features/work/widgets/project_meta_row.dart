import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/project.dart';

/// Company, period, platform, category and metrics in one band. Anything
/// not filled in yet is left out rather than shown as a dash.
class ProjectMetaRow extends StatelessWidget {
  final Project project;

  const ProjectMetaRow({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final metrics =
        project.metrics.where((m) => m.value.trim().isNotEmpty).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: context.ink(AppColors.emphasisHairline)),
        ),
      ),
      child: Wrap(
        spacing: AppSpacing.xl,
        runSpacing: AppSpacing.md,
        children: [
          if (project.company != null)
            _item(context, 'Company', project.company!),
          if (project.period != null)
            _item(context, 'Period', project.period!),
          _item(context, 'Platform', project.platform.label),
          _item(context, 'Category', project.category),
          for (final metric in metrics)
            _item(context, metric.label, metric.value),
        ],
      ),
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
