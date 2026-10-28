import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/social_link.dart';

/// The right glyph for each social link. Brand marks come from Font Awesome,
/// everything else from Material.
class SocialIcon extends StatelessWidget {
  final SocialKind kind;
  final double size;
  final Color? color;

  const SocialIcon(this.kind, {super.key, this.size = 16, this.color});

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case SocialKind.github:
        return FaIcon(FontAwesomeIcons.github, size: size, color: color);
      case SocialKind.linkedin:
        return FaIcon(FontAwesomeIcons.linkedinIn, size: size, color: color);
      case SocialKind.email:
        return Icon(Icons.mail_outline_rounded, size: size, color: color);
      case SocialKind.location:
        return Icon(Icons.location_on_outlined, size: size, color: color);
    }
  }
}
