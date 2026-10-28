import 'route_paths.dart';

class NavDestination {
  final String label;
  final String path;

  const NavDestination({required this.label, required this.path});
}

/// The nav links, in one place so the bar, the menu and the footer can never
/// fall out of sync.
class NavDestinations {
  NavDestinations._();

  static const NavDestination home =
      NavDestination(label: 'Home', path: RoutePaths.home);

  static const List<NavDestination> all = [
    NavDestination(label: 'My Work', path: RoutePaths.work),
    NavDestination(label: 'About Me', path: RoutePaths.about),
    NavDestination(label: 'Skills & Tools', path: RoutePaths.skills),
    NavDestination(label: 'Get in Touch', path: RoutePaths.contact),
  ];
}
