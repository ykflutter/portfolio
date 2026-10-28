import '../../core/constants/app_assets.dart';
import '../models/stat.dart';
import 'experience_data.dart';
import 'projects_data.dart';

/// Who you are, and the numbers. Counts are COMPUTED from the other content
/// files, so a stat can never contradict the page it links to.
class ProfileData {
  ProfileData._();

  static const String name = 'Yash Khade';
  static const String initials = 'YK';
  static const String role = 'Flutter Developer';
  static const String location = 'Pune, India';

  /// From the resume. Not derivable from this site's data.
  static const String appsPublished = '12+';

  static const String availability = 'Open to opportunities';

  static const String availabilityNote =
      'Available for full-time and remote Flutter roles.';

  static const String portraitPath = AppAssets.portrait;

  /// The line under the name on the home page.
  static String get homeRole => '$role  ·  $yearsLabel years';

  static String get bio =>
      'Flutter Developer with $yearsLabel years of experience building and '
      'shipping cross-platform mobile apps in crypto, fintech and education. '
      'Strong in Flutter, Dart, BLoC, Riverpod, Clean Architecture, REST APIs, '
      'WebSockets and Firebase. I have delivered real-time trading dashboards '
      'and KYC workflows, and published $appsPublished apps on the Play Store '
      'and App Store.';

  // ── Numbers, all derived ─────────────────────────────────────────────────

  /// Experience rounded DOWN to the nearest half year, as "4.5+" or "5+".
  /// Rolls over on its own.
  static String get yearsLabel {
    final start = ExperienceData.careerStart;
    final now = DateTime.now();
    final months = (now.year - start.year) * 12 + now.month - start.month;
    final halves = months ~/ 6;

    return halves.isEven ? '${halves ~/ 2}+' : '${halves ~/ 2}.5+';
  }

  static int get companyCount => ExperienceData.all.length;

  static int get projectCount => ProjectsData.all.length;

  /// The tiles on the About page.
  static List<Stat> get stats => [
        Stat(value: yearsLabel, label: 'Years experience'),
        Stat(value: '$companyCount', label: 'Companies'),
        const Stat(value: appsPublished, label: 'Apps published'),
        Stat(value: '$projectCount', label: 'Projects', route: '/work'),
      ];
}
