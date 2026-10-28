import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Huge "404" that glitches for a split second every few seconds: two faint
/// ghost copies jump sideways, then snap back.
class GlitchCode extends StatefulWidget {
  final String text;

  const GlitchCode(this.text, {super.key});

  @override
  State<GlitchCode> createState() => _GlitchCodeState();
}

class _GlitchCodeState extends State<GlitchCode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  )..repeat();

  final math.Random _random = math.Random();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.displayXl.copyWith(
      fontSize: context.isMobile ? 120 : 180,
      height: 1,
      color: context.cs.onSurface,
    );

    final main = Text(widget.text, style: style);

    if (context.reduceMotion) return main;

    return Semantics(
      label: 'Error ${widget.text}',
      child: ExcludeSemantics(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // Glitch only during the first 6% of each cycle.
            final glitching = _controller.value < 0.06;
            final dx = glitching ? (_random.nextDouble() * 2 - 1) * 8 : 0.0;
            final dy = glitching ? (_random.nextDouble() * 2 - 1) * 3 : 0.0;

            return Stack(
              children: [
                if (glitching) ...[
                  Transform.translate(
                    offset: Offset(dx, dy),
                    child: Text(
                      widget.text,
                      style: style.copyWith(
                        color: context.ink(AppColors.emphasisFaint),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-dx, -dy),
                    child: Text(
                      widget.text,
                      style: style.copyWith(
                        color: context.ink(AppColors.emphasisHairline),
                      ),
                    ),
                  ),
                ],
                main,
              ],
            );
          },
        ),
      ),
    );
  }
}
