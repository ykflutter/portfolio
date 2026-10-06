import 'package:flutter/material.dart';

import 'project_link.dart';
import 'project_metric.dart';

class Project {
  /// URL segment — /work/task-assistant
  final String slug;

  final String title;
  final String category;

  /// One line for the card. Keep it under ~90 characters.
  final String tagline;

  /// Full paragraph for the detail page.
  final String description;

  /// What YOU built, specifically. Hiring managers read this line hardest.
  final String role;

  final String company;
  final String period;

  final List<String> tech;
  final List<String> highlights;
  final List<ProjectMetric> metrics;
  final List<ProjectLink> links;

  /// Asset paths. Empty renders an empty device frame — the layout is
  /// already correct, it just has nothing in it yet.
  final List<String> screenshots;

  final IconData icon;

  /// Shown on the home page. Keep this to three or four.
  final bool featured;

  const Project({
    required this.slug,
    required this.title,
    required this.category,
    required this.tagline,
    required this.description,
    required this.role,
    required this.company,
    required this.period,
    required this.tech,
    this.highlights = const [],
    this.metrics = const [],
    this.links = const [],
    this.screenshots = const [],
    required this.icon,
    this.featured = false,
  });

  List<ProjectLink> get liveLinks =>
      links.where((l) => l.isLive).toList(growable: false);

  bool get hasScreenshots => screenshots.isNotEmpty;
}
