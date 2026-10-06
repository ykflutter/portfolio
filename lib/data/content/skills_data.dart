import '../models/skill_group.dart';

class SkillsData {
  SkillsData._();

  static const List<SkillGroup> groups = [
    SkillGroup(
      title: 'Languages',
      skills: ['Dart', 'Java', 'SQL'],
    ),
    SkillGroup(
      title: 'State management',
      skills: ['Riverpod', 'Bloc / Cubit', 'GetX', 'Provider'],
    ),
    SkillGroup(
      title: 'Mobile',
      skills: [
        'Flutter SDK',
        'Android',
        'iOS release',
        'Material Design',
        'Rive',
      ],
    ),
    SkillGroup(
      title: 'Backend & data',
      skills: [
        'Firebase',
        'Firestore',
        'Cloud Functions',
        'REST APIs',
        'MySQL',
      ],
    ),
    SkillGroup(
      title: 'Architecture & tools',
      skills: ['Clean Architecture', 'MVVM', 'Git', 'Postman', 'Crashlytics'],
    ),
  ];

  /// Counted, never hardcoded — so the number on the home page can't drift
  /// away from the list on this page.
  static int get totalSkills =>
      groups.fold(0, (sum, g) => sum + g.skills.length);

  static const List<Achievement> achievements = [
    Achievement(
      title: 'Shipped to both stores',
      description:
          'Took apps through release signing, store review and production '
          'rollout on Google Play and the App Store.',
    ),
    Achievement(
      title: 'Fintech onboarding',
      // TODO: if you can source the real drop-off figure, put it here —
      // a number makes this the strongest line on the page.
      description:
          'Rebuilt KYC forms and document upload flows for a loan product, '
          'reducing abandonment on the application journey.',
    ),
    Achievement(
      title: 'Flutter certification',
      description:
          'Professional Flutter Development certification, Chedo Tech & '
          'Programming Institute, 2022.',
    ),
    Achievement(
      title: 'Real-time interfaces',
      description:
          'Built dashboards backed by live data streams with secure session '
          'handling.',
    ),
  ];
}
