enum SocialKind { email, linkedin, github, location }

class SocialLink {
  final SocialKind kind;
  final String label;
  final String value;

  /// Empty means display-only (location, for instance).
  final String url;

  const SocialLink({
    required this.kind,
    required this.label,
    required this.value,
    required this.url,
  });

  bool get isLive => url.trim().isNotEmpty;
}
