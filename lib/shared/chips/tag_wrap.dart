import 'package:flutter/widgets.dart';

import '../../core/theme/app_spacing.dart';
import 'tag_chip.dart';

/// A list of strings rendered as wrapping chips.
class TagWrap extends StatelessWidget {
  final List<String> tags;
  final bool filled;
  final int? maxTags;

  const TagWrap(this.tags, {super.key, this.filled = false, this.maxTags});

  @override
  Widget build(BuildContext context) {
    final shown = maxTags == null ? tags : tags.take(maxTags!).toList();
    final hidden = tags.length - shown.length;

    return Wrap(
      spacing: AppSpacing.xs - 2,
      runSpacing: AppSpacing.xs - 2,
      children: [
        ...shown.map((t) => TagChip(t, filled: filled)),
        if (hidden > 0) TagChip('+$hidden', filled: filled),
      ],
    );
  }
}
