import '../models/article.dart';

/// Writing.
///
/// Every entry below has an empty `url`, which means NOT PUBLISHED.
/// [hasPublished] is false, and the Writing section should hide itself —
/// an empty blog reads worse than no blog at all.
///
/// Publish them (Medium, Hashnode, dev.to, anywhere), paste the URLs in,
/// and the section turns itself on.
class ArticlesData {
  ArticlesData._();

  static final List<Article> all = [
    Article(
      title: 'Architecting scalable Flutter apps with Riverpod',
      snippet:
          'State management in production apps, and why the folder structure '
          'matters more than the library you picked.',
      date: DateTime(2024, 10, 12),
      readMinutes: 8,
      url: '',
    ),
    Article(
      title: 'Real-time dashboards without dropping frames',
      snippet:
          'Handling high-frequency data streams in Flutter while keeping the '
          'UI at 60fps.',
      date: DateTime(2024, 8, 25),
      readMinutes: 6,
      url: '',
    ),
    Article(
      title: 'Clean architecture in Flutter: a practical guide',
      snippet:
          'SOLID principles and a folder structure that survives two years '
          'of feature work.',
      date: DateTime(2024, 6, 5),
      readMinutes: 12,
      url: '',
    ),
  ];

  static List<Article> get published =>
      all.where((a) => a.isPublished).toList(growable: false);

  static bool get hasPublished => published.isNotEmpty;

  static int get totalReadMinutes =>
      published.fold(0, (sum, a) => sum + a.readMinutes);
}
