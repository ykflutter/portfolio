import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_durations.dart';
import '../../data/models/project.dart';
import 'browser_mockup.dart';
import 'phone_mockup.dart';
import 'shot_placeholder.dart';

/// The image area at the top of a project card: the first screenshot in a
/// phone or browser frame, peeking up from the bottom edge. Zooms slightly
/// when the card is hovered.
class ProjectMedia extends StatelessWidget {
  final Project project;
  final bool hovered;
  final double height;

  const ProjectMedia({
    super.key,
    required this.project,
    this.hovered = false,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    final first = project.hasScreenshots ? project.screenshots.first : null;
    final placeholder = ShotPlaceholder(
      initials: project.initials,
      label: project.category,
    );

    final mockup = project.isWeb
        ? BrowserMockup(imagePath: first, placeholder: placeholder)
        : PhoneMockup(
            imagePath: first,
            width: height * 0.62,
            placeholder: ShotPlaceholder(
              initials: project.initials,
              initialsSize: 22,
            ),
          );

    return Container(
      height: height,
      color: context.palette.stage,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: 28,
            left: project.isWeb ? 28 : 0,
            right: project.isWeb ? 28 : 0,
            child: Center(
              child: AnimatedScale(
                scale: hovered ? 1.05 : 1,
                alignment: Alignment.topCenter,
                duration: AppDurations.medium,
                curve: AppDurations.ease,
                child: mockup,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
