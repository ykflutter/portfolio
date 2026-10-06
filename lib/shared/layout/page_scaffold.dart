import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_spacing.dart';
import 'footer.dart';
import 'max_width_box.dart';
import 'mobile_drawer.dart';
import 'nav_bar.dart';

/// Every page sits in one of these: sticky nav, scrolling body, footer.
///
/// Pass [slivers] for pages that need custom scroll effects; otherwise pass
/// [children] and it builds the list for you.
class PageScaffold extends StatefulWidget {
  final List<Widget>? children;
  final List<Widget>? slivers;
  final List<NavDestination> destinations;
  final String currentPath;
  final ValueChanged<String> onNavigate;
  final bool showFooter;
  final bool constrainWidth;

  const PageScaffold({
    super.key,
    this.children,
    this.slivers,
    required this.destinations,
    required this.currentPath,
    required this.onNavigate,
    this.showFooter = true,
    this.constrainWidth = true,
  }) : assert(
          children != null || slivers != null,
          'Provide children or slivers',
        );

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  // Held in state, not build — a key recreated each frame can't open a drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: context.isDesktop
          ? null
          : MobileDrawer(
              destinations: widget.destinations,
              currentPath: widget.currentPath,
              onNavigate: widget.onNavigate,
            ),
      body: Column(
        children: [
          NavBar(
            destinations: widget.destinations,
            currentPath: widget.currentPath,
            onNavigate: widget.onNavigate,
            onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                if (widget.slivers != null)
                  ...widget.slivers!
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xl),
                      child: widget.constrainWidth
                          ? MaxWidthBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.children!,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.children!,
                            ),
                    ),
                  ),
                if (widget.showFooter)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: AppSpacing.xxl),
                      child: AppFooter(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
