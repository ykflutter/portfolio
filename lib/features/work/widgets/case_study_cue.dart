import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_durations.dart';
import '../../../core/theme/app_typography.dart';

/// "View case study →" at the foot of a project card. Not a separate
/// button — the whole card is the tap target; this just says where it goes.
class CaseStudyCue extends StatelessWidget {
  final bool active;

  const CaseStudyCue({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Row(
        children: [
          Text(
            'View case study',
            style: AppTypography.label.copyWith(color: context.cs.onSurface),
          ),
          const Gap.h(6),
          AnimatedSlide(
            offset: active ? const Offset(0.35, 0) : Offset.zero,
            duration: AppDurations.fast,
            curve: AppDurations.ease,
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 15,
              color: context.cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
