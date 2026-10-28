import 'package:flutter/widgets.dart';

import '../../core/theme/app_durations.dart';
import '../../core/theme/app_spacing.dart';
import '../motion/reveal_on_scroll.dart';

/// Lays items out in rows of equal-height cells, with the column count
/// picked from the AVAILABLE width (not the screen), so it adapts inside
/// side panels and on rotation alike.
///
/// [itemBuilder] is told whether the cell has a fixed height (`fill`), so a
/// card can push its footer to the bottom only when that is safe.
class ResponsiveGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index, bool fill)
      itemBuilder;
  final int Function(double width) columnsFor;
  final double spacing;
  final bool reveal;

  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.columnsFor = standardColumns,
    this.spacing = AppSpacing.md,
    this.reveal = true,
  });

  /// 1 column under 600px, 2 under 1000px, 3 above.
  static int standardColumns(double width) =>
      width < 600 ? 1 : (width < 1000 ? 2 : 3);

  /// 1 column under 640px, 2 above — for wider cards.
  static int twoColumns(double width) => width < 640 ? 1 : 2;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = columnsFor(constraints.maxWidth).clamp(1, itemCount).toInt();

        Widget cell(int i, bool fill) {
          final child = itemBuilder(context, i, fill);
          if (!reveal) return child;

          // Stagger across a row, not down the whole list — otherwise the
          // ninth card waits half a second for no reason.
          return RevealOnScroll(
            delay: AppDurations.stagger * (i % cols),
            child: child,
          );
        }

        if (cols == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < itemCount; i++) ...[
                if (i > 0) SizedBox(height: spacing),
                cell(i, false),
              ],
            ],
          );
        }

        final rows = <Widget>[];

        for (var start = 0; start < itemCount; start += cols) {
          if (start > 0) rows.add(SizedBox(height: spacing));

          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var c = 0; c < cols; c++) ...[
                    if (c > 0) SizedBox(width: spacing),
                    Expanded(
                      child: start + c < itemCount
                          ? cell(start + c, true)
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}
