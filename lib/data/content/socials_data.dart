import 'package:flutter/material.dart';

import '../../core/constants/app_links.dart';
import '../models/social_link.dart';

class SocialsData {
  SocialsData._();

  static const List<SocialLink> all = [
    SocialLink(
      label: 'Email',
      value: AppLinks.email,
      url: AppLinks.mailtoConst,
      icon: Icons.email_outlined,
    ),
    SocialLink(
      label: 'GitHub',
      value: 'github.com/yk-otcdesk',
      url: AppLinks.github,
      icon: Icons.code_rounded,
    ),
    SocialLink(
      label: 'LinkedIn',
      value: 'linkedin.com/in/yash-khade',
      url: AppLinks.linkedin,
      icon: Icons.work_outline_rounded,
    ),
    SocialLink(
      label: 'Location',
      value: AppLinks.location,
      url: '',
      icon: Icons.location_on_outlined,
    ),
  ];

  static List<SocialLink> get clickable =>
      all.where((s) => s.isLive).toList(growable: false);
}
