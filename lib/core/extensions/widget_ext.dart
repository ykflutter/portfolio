import 'package:flutter/widgets.dart';

import '../theme/app_spacing.dart';

/// Small chaining helpers. They exist to cut nesting depth, not to replace
/// real layout widgets — if a wrap needs parameters, write it out.
extension WidgetPadding on Widget {
  Widget padAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget padX(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  Widget padY(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  Widget padOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  Widget get centered => Center(child: this);

  Widget get expanded => Expanded(child: this);

  Widget flex(int value) => Expanded(flex: value, child: this);

  /// Caps width and centres — the standard content column.
  Widget maxWidth([double value = AppSpacing.maxContentWidth]) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: value),
          child: this,
        ),
      );
}

/// Vertical and horizontal gaps from the spacing scale, as values.
class Gap extends StatelessWidget {
  final double size;
  final Axis axis;

  const Gap(this.size, {super.key, this.axis = Axis.vertical});

  const Gap.h(this.size, {super.key}) : axis = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: axis == Axis.vertical ? size : null,
      width: axis == Axis.horizontal ? size : null,
    );
  }
}
