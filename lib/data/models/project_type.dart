/// What kind of product a project is. Drives the filter chips on /work and
/// the `?type=` query parameter.
enum ProjectType {
  fintech('fintech', 'Fintech & Crypto'),
  marketplace('marketplace', 'Marketplace'),
  communication('communication', 'Communication'),
  education('education', 'Education'),
  health('health', 'Health & Fitness'),
  publicSector('public-sector', 'Public Sector'),
  web('web', 'Web');

  const ProjectType(this.slug, this.label);

  /// URL form — /work?type=fintech
  final String slug;

  /// Display form — "Fintech & Crypto"
  final String label;

  static ProjectType? fromSlug(String? slug) {
    if (slug == null) return null;
    for (final type in values) {
      if (type.slug == slug) return type;
    }
    return null;
  }
}

/// Decides which mockup a project's screenshots sit in.
enum ProjectPlatform {
  mobile('Android & iOS'),
  web('Web');

  const ProjectPlatform(this.label);

  final String label;
}
