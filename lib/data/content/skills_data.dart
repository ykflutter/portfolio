import '../models/skill_group.dart';

/// Skills, grouped exactly as on the resume.
class SkillsData {
  SkillsData._();

  static const List<SkillGroup> groups = [
    SkillGroup(
      title: 'Framework & languages',
      skills: ['Flutter', 'Flutter Web', 'Dart', 'Core Java'],
    ),
    SkillGroup(
      title: 'State management & architecture',
      skills: [
        'BLoC',
        'Riverpod',
        'Provider',
        'GetX',
        'Clean Architecture',
        'MVVM',
      ],
    ),
    SkillGroup(
      title: 'APIs & backend',
      skills: [
        'REST APIs',
        'Dio',
        'WebSockets',
        'Firebase',
        'Firebase Auth',
        'FCM',
        'Cloud Functions',
        'Google Sign-In',
      ],
    ),
    SkillGroup(
      title: 'Storage',
      skills: ['Hive', 'SharedPreferences', 'Flutter Secure Storage', 'MySQL'],
    ),
    SkillGroup(
      title: 'Integrations',
      skills: [
        'Google Maps',
        'KYC / eKYC',
        'PAN / Aadhaar verification',
        'Aadhaar e-sign',
        'Socket.IO',
      ],
    ),
    SkillGroup(
      title: 'Testing & tools',
      skills: [
        'Unit testing',
        'Widget testing',
        'Git',
        'Figma',
        'Rive',
        'Play Store & App Store publishing',
      ],
    ),
  ];

  /// Counted, never hardcoded.
  static int get totalSkills =>
      groups.fold(0, (sum, g) => sum + g.skills.length);

  static const List<Achievement> achievements = [
    Achievement(
      title: '12+ apps published',
      description:
          'Shipped production apps to Google Play and the App Store, working '
          'with backend and design teams.',
    ),
    Achievement(
      title: 'Used by 20+ institutions',
      description:
          'Built the MyClassAdmin ERP and its Teacher app at Prime Softech.',
      route: '/work/myclassadmin',
    ),
    Achievement(
      title: 'Real-time trading',
      description:
          'Live market dashboards and price tracking over WebSockets for a '
          'crypto exchange.',
      route: '/work/crypto-exchange',
    ),
    Achievement(
      title: 'KYC and e-sign',
      description:
          'PAN, Aadhaar and CKYC onboarding with Aadhaar e-sign for a loan '
          'origination system.',
    ),
    Achievement(
      title: 'AI quiz app',
      description:
          'Used prompt engineering to auto-generate accurate quiz answers.',
    ),
  ];
}
