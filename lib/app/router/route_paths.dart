/// Real URLs, so every section is linkable and browser back works.
class RoutePaths {
  RoutePaths._();

  static const String home = '/';
  static const String work = '/work';
  static const String experience = '/experience';
  static const String skills = '/skills';
  static const String writing = '/writing';
  static const String contact = '/contact';

  /// Development-only component gallery. Remove before launch.
  static const String components = '/components';

  /// Project detail — /work/task-assistant
  static const String workDetail = '/work/:slug';

  static String workDetailFor(String slug) => '/work/$slug';
}
