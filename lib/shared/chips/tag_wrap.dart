import 'package:flutter/widgets.dart';

import '../../core/theme/app_spacing.dart';
import 'tag_chip.dart';

/// A list of strings rendered as wrapping chips.
///
/// Pass [onTagTap] to make chips links; [isLinkable] decides which ones
/// (so a chip only links when there is somewhere for it to go).
class TagWrap extends StatelessWidget {
  final List<String> tags;
  final bool filled;
  final int? maxTags;
  final ValueChanged<String>? onTagTap;
  final bool Function(String tag)? isLinkable;
  final String Function(String tag)? tooltipFor;

  const TagWrap(
    this.tags, {
    super.key,
    this.filled = false,
    this.maxTags,
    this.onTagTap,
    this.isLinkable,
    this.tooltipFor,
  });

  @override
  Widget build(BuildContext context) {
    final shown = maxTags == null ? tags : tags.take(maxTags!).toList();
    final hidden = tags.length - shown.length;

    return Wrap(
      spacing: AppSpacing.xs - 2,
      runSpacing: AppSpacing.xs - 2,
      children: [
        for (final tag in shown) _chip(tag),
        if (hidden > 0) TagChip('+$hidden', filled: filled),
      ],
    );
  }

  Widget _chip(String tag) {
    final linkable =
        onTagTap != null && (isLinkable == null || isLinkable!(tag));

    return TagChip(
      tag,
      filled: filled,
      onTap: linkable ? () => onTagTap!(tag) : null,
      tooltip: linkable ? tooltipFor?.call(tag) : null,
    );
  }
}
