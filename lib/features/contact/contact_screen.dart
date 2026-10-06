import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../app/router/route_paths.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/layout/page_scaffold.dart';
import '../../shared/motion/reveal_on_scroll.dart';
import '../../shared/text/section_header.dart';
import 'contact_controller.dart';
import 'widgets/availability_card.dart';
import 'widgets/contact_form.dart';
import 'widgets/social_links_column.dart';

class ContactScreen extends StatefulWidget {
  final ValueChanged<String> onNavigate;

  const ContactScreen({super.key, required this.onNavigate});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactController _controller = ContactController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => ContactForm(controller: _controller),
    );

    const side = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SocialLinksColumn(),
        Gap(AppSpacing.md),
        AvailabilityCard(),
      ],
    );

    return PageScaffold(
      destinations: NavDestinations.all,
      currentPath: RoutePaths.contact,
      onNavigate: widget.onNavigate,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Get in touch',
            title: 'Let us talk.',
            subtitle: 'Tell me what you are building. I reply within a day.',
            large: true,
          ),
        ),
        const Gap(AppSpacing.xxl),
        if (context.isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: RevealOnScroll(child: form)),
              const Gap.h(AppSpacing.xxl),
              const Expanded(flex: 2, child: side),
            ],
          )
        else ...[
          RevealOnScroll(child: form),
          const Gap(AppSpacing.xxl),
          side,
        ],
      ],
    );
  }
}
