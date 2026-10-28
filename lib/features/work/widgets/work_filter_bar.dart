import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/content/projects_data.dart';
import '../work_filter.dart';
import 'active_filter_note.dart';
import 'filter_pill.dart';

/// "All" plus one pill per project type that actually has projects.
/// Wraps on desktop; scrolls sideways on smaller screens.
class WorkFilterBar extends StatelessWidget {
  final WorkFilter filter;
  final ValueChanged<WorkFilter> onChanged;

  const WorkFilterBar({
    super.key,
    required this.filter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final pills = <Widget>[
      FilterPill(
        label: 'All',
        count: ProjectsData.all.length,
        selected: filter.isAll,
        onTap: () => onChanged(WorkFilter.all),
      ),
      for (final type in ProjectsData.types)
        FilterPill(
          label: type.label,
          count: ProjectsData.countOfType(type),
          selected: filter.isTypeOnly && filter.type == type,
          onTap: () => onChanged(WorkFilter(type: type)),
        ),
    ];

    final row = context.isDesktop
        ? Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: pills,
          )
        : ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              dragDevices: const {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Room for the selected pill's HUD corners.
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                children: [
                  for (var i = 0; i < pills.length; i++) ...[
                    if (i > 0) const Gap.h(AppSpacing.xs),
                    pills[i],
                  ],
                ],
              ),
            ),
          );

    final note = filter.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        row,
        if (note != null) ...[
          const Gap(AppSpacing.md),
          ActiveFilterNote(
            text: note,
            onClear: () => onChanged(WorkFilter.all),
          ),
        ],
      ],
    );
  }
}
