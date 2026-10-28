import 'package:flutter/material.dart';

import '../../app/router/nav_destinations.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_spacing.dart';
import '../motion/interactive_backdrop.dart';
import 'footer.dart';
import 'max_width_box.dart';
import 'mobile_drawer.dart';
import 'nav_bar.dart';

/// Every page sits in one of these: dot-grid backdrop, sticky nav, scrolling
/// body, footer, and the site menu.
///
/// Pass [children] for a normal scrolling page, or [body] for a page that
/// lays out its own viewport (the home hero, the 404).
class PageScaffold extends StatefulWidget {
  final List<Widget>? children;
  final Widget? body;
  final String currentPath;
  final ValueChanged<String> onNavigate;
  final bool showFooter;

  /// Home: no brand, no inline links — theme toggle and menu only.
  final bool minimalNav;

  const PageScaffold({
    super.key,
    this.children,
    this.body,
    required this.currentPath,
    required this.onNavigate,
    this.showFooter = true,
    this.minimalNav = false,
  }) : assert(
          children != null || body != null,
          'Provide children or body',
        );

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  // Held in state, not build — a key recreated each frame can't open a drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _backToTop() {
    if (!_scroll.hasClients) return;

    if (context.reduceMotion) {
      _scroll.jumpTo(0);
      return;
    }

    _scroll.animateTo(
      0,
      duration: AppDurations.slow,
      curve: AppDurations.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MobileDrawer(
        destinations: NavDestinations.all,
        currentPath: widget.currentPath,
        onNavigate: widget.onNavigate,
      ),
      body: InteractiveBackdrop(
        child: Column(
          children: [
            NavBar(
              destinations: NavDestinations.all,
              currentPath: widget.currentPath,
              onNavigate: widget.onNavigate,
              minimal: widget.minimalNav,
              onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
            Expanded(
              // Keeps content clear of the notch when a phone is turned
              // sideways. Top is handled by the nav bar.
              child: SafeArea(
                top: false,
                bottom: false,
                child: widget.body ?? _scrollingBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollingBody() {
    return Scrollbar(
      controller: _scroll,
      child: CustomScrollView(
        controller: _scroll,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xl),
              child: MaxWidthBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.children!,
                ),
              ),
            ),
          ),
          if (widget.showFooter)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxl),
                child: AppFooter(
                  onNavigate: widget.onNavigate,
                  onBackToTop: _backToTop,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
