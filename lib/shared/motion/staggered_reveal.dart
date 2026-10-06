import 'package:flutter/widgets.dart';

import '../../core/theme/app_durations.dart';
import 'reveal_on_scroll.dart';

/// Reveals children one after another as the group enters the viewport.
///
/// Use for grids and lists. For a single block, use [RevealOnScroll] directly.
class StaggeredReveal extends StatelessWidget {
  final List<Widget> children;
  final Duration interval;
  final Axis direction;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  const StaggeredReveal({
    super.key,
    required this.children,
    this.interval = AppDurations.stagger,
    this.direction = Axis.vertical,
    this.spacing = 0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  /// Wraps each child without imposing a layout — for Wrap and GridView,
  /// where the parent already handles arrangement.
  static List<Widget> wrapAll(
    List<Widget> children, {
    Duration interval = AppDurations.stagger,
  }) {
    return List.generate(
      children.length,
      (i) => RevealOnScroll(
        delay: interval * i,
        child: children[i],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final revealed = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      if (i > 0 && spacing > 0) {
        revealed.add(
          SizedBox(
            height: direction == Axis.vertical ? spacing : null,
            width: direction == Axis.horizontal ? spacing : null,
          ),
        );
      }

      revealed.add(
        RevealOnScroll(delay: interval * i, child: children[i]),
      );
    }

    return direction == Axis.vertical
        ? Column(crossAxisAlignment: crossAxisAlignment, children: revealed)
        : Row(crossAxisAlignment: crossAxisAlignment, children: revealed);
  }
}
