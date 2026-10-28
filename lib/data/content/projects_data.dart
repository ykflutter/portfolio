import 'package:flutter/material.dart';

import '../models/project.dart';
import '../models/project_link.dart';
import '../models/project_metric.dart';
import '../models/project_type.dart';

/// Projects, in display order. Featured ones come first.
///
/// ─────────────────────────────────────────────────────────────────────────
/// WHAT STILL NEEDS YOU (search for TODO)
///
///  1. `links`   — paste Play Store / App Store / GitHub / website URLs.
///                 Empty links are hidden, so nothing breaks while blank.
///  2. `metrics` — one real number each (downloads, users, rating).
///  3. `company` / `period` — fill in where they are still null.
///  4. `screenshotFiles` — file names inside the project's folder. A file
///                 that does not exist yet shows a placeholder.
/// ─────────────────────────────────────────────────────────────────────────
class ProjectsData {
  ProjectsData._();

  static const List<Project> all = [
    Project(
      slug: 'crypto-exchange',
      title: 'Crypto Exchange',
      type: ProjectType.fintech,
      tagline:
          'Live trading screens and market dashboards for a Bitcoin and '
          'Ethereum exchange.',
      description:
          'A mobile exchange for buying and trading Bitcoin and Ethereum. '
          'Market prices stream in over WebSockets, the dashboard tracks '
          'balances, transactions and investments, and price alerts arrive '
          'as push notifications. Users complete KYC before trading, and '
          'support tickets are handled inside the app.',
      role:
          'Built the responsive trading screens and live market dashboard, '
          'real-time price tracking over WebSockets, the REST layer on Dio '
          'with custom AppException handling, the portfolio features and the '
          'FCM price alerts.',
      company: 'Aaryavarta Technologies',
      companySlug: 'aaryavarta',
      period: '2025 – Present',
      tech: ['Flutter', 'WebSockets', 'Dio', 'REST APIs', 'FCM'],
      highlights: [
        'Real-time price tracking over WebSockets',
        'Buy and trade flow with a live market watch',
        'Portfolio: balances, transactions and investment tracking',
        'Price alerts through Firebase Cloud Messaging',
        'In-app notifications and support tickets',
      ],
      links: [
        ProjectLink(kind: ProjectLinkKind.playStore, url: ''), // TODO
        ProjectLink(kind: ProjectLinkKind.appStore, url: ''), // TODO
      ],
      folder: 'crypto_app',
      screenshotFiles: [
        'splash.png',
        'dashboard.png',
        'buy_trade.png',
        'notification.png',
        'ticket.png',
        'support.png',
        'profile.png',
      ],
      icon: Icons.currency_bitcoin_rounded,
      featured: true,
    ),
    Project(
      slug: 'cars-and-all',
      title: 'Cars & All',
      type: ProjectType.marketplace,
      tagline:
          'A vehicle marketplace with listings, chat, video calls and ratings.',
      description:
          'A marketplace for buying and selling vehicles. Sellers list a '
          'vehicle through a guided flow, buyers browse listings and open the '
          'full details, and the two sides talk through in-app chat and video '
          'calls. Ratings build trust on both sides, and the app is available '
          'in more than one language.',
      role:
          'Built the app in Flutter with BLoC: listing and detail screens, '
          'real-time chat over Socket.IO, video calling and the Firebase '
          'integration.',
      company: null, // TODO
      period: null, // TODO
      tech: ['Flutter', 'BLoC', 'Socket.IO', 'Firebase'],
      highlights: [
        'Guided flow to list a vehicle for sale',
        'Real-time chat over Socket.IO',
        'Video calls between buyer and seller',
        'Ratings and multi-language support',
      ],
      links: [
        ProjectLink(kind: ProjectLinkKind.playStore, url: ''), // TODO
      ],
      folder: 'cars_and_all',
      screenshotFiles: [
        'splash.png',
        'home.png',
        'view_all.png',
        'vheical_detail.png',
        'sell_vehical.png',
        'my_listing.png',
        'chat.png',
        'language.png',
        'profile.png',
      ],
      icon: Icons.directions_car_rounded,
      featured: true,
    ),
    Project(
      slug: 'myclassadmin',
      title: 'MyClassAdmin',
      type: ProjectType.education,
      tagline:
          'A school ERP with an admin app and a teacher app, used by 20+ '
          'institutions.',
      description:
          'An ERP for schools and coaching institutes, delivered as two '
          'apps: MyClassAdmin for administrators and a Teacher app for staff. '
          'It is in use at more than 20 institutions.',
      role:
          'Built UI and business logic with Provider and GetX, integrated '
          'REST APIs and Firebase, and published the apps to Google Play and '
          'the App Store.',
      company: 'Prime Softech Solutions',
      companySlug: 'prime-softech',
      period: '2022 – 2024',
      tech: ['Flutter', 'Provider', 'GetX', 'REST APIs', 'Firebase'],
      highlights: [
        'In use at 20+ institutions',
        'Separate apps for administrators and teachers',
        'Published on Google Play and the App Store',
      ],
      metrics: [ProjectMetric(value: '20+', label: 'Institutions')],
      links: [
        ProjectLink(kind: ProjectLinkKind.playStore, url: ''), // TODO
        ProjectLink(kind: ProjectLinkKind.appStore, url: ''), // TODO
      ],
      folder: 'myclassadmin',
      screenshotFiles: [], // TODO: add file names when images are ready
      icon: Icons.school_rounded,
      featured: true,
    ),
    Project(
      slug: 'agora-call-chat',
      title: 'Agora Call & Chat',
      type: ProjectType.communication,
      tagline: 'Real-time chat with audio and video calling on Agora.',
      description:
          'A communication app with sign-up, profiles, real-time chat, and '
          'one-to-one audio and video calls powered by the Agora SDK.',
      // TODO: confirm this describes your part of the work.
      role:
          'Built the sign-up and login flow, the chat screens, and the audio '
          'and video calling experience on the Agora SDK.',
      tech: ['Flutter', 'Agora SDK'],
      highlights: [
        'Login and registration',
        'Real-time chat',
        'Audio calls',
        'Video calls',
      ],
      folder: 'agora_call_chat',
      screenshotFiles: [
        'login.png',
        'register.png',
        'chat.png',
        'audio_call.png',
        'video_call.png',
        'profile.png',
      ],
      icon: Icons.videocam_rounded,
      featured: true,
    ),
    Project(
      slug: 'collection-tracker',
      title: 'Collection Tracker',
      type: ProjectType.fintech,
      tagline: 'Tracks overdue payments and cheque collections for a lender.',
      description:
          'A collections app for a lending business. Staff see overdue '
          'payments and cheques, record collections, attach PDFs and photos '
          'as proof, and search across accounts.',
      role:
          'Built the collection flows, PDF and image upload, search, and the '
          'REST integration with validation and error handling.',
      company: 'Finaleap Finserv',
      companySlug: 'finaleap',
      period: '2024 – 2025',
      tech: ['Flutter', 'REST APIs', 'PDF'],
      highlights: [
        'Overdue payment and cheque tracking',
        'PDF and image upload as proof of collection',
        'Search across accounts',
      ],
      folder: 'collection_app',
      screenshotFiles: [], // TODO
      icon: Icons.account_balance_wallet_rounded,
    ),
    Project(
      slug: 'maha-paryavaran',
      title: 'Maha Paryavaran',
      type: ProjectType.publicSector,
      tagline: 'An app for filing and tracking environmental complaints.',
      description:
          'A public-sector app for reporting environmental issues. Citizens '
          'file a complaint, follow its status in their complaint list, and '
          'open the full record with every detail. Help, contact details and '
          'terms are available inside the app.',
      // TODO: confirm this describes your part of the work.
      role:
          'Built the app in Flutter: complaint filing, the complaint list and '
          'detail views, and the help, contact and settings screens.',
      tech: ['Flutter', 'REST APIs'],
      highlights: [
        'File a new complaint in a few steps',
        'Track every complaint and its status',
        'Full complaint record with all details',
      ],
      folder: 'maha_paryavarn',
      screenshotFiles: [
        'splash.png',
        'login.png',
        'home.png',
        'new_complaint.png',
        'complaint_list.png',
        'all_details.png',
        'help.png',
        'contact.png',
        'settings.png',
        'terms.png',
      ],
      icon: Icons.eco_rounded,
    ),
    Project(
      slug: 'paw-universe',
      title: 'The Paw Universe',
      type: ProjectType.web,
      platform: ProjectPlatform.web,
      tagline:
          'A pet care website for boarding, grooming and bookings, hosted on '
          'Firebase.',
      description:
          'A website for a pet care business covering boarding, grooming, '
          'events and a pet taxi, with booking and contact pages. Built with '
          'Flutter Web and hosted on Firebase.',
      role:
          'Designed and built the site in Flutter Web and deployed it on '
          'Firebase Hosting.',
      tech: ['Flutter Web', 'Firebase Hosting'],
      highlights: [
        'Service pages for boarding and grooming',
        'Events and pet taxi',
        'Booking and contact flow',
        'Hosted on Firebase',
      ],
      links: [
        ProjectLink(kind: ProjectLinkKind.website, url: ''), // TODO
      ],
      folder: 'pet_care',
      screenshotFiles: [
        'splash.png',
        'home.png',
        'sevice.png',
        'pool.png',
        'event.png',
        'taxi.png',
        'about.png',
        'contact.png',
      ],
      icon: Icons.pets_rounded,
    ),
    Project(
      slug: 'flutter-bazaar',
      title: 'Flutter Bazaar',
      type: ProjectType.education,
      tagline: 'A Flutter interview prep app with Q&A, topics and mini-games.',
      description:
          'An app for preparing for Flutter interviews. Questions and answers '
          'are grouped by topic, and mini-games turn revision into short '
          'practice rounds.',
      // TODO: confirm this describes your part of the work.
      role: 'Built the app end to end in Flutter.',
      tech: ['Flutter', 'Dart'],
      highlights: [
        'Interview questions and answers',
        'Grouped by topic',
        'Mini-games for quick practice',
      ],
      folder: 'flutter_bazaar',
      screenshotFiles: [], // TODO
      icon: Icons.quiz_rounded,
    ),
    Project(
      slug: 'step-counter',
      title: 'Step Count App',
      type: ProjectType.health,
      // TODO: replace with your own description of this app.
      tagline: 'A step counter that tracks daily activity.',
      description:
          'Counts steps through the day and shows daily activity at a glance.',
      role: 'Built the app in Flutter.', // TODO
      tech: ['Flutter'],
      folder: 'step_count_app',
      screenshotFiles: [], // TODO
      icon: Icons.directions_walk_rounded,
    ),
  ];

  static Project? bySlug(String slug) {
    for (final p in all) {
      if (p.slug == slug) return p;
    }
    return null;
  }

  /// The project after [current], wrapping round to the first.
  static Project nextAfter(Project current) {
    final i = all.indexWhere((p) => p.slug == current.slug);
    return all[(i + 1) % all.length];
  }

  /// Types that actually have a project — the filter bar shows only these.
  static List<ProjectType> get types => [
        for (final type in ProjectType.values)
          if (all.any((p) => p.type == type)) type,
      ];

  static int countOfType(ProjectType type) =>
      all.where((p) => p.type == type).length;

  /// True when at least one project lists [name] in its tech — skill chips
  /// only become links when there is something to show.
  static bool usesTech(String name) => all.any((p) => p.usesTech(name));

  static int countForCompany(String slug) =>
      all.where((p) => p.companySlug == slug).length;
}
