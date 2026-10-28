import 'package:flutter/material.dart';

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

/// /contact — a form that opens the visitor's mail app pre-filled, plus
/// direct links.
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SocialLinksColumn(),
        Gap(AppSpacing.md),
        AvailabilityCard(),
      ],
    );

    return PageScaffold(
      currentPath: RoutePaths.contact,
      onNavigate: widget.onNavigate,
      children: [
        const RevealOnScroll(
          child: SectionHeader(
            label: 'Get in touch',
            title: "Let's build something.",
            subtitle:
                'Tell me about the role or the project. I usually reply '
                'within a day.',
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
              const Expanded(flex: 2, child: RevealOnScroll(child: side)),
            ],
          )
        else ...[
          RevealOnScroll(child: form),
          const Gap(AppSpacing.xxl),
          const RevealOnScroll(child: side),
        ],
      ],
    );
  }
}
