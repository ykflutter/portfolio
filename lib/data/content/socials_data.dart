import '../../core/constants/app_links.dart';
import '../models/social_link.dart';

class SocialsData {
  SocialsData._();

  static const List<SocialLink> all = [
    SocialLink(
      kind: SocialKind.email,
      label: 'Email',
      value: AppLinks.email,
      url: AppLinks.mailtoConst,
    ),
    SocialLink(
      kind: SocialKind.linkedin,
      label: 'LinkedIn',
      value: 'linkedin.com/in/yash-khade',
      url: AppLinks.linkedin,
    ),
    SocialLink(
      kind: SocialKind.github,
      label: 'GitHub',
      value: 'github.com/yk-otcdesk',
      url: AppLinks.github,
    ),
    SocialLink(
      kind: SocialKind.location,
      label: 'Location',
      value: AppLinks.location,
      url: '',
    ),
  ];

  static List<SocialLink> get clickable =>
      all.where((s) => s.isLive).toList(growable: false);
}
