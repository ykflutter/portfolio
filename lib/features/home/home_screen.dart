import 'package:flutter/material.dart';

import '../../app/router/route_paths.dart';
import '../../shared/layout/page_scaffold.dart';
import 'widgets/home_hero.dart';

/// Deliberately minimal: logo, name, "See my work", "Download Resume".
/// Everything else lives one click away.
class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      currentPath: RoutePaths.home,
      onNavigate: onNavigate,
      minimalNav: true,
      showFooter: false,
      body: HomeHero(onNavigate: onNavigate),
    );
  }
}
