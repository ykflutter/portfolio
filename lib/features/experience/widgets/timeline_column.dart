import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../data/models/experience.dart';
import '../../../shared/motion/reveal_on_scroll.dart';
import 'experience_card.dart';
import 'timeline_node.dart';

class TimelineColumn extends StatelessWidget {
  final List<Experience> entries;

  const TimelineColumn({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(entries.length, (i) {
        final isLast = i == entries.length - 1;

        return RevealOnScroll(
          delay: Duration(milliseconds: 70 * i),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TimelineNode(
                  isCurrent: entries[i].isCurrent,
                  isLast: isLast,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: isLast ? 0 : AppSpacing.lg,
                    ),
                    child: ExperienceCard(experience: entries[i]),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
