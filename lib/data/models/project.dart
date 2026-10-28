import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import 'project_link.dart';
import 'project_metric.dart';
import 'project_type.dart';

class Project {
  /// URL segment — /work/crypto-exchange
  final String slug;

  final String title;
  final ProjectType type;
  final ProjectPlatform platform;

  /// One line for the card. Keep it under ~90 characters.
  final String tagline;

  /// Full paragraph for the case study.
  final String description;

  /// What YOU built, specifically. Hiring managers read this line hardest.
  final String role;

  /// Null hides the line — fill in when known.
  final String? company;

  /// Matches [Experience.slug], so /work?company=finaleap can find it.
  final String? companySlug;

  final String? period;

  final List<String> tech;
  final List<String> highlights;
  final List<ProjectMetric> metrics;
  final List<ProjectLink> links;

  /// Folder under assets/images/projects/
  final String folder;

  /// File names inside [folder], in display order. A missing file falls back
  /// to a placeholder, so listing a file before it exists is safe.
  final List<String> screenshotFiles;

  final IconData icon;

  /// Shown first on /work.
  final bool featured;

  const Project({
    required this.slug,
    required this.title,
    required this.type,
    this.platform = ProjectPlatform.mobile,
    required this.tagline,
    required this.description,
    required this.role,
    this.company,
    this.companySlug,
    this.period,
    required this.tech,
    this.highlights = const [],
    this.metrics = const [],
    this.links = const [],
    required this.folder,
    this.screenshotFiles = const [],
    required this.icon,
    this.featured = false,
  });

  String get category => type.label;

  bool get isWeb => platform == ProjectPlatform.web;

  List<String> get screenshots => [
        for (final file in screenshotFiles) AppAssets.projectShot(folder, file),
      ];

  bool get hasScreenshots => screenshotFiles.isNotEmpty;

  List<ProjectLink> get liveLinks =>
      links.where((l) => l.isLive).toList(growable: false);

  /// "Crypto Exchange" → "CE". Used on placeholders.
  String get initials {
    final words = title
        .split(RegExp(r'[\s&]+'))
        .where((w) => w.isNotEmpty && w.toLowerCase() != 'the')
        .toList();

    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  /// "Aaryavarta Technologies · 2025 – Present", or whichever half exists.
  String? get metaLine {
    final parts = [?company, ?period];
    return parts.isEmpty ? null : parts.join('  ·  ');
  }

  bool usesTech(String name) =>
      tech.any((t) => t.toLowerCase() == name.toLowerCase());
}
