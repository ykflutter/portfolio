import 'package:flutter/material.dart';

import '../../../core/extensions/animate_ext.dart';
import '../../../core/theme/app_radius.dart';
import '../../../shared/media/animated_logo.dart';
import '../../../shared/motion/hover_builder.dart';
import '../../../shared/motion/hud_corners.dart';

/// The big logo on the home page. Plays its 4 frames on load; hover or tap
/// replays them, with HUD corners locking on.
class HomeLogo extends StatelessWidget {
  final double size;

  const HomeLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) => HudCorners(
        visible: hovered,
        length: 16,
        gap: 10,
        child: AnimatedLogo(
          size: size,
          playOnMount: true,
          borderRadius: AppRadius.brLg,
        ),
      ),
    ).entrance(context, dy: 0.08);
  }
}
