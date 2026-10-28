import '../../app/router/route_paths.dart';
import '../../data/content/experience_data.dart';
import '../../data/models/project.dart';
import '../../data/models/project_type.dart';

/// The /work filter, read from and written back to the URL, so a filtered
/// view can be bookmarked, shared, and survives a refresh.
///
///   /work?type=fintech        a filter chip
///   /work?tech=Flutter        a skill chip on /skills or a case study
///   /work?company=finaleap    "See related work" on /about
class WorkFilter {
  final ProjectType? type;
  final String? tech;
  final String? company;

  const WorkFilter({this.type, this.tech, this.company});

  static const WorkFilter all = WorkFilter();

  factory WorkFilter.fromQuery(Map<String, String> query) {
    String? clean(String? v) =>
        (v == null || v.trim().isEmpty) ? null : v.trim();

    return WorkFilter(
      type: ProjectType.fromSlug(query['type']),
      tech: clean(query['tech']),
      company: clean(query['company']),
    );
  }

  bool get isAll => type == null && tech == null && company == null;

  /// True when only a type chip is active (or nothing).
  bool get isTypeOnly => tech == null && company == null;

  bool matches(Project p) =>
      (type == null || p.type == type) &&
      (tech == null || p.usesTech(tech!)) &&
      (company == null || p.companySlug == company);

  String toLocation() => RoutePaths.workFiltered(
        type: type?.slug,
        tech: tech,
        company: company,
      );

  /// Plain-English note for the tech / company filters, which have no chip.
  String? get description {
    if (tech != null) return 'Showing projects built with $tech';
    if (company != null) {
      final name = ExperienceData.bySlug(company!)?.company ?? company!;
      return 'Showing projects from $name';
    }
    return null;
  }
}
