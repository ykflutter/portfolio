import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_durations.dart';
import '../../features/about/about_screen.dart';
import '../../features/contact/contact_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/not_found/not_found_screen.dart';
import '../../features/skills/skills_screen.dart';
import '../../features/work/case_study_screen.dart';
import '../../features/work/work_filter.dart';
import '../../features/work/work_screen.dart';
import 'route_paths.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutePaths.home,

    // Old URLs keep working instead of landing on the 404.
    redirect: (context, state) => switch (state.uri.path) {
      '/experience' => RoutePaths.about,
      '/projects' => RoutePaths.work,
      '/writing' => RoutePaths.home,
      _ => null,
    },

    routes: [
      _fade(
        path: RoutePaths.home,
        name: 'home',
        builder: (context, _) => HomeScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.work,
        name: 'work',
        builder: (context, state) => WorkScreen(
          filter: WorkFilter.fromQuery(state.uri.queryParameters),
          onNavigate: context.go,
        ),
        routes: [
          _fade(
            path: ':slug',
            name: 'caseStudy',
            builder: (context, state) => CaseStudyScreen(
              slug: state.pathParameters['slug'] ?? '',
              onNavigate: context.go,
            ),
          ),
        ],
      ),
      _fade(
        path: RoutePaths.about,
        name: 'about',
        builder: (context, _) => AboutScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.skills,
        name: 'skills',
        builder: (context, _) => SkillsScreen(onNavigate: context.go),
      ),
      _fade(
        path: RoutePaths.contact,
        name: 'contact',
        builder: (context, _) => ContactScreen(onNavigate: context.go),
      ),
    ],

    errorPageBuilder: (context, state) => _page(
      state,
      NotFoundScreen(onNavigate: context.go),
    ),
  );

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
      pageBuilder: (context, state) => _page(state, builder(context, state)),
    );
  }

  /// Pages cross-fade and settle from 98.5% scale — a small "level load"
  /// without fighting the browser's own back behaviour.
  static CustomTransitionPage<void> _page(GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: AppDurations.medium,
      reverseTransitionDuration: AppDurations.fast,
      child: child,
      transitionsBuilder: (_, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: AppDurations.ease,
        );

        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.985, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
