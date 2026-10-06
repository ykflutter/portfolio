import '../../data/content/articles_data.dart';
import '../../shared/layout/nav_bar.dart';
import 'route_paths.dart';

/// The nav links, in one place so the bar, the drawer and the footer can
/// never fall out of sync.
///
/// Writing only appears once something is actually published — a nav link to
/// an empty page is worse than no link.
class NavDestinations {
  NavDestinations._();

  static List<NavDestination> get all => [
        const NavDestination(label: 'Work', path: RoutePaths.work),
        const NavDestination(label: 'Experience', path: RoutePaths.experience),
        const NavDestination(label: 'Skills', path: RoutePaths.skills),
        if (ArticlesData.hasPublished)
          const NavDestination(label: 'Writing', path: RoutePaths.writing),
        const NavDestination(label: 'Contact', path: RoutePaths.contact),
      ];
}
