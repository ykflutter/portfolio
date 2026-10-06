import 'package:flutter/material.dart';

import '../models/project.dart';
import '../models/project_link.dart';
import '../models/project_metric.dart';

/// Projects.
///
/// ─────────────────────────────────────────────────────────────────────────
/// WHAT STILL NEEDS YOU
///
///  1. `screenshots` — 2-3 per project at assets/images/projects/<slug>/
///     This is the single biggest gap. A Flutter portfolio with no app
///     screenshots is a designer's portfolio with no images.
///  2. `links` — any live Play Store / App Store / GitHub URL.
///     Empty links are not rendered, so nothing breaks while they're blank.
///  3. `metrics` — one real number each. Users, downloads, a percentage,
///     a load time. These carry more weight than any description.
///  4. `role` — check each one says what YOU built, not what the team built.
///
/// Everything else is taken from your actual work history.
/// ─────────────────────────────────────────────────────────────────────────
class ProjectsData {
  ProjectsData._();

  static const List<Project> all = [
    Project(
      slug: 'task-assistant',
      title: 'Task Assistant',
      category: 'Productivity',
      tagline:
          'A scheduling and task app with a live dashboard and push reminders.',
      description:
          'A task management app built around a dashboard that updates as '
          'work moves. Tasks can be filtered and scheduled, reminders arrive '
          'as push notifications, and the interface uses Rive animations for '
          'state transitions rather than static loading states.',
      role:
          'Built the app end to end in Flutter — Riverpod state layer, the '
          'filtering and scheduling dashboard, push notification handling, '
          'and Crashlytics reporting.',
      company: 'Aaryavarta Tech',
      period: '2025 – Present',
      tech: ['Flutter', 'Riverpod', 'Firebase', 'Rive', 'Crashlytics'],
      highlights: [
        'Dashboard with task filtering and scheduling',
        'Push notifications for reminders and assignment changes',
        'Rive animations driven by app state',
        'Crash reporting wired to release builds',
      ],
      metrics: [
        // TODO: replace with a real number — active users, tasks handled,
        // crash-free rate from Crashlytics.
        ProjectMetric(value: '—', label: 'Add a metric'),
      ],
      links: [
        ProjectLink(kind: ProjectLinkKind.playStore, url: ''),
        ProjectLink(kind: ProjectLinkKind.appStore, url: ''),
      ],
      screenshots: [],
      icon: Icons.auto_awesome_motion_rounded,
      featured: true,
    ),
    Project(
      slug: 'loan-origination',
      title: 'Loan Origination App',
      category: 'Fintech',
      tagline:
          'KYC, document upload and application tracking for a lending product.',
      description:
          'A loan application app covering the journey from first form to '
          'submitted file. PAN and Aadhaar verification run against KYC '
          'provider APIs, supporting documents are uploaded and converted to '
          'PDF, and applicants and officers exchange comments on a file '
          'without leaving the app.',
      role:
          'Built the KYC verification flow, the document upload and PDF '
          'pipeline, and the in-app comment threads. Reworked the onboarding '
          'forms and search to cut abandonment.',
      company: 'Finaleap Finserv',
      period: '2024 – 2025',
      tech: ['Flutter', 'GetX', 'REST APIs', 'KYC APIs', 'PDF'],
      highlights: [
        'PAN and Aadhaar KYC against provider APIs',
        'Document upload with PDF conversion',
        'Comment threads between applicant and officer',
        'Rebuilt onboarding forms to reduce drop-off',
      ],
      metrics: [
        // TODO: the drop-off figure, if you can source it.
        ProjectMetric(value: '—', label: 'Add a metric'),
      ],
      links: [ProjectLink(kind: ProjectLinkKind.playStore, url: '')],
      screenshots: [],
      icon: Icons.account_balance_wallet_rounded,
      featured: true,
    ),
    Project(
      slug: 'otc-desk',
      title: 'OTC Desk',
      category: 'Trading',
      tagline:
          'An operations dashboard driven by live price and order streams.',
      description:
          'An administrative dashboard for over-the-counter desk operations. '
          'Prices and order state arrive over a socket connection and render '
          'without blocking the interface; sessions are held in secure '
          'storage and expire on inactivity.',
      // TODO: confirm this one. If it was personal rather than client work,
      // say so — "a side project" is a perfectly good label and more
      // believable than an unexplained client dashboard.
      role:
          'Built the real-time data layer and the dashboard interface, '
          'including socket reconnection handling and secure session storage.',
      company: 'Personal project',
      period: '2024',
      tech: ['Flutter', 'WebSockets', 'Bloc', 'Secure Storage'],
      highlights: [
        'Live price and order streaming over sockets',
        'Reconnection and backoff handling',
        'Session storage with inactivity expiry',
      ],
      links: [ProjectLink(kind: ProjectLinkKind.github, url: '')],
      screenshots: [],
      icon: Icons.show_chart_rounded,
      featured: true,
    ),
    Project(
      slug: 'geo-service',
      title: 'Location Service Platform',
      category: 'Utility',
      tagline: 'Live tracking and dispatch on Google Maps.',
      description:
          'A location-based service app with live tracking on Google Maps. '
          'Position updates stream through Firestore so dispatchers and '
          'customers see the same state, with Cloud Functions handling the '
          'work that should not run on a phone.',
      role:
          'Integrated the Google Maps SDK, built the Firestore real-time '
          'tracking layer, and shipped the app to both stores.',
      company: 'Prime Softech Solutions',
      period: '2022 – 2024',
      tech: ['Flutter', 'Google Maps', 'Firestore', 'Cloud Functions'],
      highlights: [
        'Live tracking on Google Maps',
        'Firestore listeners for shared real-time state',
        'Cloud Functions for background work',
        'Released on Play Store and App Store',
      ],
      links: [
        ProjectLink(kind: ProjectLinkKind.playStore, url: ''),
        ProjectLink(kind: ProjectLinkKind.appStore, url: ''),
      ],
      screenshots: ['assets/images/projects/geo-service/1.png'],
      icon: Icons.map_rounded,
      featured: true,
    ),
  ];

  static List<Project> get featured =>
      all.where((p) => p.featured).toList(growable: false);

  static Project? bySlug(String slug) {
    for (final p in all) {
      if (p.slug == slug) return p;
    }
    return null;
  }

  /// How many actually shipped to a store. Honest and more impressive than
  /// a vague "10+ projects".
  static int get liveAppCount => all
      .where(
        (p) => p.links.any(
          (l) =>
              l.isLive &&
              (l.kind == ProjectLinkKind.playStore ||
                  l.kind == ProjectLinkKind.appStore),
        ),
      )
      .length;
}
