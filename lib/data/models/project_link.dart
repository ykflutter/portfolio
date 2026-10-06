import 'package:flutter/material.dart';

enum ProjectLinkKind { playStore, appStore, website, github, caseStudy }

/// An external link on a project. Only ones with a real URL are rendered —
/// a dead "View on Play Store" button is worse than no button.
class ProjectLink {
  final ProjectLinkKind kind;
  final String url;

  const ProjectLink({required this.kind, required this.url});

  bool get isLive => url.trim().isNotEmpty;

  String get label {
    switch (kind) {
      case ProjectLinkKind.playStore:
        return 'Play Store';
      case ProjectLinkKind.appStore:
        return 'App Store';
      case ProjectLinkKind.website:
        return 'Website';
      case ProjectLinkKind.github:
        return 'Source';
      case ProjectLinkKind.caseStudy:
        return 'Case study';
    }
  }

  IconData get icon {
    switch (kind) {
      case ProjectLinkKind.playStore:
      case ProjectLinkKind.appStore:
        return Icons.open_in_new_rounded;
      case ProjectLinkKind.website:
        return Icons.language_rounded;
      case ProjectLinkKind.github:
        return Icons.code_rounded;
      case ProjectLinkKind.caseStudy:
        return Icons.article_outlined;
    }
  }
}
