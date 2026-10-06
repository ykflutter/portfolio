import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_durations.dart';
import '../../features/contact/contact_screen.dart';
import '../../features/experience/experience_screen.dart';
import '../../features/gallery/component_gallery_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/projects/project_detail_screen.dart';
import '../../features/projects/projects_screen.dart';
import '../../features/skills/skills_screen.dart';
import '../../features/writing/writing_screen.dart';
import 'route_paths.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutePaths.home,
    routes: [
      _fade(
        path: RoutePaths.home,
        name: 'home',
        builder: (context, _) => HomeScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.work,
        name: 'work',
        builder: (context, _) => ProjectsScreen(onNavigate: context.go),
        routes: [
          _fade(
            path: ':slug',
            name: 'workDetail',
            builder: (context, state) => ProjectDetailScreen(
              slug: state.pathParameters['slug'] ?? '',
              onNavigate: context.go,
            ),
          ),
        ],
      ),
      _fade(
        path: RoutePaths.experience,
        name: 'experience',
        builder: (context, _) => ExperienceScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.skills,
        name: 'skills',
        builder: (context, _) => SkillsScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.writing,
        name: 'writing',
        builder: (context, _) => WritingScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.contact,
        name: 'contact',
        builder: (context, _) => ContactScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.components,
        name: 'components',
        builder: (context, state) => ComponentGalleryScreen(
          currentPath: state.uri.path,
          onNavigate: context.go,
        ),
      ),
    ],
    errorBuilder: (context, state) => HomeScreen(onNavigate: context.go),
  );

  /// Pages cross-fade. Slide transitions read as an app and fight the
  /// browser's own back behaviour.
  static GoRoute _fade({
    required String path,
    required String name,
    required Widget Function(BuildContext, GoRouterState) builder,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      name: name,
      routes: routes,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: AppDurations.medium,
        reverseTransitionDuration: AppDurations.fast,
        child: builder(context, state),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: AppDurations.ease,
          ),
          child: child,
        ),
      ),
    );
  }
}
