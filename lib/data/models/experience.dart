class Experience {
  final String title;
  final String company;

  /// Short key shared with [Project.companySlug] — /work?company=finaleap
  final String slug;

  final String location;

  /// Used for sorting and for computing total years — never shown directly.
  final DateTime startDate;

  /// null means "present".
  final DateTime? endDate;

  final List<String> points;
  final List<String> tech;

  const Experience({
    required this.title,
    required this.company,
    required this.slug,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.points,
    required this.tech,
  });

  bool get isCurrent => endDate == null;

  /// "Apr 2025 – Present"
  String get period {
    final start = _format(startDate);
    return endDate == null
        ? '$start – Present'
        : '$start – ${_format(endDate!)}';
  }

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String _format(DateTime d) => '${_months[d.month - 1]} ${d.year}';
}
