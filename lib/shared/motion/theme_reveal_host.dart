import 'package:flutter/material.dart';

import '../../app/theme_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import 'circular_reveal_clipper.dart';

/// Wraps the whole app so the theme switch can paint over it.
///
/// Sequence: cover the screen with the INCOMING background colour, swap the
/// theme while hidden, then uncover. That is what stops the jarring flash the
/// naive version produces.
class ThemeRevealHost extends StatefulWidget {
  final Widget child;

  const ThemeRevealHost({super.key, required this.child});

  /// Called by the toggle button with the button's screen-centre.
  static Future<void> trigger(Offset center) async {
    await _instance?._run(center);
  }

  static _ThemeRevealHostState? _instance;

  @override
  State<ThemeRevealHost> createState() => _ThemeRevealHostState();
}

class _ThemeRevealHostState extends State<ThemeRevealHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.slow,
  );

  Offset _center = Offset.zero;
  Color _coverColor = AppColors.darkBackground;

  @override
  void initState() {
    super.initState();
    ThemeRevealHost._instance = this;
  }

  Future<void> _run(Offset center) async {
    if (_controller.isAnimating) return;

    // No animation when the OS asks for reduced motion.
    if (MediaQuery.disableAnimationsOf(context)) {
      await themeController.toggle();
      return;
    }

    setState(() {
      _center = center;
      _coverColor = themeController.isDark
          ? AppColors.lightBackground
          : AppColors.darkBackground;
    });

    await _controller.forward(from: 0);

    await themeController.toggle();

    // One frame for the new theme to paint beneath the cover.
    await Future<void>.delayed(const Duration(milliseconds: 32));

    if (mounted) await _controller.reverse();
  }

  @override
  void dispose() {
    if (ThemeRevealHost._instance == this) ThemeRevealHost._instance = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              if (_controller.value == 0) return const SizedBox.shrink();

              return ClipPath(
                clipper: CircularRevealClipper(
                  fraction: _controller.value,
                  center: _center,
                ),
                child: Container(color: _coverColor),
              );
            },
          ),
        ),
      ],
    );
  }
}
