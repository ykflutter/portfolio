import '../models/stat.dart';
import 'articles_data.dart';
import 'experience_data.dart';
import 'projects_data.dart';
import 'skills_data.dart';

/// Who you are, and the numbers — all of which are COMPUTED from the other
/// content files.
///
/// That is deliberate. The old site said "10+ Projects" above a page showing
/// four, and "15+ Tech Stack" above a list of twenty-one. A careful reviewer
/// notices, and it costs more credibility than a bigger number buys.
class ProfileData {
  ProfileData._();

  static const String name = 'Yash Khade';
  static const String initials = 'YK';

  /// TODO (your call): "Mobile Systems Architect" reads as overclaiming at
  /// four years and three companies — a senior reviewer will discount
  /// everything after it. This is the defensible version.
  static const String role = 'Flutter Developer  ·  Mobile Engineer';

  static const String tagline =
      'I build cross-platform mobile apps that ship.';

  static const String bio =
      'Four years across fintech, productivity and real-time dashboards — '
      'from architecture through to the App Store. Currently at Aaryavarta '
      'Tech, based in Pune.';

  static const String availability = 'Open to opportunities';

  static const String availabilityNote =
      'Available for full-time and remote roles.';

  /// TODO: set to AppAssets.portrait once you add a photo.
  /// A real face converts better than initials — but initials beat a bad
  /// photo, so leaving this null is a valid choice.
  static const String? portraitPath = null;

  // ── Numbers, all derived ─────────────────────────────────────────────────

  /// Whole years since the first role. Rolls over on its own.
  static int get yearsExperience {
    final start = ExperienceData.careerStart;
    final now = DateTime.now();

    var years = now.year - start.year;
    if (now.month < start.month) years--;

    return years;
  }

  static int get companyCount => ExperienceData.all.length;

  static int get projectCount => ProjectsData.all.length;

  static int get skillCount => SkillsData.totalSkills;

  /// The four tiles on the home page.
  static List<Stat> get stats => [
        Stat(value: '$yearsExperience+', label: 'Years', route: '/experience'),
        Stat(value: '$projectCount', label: 'Projects', route: '/work'),
        Stat(value: '$skillCount+', label: 'Technologies', route: '/skills'),
        if (ArticlesData.hasPublished)
          Stat(
            value: '${ArticlesData.published.length}',
            label: 'Articles',
            route: '/writing',
          )
        else
          Stat(value: '$companyCount', label: 'Companies', route: '/experience'),
      ];
}
