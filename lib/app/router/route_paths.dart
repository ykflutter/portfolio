/// Real URLs, so every page is linkable and browser back works.
class RoutePaths {
  RoutePaths._();

  static const String home = '/';
  static const String work = '/work';
  static const String about = '/about';
  static const String skills = '/skills';
  static const String contact = '/contact';

  /// Case study — /work/crypto-exchange
  static String workDetailFor(String slug) => '$work/$slug';

  /// Filtered work — /work?type=fintech, /work?tech=Flutter,
  /// /work?company=finaleap
  static String workFiltered({String? type, String? tech, String? company}) {
    final query = <String, String>{
      'type': ?type,
      'tech': ?tech,
      'company': ?company,
    };

    return Uri(
      path: work,
      queryParameters: query.isEmpty ? null : query,
    ).toString();
  }
}
