import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/theme/app_colors.dart';

/// The dot and the line beside a timeline entry. Filled dot marks the
/// current role.
class TimelineNode extends StatelessWidget {
  final bool isCurrent;
  final bool isLast;

  const TimelineNode({
    super.key,
    required this.isCurrent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCurrent ? context.cs.onSurface : Colors.transparent,
                border: Border.all(color: context.cs.onSurface, width: 1.8),
              ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 1.4,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: context.ink(AppColors.emphasisHairline),
              ),
            ),
        ],
      ),
    );
  }
}
