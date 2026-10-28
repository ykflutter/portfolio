import '../models/experience.dart';
import '../models/skill_group.dart';

/// Work history, taken from the resume. Newest first.
class ExperienceData {
  ExperienceData._();

  static final List<Experience> all = [
    Experience(
      title: 'Flutter Developer',
      company: 'Aaryavarta Technologies',
      slug: 'aaryavarta',
      location: 'Pune, India',
      startDate: DateTime(2025, 4),
      points: [
        'Built responsive trading screens and live market dashboards for a '
            'Bitcoin and Ethereum exchange.',
        'Implemented real-time price tracking with WebSockets, REST APIs and '
            'Dio, with custom AppException handling.',
        'Built portfolio features (balances, transactions, investment '
            'tracking) with FCM price alerts.',
        'Built an AI quiz app using prompt engineering to auto-generate '
            'accurate answers.',
      ],
      tech: ['WebSockets', 'Dio', 'REST APIs', 'FCM'],
    ),
    Experience(
      title: 'Flutter Developer',
      company: 'Finaleap Finserv Pvt. Ltd.',
      slug: 'finaleap',
      location: 'Pune, India',
      startDate: DateTime(2024, 6),
      endDate: DateTime(2025, 4),
      points: [
        'Built KYC onboarding (PAN, Aadhaar, CKYC) and Aadhaar e-sign '
            'workflows for a Loan Origination System (LOS).',
        'Developed a collections app to track overdue payments and cheques, '
            'with PDF and image upload and search.',
        'Integrated REST APIs and refactored financial forms with validation '
            'and error handling for reliable workflows.',
      ],
      tech: ['REST APIs', 'KYC / eKYC', 'Aadhaar e-sign', 'PDF'],
    ),
    Experience(
      title: 'Junior Flutter Developer',
      company: 'Prime Softech Solutions Pvt. Ltd.',
      slug: 'prime-softech',
      location: 'Pune, India',
      startDate: DateTime(2022, 1),
      endDate: DateTime(2024, 6),
      points: [
        'Built Flutter apps for Android and iOS, including an ERP '
            '(MyClassAdmin, Teacher) used by 20+ institutions.',
        'Implemented UI and business logic with Provider and GetX, REST APIs, '
            'Firebase and Google Maps.',
        'Published 12+ production apps on Google Play and App Store, '
            'collaborating with backend and design teams.',
      ],
      tech: ['Provider', 'GetX', 'Firebase', 'Google Maps'],
    ),
  ];

  /// Career start — everything date-derived counts from here, so the
  /// "years of experience" number can never go stale.
  static DateTime get careerStart => all.last.startDate;

  static Experience? bySlug(String slug) {
    for (final e in all) {
      if (e.slug == slug) return e;
    }
    return null;
  }

  static const List<Credential> credentials = [
    Credential(
      kind: 'Education',
      title: 'Master of Computer Science (MCS)',
      institution: 'Asian College, Pune',
      period: '2022',
    ),
    Credential(
      kind: 'Certification',
      title: 'Flutter Development',
      institution: 'Chedo Tech Institute',
      period: 'Sep 2022 – Dec 2022',
    ),
  ];
}
