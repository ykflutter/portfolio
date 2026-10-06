import '../models/experience.dart';
import '../models/skill_group.dart';

/// Real work history. Newest first.
class ExperienceData {
  ExperienceData._();

  static final List<Experience> all = [
    Experience(
      title: 'Flutter Developer',
      company: 'Aaryavarta Tech',
      startDate: DateTime(2025, 5),
      points: [
        'Built a task assistant app with Riverpod, Crashlytics and Rive '
            'animations.',
        'Shipped a dynamic dashboard with task filtering, scheduling and '
            'push notifications.',
      ],
      tech: ['Riverpod', 'Firebase', 'Rive', 'CustomScrollView'],
    ),
    Experience(
      title: 'Flutter Developer',
      company: 'Finaleap Finserv Pvt. Ltd.',
      startDate: DateTime(2024, 6),
      endDate: DateTime(2025, 5),
      points: [
        'Built a loan processing app with PAN and Aadhaar KYC, document '
            'upload and in-app comment threads.',
        'Reworked the onboarding forms and search flow, cutting drop-off on '
            'the application journey.',
      ],
      tech: ['GetX', 'REST APIs', 'KYC APIs', 'PDF'],
    ),
    Experience(
      title: 'Junior Flutter Developer',
      company: 'Prime Softech Solutions Pvt. Ltd.',
      startDate: DateTime(2022, 1),
      endDate: DateTime(2024, 6),
      points: [
        'Published apps to both the Play Store and the App Store, including '
            'release signing and store review.',
        'Integrated Google Maps, Firestore real-time listeners and Cloud '
            'Functions.',
      ],
      tech: ['Provider', 'Google Maps', 'Firestore', 'Cloud Functions'],
    ),
  ];

  /// Career start — everything date-derived counts from here, so the
  /// "years of experience" number can never go stale.
  static DateTime get careerStart => all.last.startDate;

  static const Education education = Education(
    degree: 'M.Sc Computer Science',
    institution: 'Asian College, Dhayri, Pune',
    year: '2022',
  );
}
