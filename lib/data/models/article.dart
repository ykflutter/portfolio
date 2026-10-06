class Article {
  final String title;
  final String snippet;
  final DateTime date;
  final int readMinutes;

  /// Empty means it is not published anywhere yet.
  final String url;

  const Article({
    required this.title,
    required this.snippet,
    required this.date,
    required this.readMinutes,
    this.url = '',
  });

  bool get isPublished => url.trim().isNotEmpty;

  /// "OCT 12, 2024"
  String get formattedDate =>
      '${_months[date.month - 1]} ${date.day}, ${date.year}'.toUpperCase();

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
}
